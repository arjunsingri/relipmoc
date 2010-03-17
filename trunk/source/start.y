%{
#include"relipmoC.h"
#include"floatstack.h"
#include<stack>
using namespace std;
#define YYSTACKSIZE 20000
/* change the prototype for "yyparse" */
#define YYPARSE_PARAM
#define YYPARSE_PARAM_TYPE LabelTab &curLabelTab, BlockTab &curBlockTab

extern bool VERBOSE;
extern StringTab curStringTab;
extern SymTab curSymTab;
extern FuncTab curFuncTab;

SYMTYPE opcode;
extern int yylex( void );
extern int yylineno;               //line number from start.l

FloatStack floatStack;

static string curName;
static string curInstr;
static string cmpOp1, cmpOp2; //comparison type
static bool SAW_JUMP;
static BasicBlock *curBlock;
static bool isStatic = false;
ActRecord *curActRecord;	//to be shared with yylex( )
static bool seenOnce;
static stack< SymInfo > prototype;
const string &EAX = "%eax";
const string &EDX = "%edx";

Array tempArray;
const string indexForm( const SymInfo &array, const SymInfo &regs )
{
	return array.getName( ) + "[" + regs.getValue( ) + "]";
}

%}

%union {
	char name[ 100 ];
	int num;
	SYMTYPE type;
}

//memory locations
%token<name> NAME ADDRESSNAME STATICNAME
%token<num> STACKVAR
%token<name> POINTER ARRAYNAME

//registers
%token<name> REGSL REGSW REGSB
%token<name> REGS
%token ESP EBP PTRESP

//floating point register
%token<num> FLOATREG

//instructions which test the flag register
%token<name> CJMP CSET
%token JMP

//related to strings
%token<num> STRINGLABEL
%token<name> STR
%token STRSECTION

%token<name>DTYPE 

%token<num> NUM LABEL
%token<name> HEXNUM

%token GLOBAL TYPE SIZE ZERO LOCAL END COMM 

%token OBJECT FUNCTION FUNCEND

/***************arithmetic instructions******************/
//floating addtion
%token FADDS FADDL
%token<type> FADD

%token FADDP

%token FIADDS FIADDL
%token<type> FIADD

//floating subtraction
%token FSUBS FSUBL 
%token<type> FSUB

%token FSUBP

%token FSUBRS FSUBRL
%token<type> FSUBR

%token FSUBRP

//multiplication
%token MULL IMULL MULB
//floating point multiplication
%token<type> FMUL

%token FMULP

//division
%token IDIVL DIVL

//floating point division
%token FDIVL FDIVS
%token<type> FDIV

%token FDIVP FDIVR FDIVRP

//increment and decrement
%token<type> INC DEC

//fabs:find absolute value of st; fchs:change sign
%token FABS FCHS

//bitwise operations
%token<type> TEST NOT NEG

//stack instructions
%token PUSHL POPL

//data movement instructions
%token MOVZBL MOVSBL MOVSBW MOVSWL

%token<type> MOVBL MOVBW MOVWL

%token<type> MOV

//floating point store
%token FSTS FSTTL
%token<type> FST

%token FSTPS FSTPL
%token<type> FSTP

%token FISTPS FISTPL FISTPLL
%token<type> FISTP

%token FISTS FISTL
%token<type> FIST

//floating point load
%token FLDS
%token<type> FLD

%token FILDL FILDS
%token<type> FILD

//load 1 and 0
%token FLD1 FLDZ

//exchange
%token FXCH

//comparison instructions
%token<type> CMP

//floating point comparison
%token FNSTSW	//store status register
%token FUCOMPP 
%token	FNSTCW //store control register
%token	FLDCW //load control register

%token<name> OPCODE
//function call instructions
%token CALL

%token<name>LEAL SUM

%nonassoc LOW		//associate precedence
%nonassoc FLDCW

%%

decl	: GLOBAL NAME {
		curSymTab.insert( $2, SymInfo( ) );
		curSymTab[ $2 ]._seen = true;
	} type
        
	| {
		/* globl qualifier missing */
		/*function or object is static*/
		isStatic = true;
	} type
        
	| STRINGLABEL ':' STRSECTION STR {
		curStringTab.insert( $1, $4 );
	} decl
	
	| STRINGLABEL ':' DTYPE NUM {

		curName.assign( itoa( $1 ) ) ;
		curSymTab.insert( curName, SymInfo( ) );
		curSymTab[ curName ].isTemp = true;
		curSymTab[ curName ].modValue( convert2Float( $4 ) );
	} decl 

	| LOCAL NAME {
		curSymTab.insert( $2, SymInfo( ) );
		curSymTab[ $2 ].makStatic( );
	} decl

	| COMM NAME NUM NUM {
		SymInfo &var = curSymTab[ $2 ];
		curSymTab.insert( $2, SymInfo( ) );
		var.modSize( $3 );
		var._seen = true;
		if ( $3 != $4 )
			var.makArray( );
        } decl
	
	| COMM NAME NUM NUM NUM {
		curSymTab.insert( $2, SymInfo( ) );
		curSymTab[ $2 ].modSize( $3 );
		curSymTab[ $2 ].makLocal( );
	} decl

/*  end of the program */
	| END {
		return 0;
	}
	;

type :   TYPE NAME OBJECT size
	|TYPE NAME FUNCTION process_func
	;

size    : SIZE NAME NUM {
			if ( isStatic ) {
				curSymTab.insert( $2, SymInfo( ) );
				curSymTab[ $2 ].makStatic( );
				isStatic = false;
			}
			curSymTab[ $2 ].modSize( $3 );
	} initialize
	
	| STRINGLABEL ':' {
		/* this label is assigned a constant value */
		curName.assign( itoa( $1 ) ) ;
		curSymTab[ curName ].isTemp = true;
	} initializers
	;

initialize 	:  NAME ':' {
			curName.assign( $1 );
		} initializers //start initialzing
		;
                                                                                
initializers    : DTYPE NUM {
			SymInfo &var = curSymTab[ curName ];
			var.modType( str2e( $1 ) );
			var.modInitValue( itoa( $2 ) );
			if ( string( $1 ) == "byte" )
				var.fixType( str2e( $1 ) );
		} initializers

		| decl  //ready to read the next symbol
		;

process_func: NAME ':' {
			if ( VERBOSE ) {
				verbose( ( "Found function \"" 
					+ string( $1 )
					+ "\"" ).c_str( ) );
				verbose( "\tStarting Data Flow Analysis" );
			}
			seenOnce = false;
			curBlockTab.funcName = $1;
			curActRecord = &curFuncTab[ $1 ];
			curSymTab.insert( $1, SymInfo( ) );
			if ( isStatic == true ) {
				curSymTab[ $1 ].makStatic( );
				isStatic = false;
			}
			curSymTab[ $1 ].modType( FUNC );
			curBlock = BasicBlock::getNewBlock( );
		} read
		;

/* read each instruction and process it */ 
                                                                                
read: LABEL ':' {
			curLabelTab.insert( $1, curBlockTab.curBlockNum + 1 );
			if( SAW_JUMP != true )curBlockTab.insert(curBlock, $1);
			curBlock = BasicBlock::getNewBlock( );
			++curBlockTab.curBlockNum;
			SAW_JUMP = false;
		} read
		
		| JMP LABEL  {
			curBlockTab.insert( curBlock, $2 );
			SAW_JUMP= true;
		} read
		
		| CJMP LABEL {
			int t = LabelTab::tempLabel( );
			curLabelTab.insert( t, curBlockTab.curBlockNum + 1 );
			curBlock -> leftOp( cmpOp1 );
			curBlock -> rightOp( cmpOp2 );
			curBlock -> cmpOperator( $1 );
			curBlockTab.insert( curBlock, $2, t );
			curBlock = BasicBlock::getNewBlock( );
			curBlockTab.curBlockNum++;
		} read
		
		| CSET REGS {
			curSymTab[ $2 ].modValue( "(" + cmpOp1 
						+ convert( $1 ) 
						+ cmpOp2 + ")"
						);
		} read
		
		| CSET NAME {
			curInstr = curSymTab[ $2 ].getName( )
					+ "= " 
					+ cmpOp1 + convert( $1 ) + cmpOp2;
			curBlock -> insert( curInstr + ";" );
		} read

		| INC REGS {
			SymInfo &regs = curSymTab[ $2 ];
			regs.modValue( "(" + regs.getValue( ) +  ")+1" );
			regs.modType( $1 );
		} read

		| INC NAME {
			curInstr = "++" + curSymTab[ $2 ].getName( ) ;
			curBlock -> insert( curInstr + ";" );
			curSymTab[ $2 ].fixType( $1 );
		} read
		
		| INC STACKVAR {
	
			SymInfo &var = ( *curActRecord )[ $2 ];	
			curInstr = "++" + var.getName( ) ;
			curBlock -> insert( curInstr + ";" );
			var.fixType( $1 );
                } read

		| INC POINTER {
	
			SymInfo *&pt = curSymTab[ $2 ].reference;
			curInstr = "++" + pt -> getName( );
			curBlock -> insert( curInstr + ";" );
			pt -> fixType( $1 );

		} read

		| INC ARRAYNAME NUM {

			SymInfo &var = curSymTab[ $2 ];
			var.makArray( );
			var.fixType( $1 );
			int arrayIndex = $3 / sizeOfType( $1 );
			curInstr = "++" + var.getName( ) 
					+ "[ " + itoa( arrayIndex ) + " ]";
			curBlock -> insert( curInstr + ";" );
		} read

		| INC ARRAYNAME {

			SymInfo &var = curSymTab[ $2 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			var.makArray( );
			var.fixType( $1 );
			curInstr = "++" + var.getName( ) 
					+ "[ " + regs.getValue( ) + " ]";
			curBlock -> insert( curInstr + ";" );
		} read

		| DEC REGS {
                                                                                
			SymInfo &regs = curSymTab[ $2 ];
			regs.modValue( "((" + regs.getValue( ) + ")-1) " ) ;
			regs.modType( $1 );		
                } read

                | DEC NAME {
			curInstr = "--" + curSymTab[ $2 ].getName( );
			curBlock -> insert( curInstr + ";" );
			curSymTab[ $2 ].fixType( $1 );
		} read
                
		| DEC STACKVAR {

			SymInfo &var = ( *curActRecord )[ $2 ];	
                        curInstr = "--" + var.getName( );
                        curBlock -> insert( curInstr + ";" );
                        var.fixType( $1 );
			
                } read

		| DEC POINTER {

			SymInfo *&pt = curSymTab[ $2 ].reference;
			curInstr = "--" + pt -> getName( );
			curBlock -> insert( curInstr + ";" );
			pt -> fixType( $1 );

		} read

		| DEC ARRAYNAME NUM {

			SymInfo &var = curSymTab[ $2 ];
			var.makArray( );
			var.fixType( $1 );
			int arrayIndex = $3 / sizeOfType( $1 );
			curInstr = "--" + var.getName( ) 
					+ "[ " + itoa( arrayIndex ) + " ]";
			curBlock -> insert( curInstr + ";" );
		} read

		| DEC ARRAYNAME {

			SymInfo &var = curSymTab[ $2 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			var.makArray( );
			var.fixType( $1 );
			curInstr = "--" + var.getName( ) 
					+ "[ " + regs.getValue( ) + " ]";
			curBlock -> insert( curInstr + ";" );
		} read

                | NEG REGS {
			SymInfo &regs = curSymTab[$2];
			regs.modValue( " -(" + regs.getValue( ) + ")" );
			regs.modType( $1 );		
                } read

                | NEG NAME {
			SymInfo &var = curSymTab[ $2 ];
			curInstr = var.getName( ) + "= -" + var.getName( );
			curBlock -> insert( curInstr + ";" );
			var.fixType( $1 );
                } read
                                                                                
                | NEG STACKVAR {
		
			SymInfo &var = curActRecord -> at( $2 );
			curInstr = var.getName( ) + "= -" + var.getName( );
			curBlock -> insert( curInstr + ";" );
			var.fixType( $1 );
			
                } read
		
		| NEG ARRAYNAME {

			SymInfo &array = curSymTab[ tempArray.name ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			array.makArray( );
			array.fixType( $1 );
			const string &iForm = indexForm( array, regs );
			curInstr = iForm + "= -" + iForm;
			curBlock -> insert( curInstr + ";" );
		} read

		| NEG POINTER {
			SymInfo *&var = curSymTab[ $2 ].reference;
			curInstr = var -> getName( ) + "= -" +var -> getName( );
			curBlock -> insert( curInstr + ";" );
			var -> fixType( $1 );
		} read

                | NOT REGS {
			SymInfo &regs = curSymTab[ $2 ];
			regs.value = "~(" + regs.getValue( ) + ")";
			regs.modType( $1 );		
                } read

		| NOT NAME {

			const string &name = curSymTab[ $2 ].getName( );
                        curInstr = name + "= ~" + name;
                        curBlock -> insert( curInstr + ";" );
			curSymTab[ $2 ].fixType( $1 );

                } read
                                                                         
                | NOT STACKVAR {
			SymInfo &var = ( *curActRecord )[ $2 ];
                        curInstr = var.getName( ) + "= ~" + var.getName( );
                        curBlock -> insert( curInstr + ";" );
			var.fixType( $1 );

                } read

		| NOT ARRAYNAME {

			SymInfo &array = curSymTab[ tempArray.name ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			array.makArray( );
			array.fixType( $1 );
			const string &iForm = indexForm( array, regs );
			curInstr = iForm + "= ~" + iForm;
			curBlock -> insert( curInstr + ";" );
		} read

                | NOT POINTER {
		
			SymInfo *&var = curSymTab[ $2 ].reference;
                        curInstr = var -> getName( ) + "= ~"+ var -> getName( );
                        curBlock -> insert( curInstr + ";" );
			var -> fixType( $1 );

                } read

		| OPCODE REGS REGS {

			SymInfo &regs1 = curSymTab[ $2 ];
			SymInfo &regs2 = curSymTab[ $3 ];
			regs2.modValue( "(" + regs2.getValue( ) + ")"
					+ string( $1 )
				+ "(" + regs1.getValue( ) + ")"
				);
			regs2.modType( opcode );
			regs1.modType( opcode );
			
		} read

		| OPCODE REGS NAME {
			
			SymInfo &regs = curSymTab[ $2 ];
			SymInfo &var = curSymTab[ $3 ];
			curInstr = var.getName( ) + string( $1 ) + "=" +
						regs.getValue( );
			
			curBlock -> insert( curInstr + ";" );
			var.modType( opcode );
			regs.modType( opcode );
                } read

                | OPCODE NAME REGS {

			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curSymTab[ $2 ];
			regs.modValue( "(" + regs.getValue( ) + ")" 
					+ string( $1 ) 
					+ var.getName( )
				);
			var.modType( opcode );
			regs.modType( opcode );
                } read
	
		| OPCODE NUM NAME  {
			curInstr = curSymTab[ $3 ].getName( ) + string( $1 ) 
							+ "=" + itoa( $2 ) ;
			curBlock -> insert( curInstr + ";" );
                }  /*do NAME = NAME + NUM*/read
	
		| OPCODE REGS ARRAYNAME {
			
			SymInfo &array = curSymTab[ tempArray.name ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			SymInfo &destRegs = curSymTab[ $2 ];
			
			curInstr = indexForm( array, regs ) +
				string( $1 ) + "= " + destRegs.getValue( );
			
			array.modType( opcode );
			array.makArray( );
			destRegs.modType( opcode );
			curBlock -> insert( curInstr + ";" );
                } read

		| OPCODE ARRAYNAME REGS {

			SymInfo &array = curSymTab[ $2 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			SymInfo &destRegs = curSymTab[ $3 ];

			array.makArray( );
			array.modType( opcode );
			
			destRegs.modValue( "(" + destRegs.getValue( ) + ")"
					+ string( $1 )
					+ indexForm( array, regs )
				);
		} read

		| OPCODE NUM ARRAYNAME  {
		
			SymInfo &array = curSymTab[ tempArray.name ];
			curInstr = 
				indexForm( array, curSymTab[ tempArray.regs ] ) 
					+ string( $1 ) + "=" + itoa( $2 );

			array.makArray( );
			curBlock -> insert( curInstr + ";" );
			
                }  /*do NAME = NAME + NUM*/read
	
		| OPCODE ADDRESSNAME REGS {

			SymInfo &var = curSymTab[ $2 ];
			SymInfo &regs = curSymTab[ $3 ];
			const string &index = regs.getValue( ) + "/" 
					+ itoa( sizeOfType( var.getType( ) ) );
			regs.modValue( "&" + var.getName( ) 
				+ "[" + index + "]" );
			var.makArray( );
			var.modType( opcode );
		} read
		
 		| OPCODE REGS STACKVAR {

			SymInfo &regs = curSymTab[ $2 ];
			SymInfo &var = curActRecord -> at( $3 );
			curInstr = var.getName( ) + string( $1 ) 
					+ "=" + curSymTab[ $2 ].getValue( );	
			curBlock -> insert( curInstr + ";" );
			var.modType( opcode );
			regs.modType( opcode );
		} read
 
 		| OPCODE STACKVAR REGS {
		
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curActRecord -> at( $2 );
			regs.modValue( "(" + regs.getValue( ) + ")" 
					+ string( $1 ) + var.getName( )
				);
			var.modType( opcode );
			regs.modType( opcode );
		} read
 
 		| OPCODE NUM STACKVAR  {
			SymInfo &var = curActRecord -> at( $3 );
			curInstr = var.getName( ) + string( $1 ) 
							+ "=" + itoa( $2 ) ;
			curBlock -> insert( curInstr + ";" );
                
		}  /*do NAME = NAME + NUM*/read

		| OPCODE REGS POINTER {

			SymInfo &regs = curSymTab[ $2 ];
			SymInfo *&var = curSymTab[ $3 ].reference;
			curInstr = var -> getName( ) + string( $1 ) + "=" +
					curSymTab[ $2 ].getValue( );
			curBlock -> insert( curInstr + ";" );
			var -> modType( opcode );
			regs.modType( opcode );
		} read
 
 		| OPCODE POINTER REGS {
		
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo *&var = curSymTab[ $2 ].reference;
			regs.modValue( "(" + regs.getValue( ) + ")" 
					+ string( $1 ) + var -> getName( )
				);
			var -> modType( opcode );
			regs.modType( opcode );
		} read
		
 		| OPCODE NUM POINTER  {
			
			SymInfo *&var = curSymTab[ $3 ].reference;
			curInstr = var -> getName( ) + string( $1 )
							+ "=" + itoa( $2 ) ;
			curBlock -> insert( curInstr + ";" );
			var -> modType( opcode );
			
                }  /*do NAME = NAME + NUM*/read
                                                                          
                | OPCODE NUM REGS {
		
			SymInfo &regs = curSymTab[ $3 ];
			regs.modValue( 
					"(" + regs.getValue( ) + ")" 
					+ string( $1 ) + itoa($2)
				     );
			regs.modType( opcode );
                } read
                                                                                
		| OPCODE NUM NAME NUM {
		
			SymInfo &var = curSymTab[ $3 ];
			curInstr = var.getName( ) + "= -" + var.getName( );
			curBlock -> insert( curInstr + ";" );
			var.fixType( FLOAT );
		} read

		| IDIVL NAME {
			SymInfo &var = curSymTab[ $2 ];
			SymInfo &eax = curSymTab[ EAX ];
			curSymTab[ EDX ].modValue( "(" + eax.getValue( ) + ")"
					+ "%" + var.getName( )
					);
					
			eax.modValue( "(" + eax.getValue( ) + ")"
					+ "/" + var.getName( )
					);
			var.modType( LONG );
		} read

		| IDIVL ARRAYNAME {

			SymInfo &array = curSymTab[ $2 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			SymInfo &eax = curSymTab[ EAX ];

			array.makArray( );
			array.modType( LONG );

			const string &iForm = indexForm( array, regs );

			curSymTab[ EDX ].modValue( "(" + eax.getValue( ) + ")"
						+ "%" + iForm );
						
			eax.modValue( "(" + eax.getValue( ) + ")"
					+ "/" + iForm );
		} read

		| IDIVL STACKVAR {
		
			SymInfo &eax = curSymTab[ EAX ];
			SymInfo &var = curActRecord -> at( $2 );
			
			curSymTab[ EDX ].modValue( 
					"(" + eax.getValue( ) + ")"
					+ "%" + var.getName( )
					);
					
			eax.modValue( "(" + eax.getValue( ) + ")"
					+ "/" + var.getName( )
				);
			var.modType( LONG );
		} read
		
		| IDIVL REGS {

			SymInfo &regs = curSymTab[ $2 ];
			curSymTab[ EDX ].modValue( 
					"(" + curSymTab[ EAX ].getValue( ) + ")"
						+ "%" + regs.getValue( )
					);
			curSymTab[ EAX ].modValue( 
					"(" + curSymTab[ EAX ].getValue( ) + ")"
					+ "/" + regs.getValue( )
				);
			regs.modType( LONG );
		} read

//unsigned division
		| DIVL NAME {

			SymInfo &var = curSymTab[ $2 ];	
			curSymTab[ EDX ].modValue( 
					"(" + curSymTab[ EAX ].getValue( ) + ")"
					+ "%" + var.getName( )
					);
			curSymTab[ EAX ].modValue( 
					"(" + curSymTab[ EAX ].getValue( ) + ")"
					+ "/" + var.getName( )
					);
			var.modType( LONG );
			var.makUnsigned( );
		} read

		| DIVL ARRAYNAME {

			SymInfo &array = curSymTab[ $2 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			SymInfo &eax = curSymTab[ EAX ];

			array.makArray( );
			array.makUnsigned( );
			array.modType( LONG );

			const string &iForm = indexForm( array, regs );

			curSymTab[ EDX ].modValue( "(" + eax.getValue( ) + ")"
						+ "%" + iForm );
						
			eax.modValue( "(" + eax.getValue( ) + ")"
					+ "/" + iForm );
		} read

//unsigned division
		| DIVL STACKVAR {
		
			SymInfo &regsA = curSymTab[ EAX ];
			SymInfo &var = curActRecord -> at( $2 );
			
			curSymTab[ EDX ].modValue( 
					"(" + regsA.getValue( ) + ")"
					+ "%" + var.getName( )
					);
					
			regsA.modValue( "(" + regsA.getValue( ) + ")"
					+ "/" + var.getName( )
				);
			var.modType( LONG );
			var.makUnsigned( );
		} read

//unsigned division
		| DIVL REGS {

			SymInfo &Eax = curSymTab[ EAX ];
			SymInfo &regs = curSymTab[ $2 ];
			curSymTab[ EDX ].modValue( 
					string( "(" + Eax.getValue( ) + ")"
					+ "%" + regs.getValue( ) )
					);
			Eax.modValue(
					string( "(" + Eax.getValue( ) + ")"
					+ "/" + regs.getValue( ) )
				);
			regs.modType( LONG );
		} read

		| IMULL REGS {

			SymInfo &Eax = curSymTab[ EAX ];
			SymInfo &regs2 = curSymTab[ $2 ];
			Eax.modValue( "(" + Eax.getValue( ) + ")"
					+ "*" +
					"(" + regs2.getValue( ) + ")"
				);
			regs2.modType( LONG );
		} read

		| IMULL REGS REGS {
		
			SymInfo &regs2 = curSymTab[ $3 ];
			regs2.modValue( "(" + regs2.getValue( ) + ")" 
						+ "*" + 
					curSymTab[ $2 ].getValue( )
				);
		} read
	
		| IMULL NAME REGS {

			SymInfo &var = curSymTab[ $2 ];	
			SymInfo &regs2 = curSymTab[ $3 ];
			regs2.modValue(	
					"(" + regs2.getValue( ) + ")"
					+ "*" + var.getName( )
					);
			var.modType( LONG );
			
		} /* REGS = REGS * NAME */ read

		| IMULL STACKVAR REGS {

			SymInfo &var = curActRecord -> at( $2 );
			SymInfo &regs = curSymTab[ $3 ];
			regs.modValue( "(" + regs.getValue( ) + ")"+ "*" 
					+ var.getName( )
				     );
			var.modType( LONG );
		} /* REGS = REGS * STACKVAR */ read
		
		| IMULL ARRAYNAME REGS {

			SymInfo &array = curSymTab[ $2 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			SymInfo &destRegs = curSymTab[ $3 ];
			
			array.makArray( );
			array.modType( LONG );
			
			const string &iForm = indexForm( array, regs );
						
			destRegs.modValue( "(" + destRegs.getValue( ) + ")"
						+ "*" + iForm );
		} read

		| IMULL NUM REGS {
		
			SymInfo &regs = curSymTab[ $3 ];	
			regs.modValue( "(" + regs.getValue( ) + ")"
					+ "*" + itoa( $2 )
				     );
		} /* REGS = REGS * NAME */ read

		| MULB NAME {
		
			SymInfo &eax = curSymTab[ EAX ];
			SymInfo &var = curSymTab[ $2 ];	
			eax.modValue( eax.getValue( ) + "*" + var.getName( ) );
			var.modType( CHAR );
			
		} read

		| MULB ARRAYNAME {
		
			SymInfo &eax = curSymTab[ EAX ];
			SymInfo &array = curSymTab[ tempArray.name ];	
			SymInfo &regs = curSymTab[ tempArray.regs ];
			eax.modValue( eax.getValue( ) + "*"
						+ indexForm( array, regs ) );

			array.makArray( );
			array.modType( CHAR );
			
		} read
		| MULB STACKVAR {
		
			SymInfo &eax = curSymTab[ EAX ];
			SymInfo &var = curActRecord -> at( $2 );
			eax.modValue( eax.getValue( ) + "*" + var.getName( ) );
			var.modType( CHAR );
		} read

		| MOV REGS REGS {
			curSymTab[ $3 ] = curSymTab[ $2 ];
		} read

		| MOV REGS NAME {
		
			SymInfo &regs = curSymTab[ $2 ];
			SymInfo &var = curSymTab[ $3 ];	
			curInstr = var.getName( ) + "= " + regs.getValue( );
			curBlock -> insert( curInstr + ";" ); 
			var.modType( $1 );
			regs.modType( var.getType( ) );

		} /* NAME = REGS */ read

		| MOV REGS STACKVAR {
		
			SymInfo &regs = curSymTab[ $2 ];
			SymInfo &var = curActRecord -> at( $3 );
			var.reference = regs.reference;
			curInstr = var.getName( ) + "=" + regs.getValue( );
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
			regs.modType( var.getType( ) );
		} read

		| MOV REGS POINTER {

			SymInfo &regs = curSymTab[ $2 ];
			SymInfo *&ref = curSymTab[ $3 ].reference;
			
			curInstr = "*(" + ref -> getName( ) + ")"
					+ "= " + regs.getValue( );
			curBlock -> insert( curInstr + ";" );
			ref -> modType( $1 );
			regs.modType( ref -> getType( ) );

		} read

		| MOV NAME REGS { 

			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curSymTab[ $2 ];	
			regs.modValue( var.getName( ) );
			var.modType( $1 ); 
			regs.modType( var.getType( ) );
			regs.reference = &var;
		} read

		| MOV STACKVAR REGS {
		
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curActRecord -> at( $2 );
			regs.reference = var.reference;
			regs.modValue( var.getName( ) );
			var.modType( $1 );
			regs.modType( var.getType( ) );
		} read

		| MOV NUM REGS {
			SymInfo &regs = curSymTab[ $3 ];
			regs.modValue( itoa( $2 ) );
			regs.modType( INT );
			
		} read

		| MOV NUM NAME { 
		
			SymInfo &var = curSymTab[ $3 ];	
			curInstr = var.getName( ) + "= " + itoa( $2 );
			curBlock -> insert( curInstr + ";" ); 
			var.modType( $1 );
				  
		} /* NAME = NUM */ read

		| MOV NUM STACKVAR {

			  SymInfo &var = curActRecord -> at( $3 );
			  curInstr = var.getName( ) + "= " + itoa( $2 );
			  curBlock -> insert( curInstr + ";" ); 
			  var.modType( $1 );
		} read

		| MOV NUM ARRAYNAME {

			SymInfo &array = curSymTab[ $3 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			array.makArray( );
			array.fixType( $1 );

			curInstr = indexForm( array, regs ) + "= " + itoa( $2 );
			curBlock -> insert( curInstr + ";" );
		} read

		| MOV REGS ARRAYNAME {

			SymInfo &srcRegs = curSymTab[ $2 ];
			SymInfo &array = curSymTab[ $3 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];

			array.makArray( );
			array.fixType( $1 );

			curInstr = indexForm( array, regs )
					+ "= " + srcRegs.getValue( );

			curBlock -> insert( curInstr + ";" );
		} read

		| MOV ARRAYNAME REGS {

			SymInfo &array = curSymTab[ $2 ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			SymInfo &regs2 = curSymTab[ $3 ];
			
			array.makArray( );
			array.modType( $1 );
			regs2.modValue( indexForm( array, regs ) );

		} read

		| MOV HEXNUM STACKVAR {

			  SymInfo &var = curActRecord -> at( $3 );
			  curInstr = var.getName( ) + "= " 
						+ convert2Float( htoi( $2 ) );
			  curBlock -> insert( curInstr + ";" ); 
			  var.fixType( FLOAT );
		} read


/*move byte to word */
		| MOVBW REGS REGS {
			SymInfo &regs2 = curSymTab[ $3 ];
			regs2 = curSymTab[ $2 ];
			regs2.modValue( regs2.getValue( ) );
		} read

/*move byte to word */
		| MOVBW NAME REGS {
			SymInfo &var = curSymTab[ $2 ];
			curSymTab[ $3 ].modValue( var.getName( ) );
			var.fixType( CHAR );
			if ( $1 == UNSIGNED )
				var.makUnsigned( );
		} read

/*move byte to word */
		| MOVBW STACKVAR REGS {
			SymInfo &var = curActRecord -> at( $2 );
			curSymTab[ $3 ].modValue( var.getName( ) );
			var.fixType( CHAR );
			if ( $1 == UNSIGNED )
				var.makUnsigned( );
		} read


/* move word to long */
		| MOVWL REGS REGS {
			SymInfo &regs2 = curSymTab[ $3 ];
			regs2 = curSymTab[ $2 ];
			regs2.modValue( regs2.getValue( ) );
		} read

/* move word to long */
		| MOVWL NAME REGS {

			SymInfo &var = curSymTab[ $2 ];
			curSymTab[ $3 ].modValue( var.getName( ) );
			var.fixType( SINT );
			if ( $1 == UNSIGNED )
				var.makUnsigned( );
		} read

		| MOVWL STACKVAR REGS {

			SymInfo &var = curActRecord -> at( $2 );
			curSymTab[ $3 ].modValue( var.getName( ) );
			var.fixType( SINT );
			if ( $1 == UNSIGNED )
				var.makUnsigned( );
		} read

/* move byte to long */
		| MOVBL REGS REGS {

			SymInfo &regs2 = curSymTab[ $3 ];
			regs2 = curSymTab[ $2 ];
			regs2.modValue( regs2.getValue( ) );
		} read

/* move byte to long */ 
		| MOVBL NAME REGS {
		
			SymInfo &var = curSymTab[ $2 ];	
			curSymTab[ $3 ].modValue( var.getName( ) );
			var.fixType( CHAR );
			if ( $1 == UNSIGNED )
				var.makUnsigned( );
		} read
	
/* move byte to long */ 
		| MOVBL STACKVAR REGS {
		
			SymInfo &var = curActRecord -> at( $2 );
			curSymTab[ $3 ].modValue( var.getName( ) );
			var.fixType( CHAR );
			if ( $1 == UNSIGNED )
				var.makUnsigned( );
			
		} read

	
	
		| CMP REGS REGS { 
			SymInfo &regs1 = curSymTab[ $2 ];
			SymInfo &regs2 = curSymTab[ $3 ];
			cmpOp1 = regs1.getValue( );
			cmpOp2 = regs2.getValue( );
			regs1.modType( $1 );
			regs2.modType( $1 );
		} read

		| CMP REGS NAME {
			SymInfo &regs = curSymTab[ $2 ];
			SymInfo &var = curSymTab[ $3 ];	
			cmpOp1 = var.getName( );
			cmpOp2 = regs.getValue( );
			var.modType( $1 );
			regs.modType( $1 );
		} read

		| CMP REGS STACKVAR {
			SymInfo &regs = curSymTab[ $2 ];
			SymInfo &var = curActRecord -> at( $3 );
			cmpOp1 = var.getName( );
			cmpOp2 = regs.getValue( );
			var.modType( $1 );
			regs.modType( $1 );
		} read
		
		| CMP REGS ARRAYNAME {

			SymInfo &regs = curSymTab[ $2 ];
			SymInfo &array = curSymTab[ tempArray.name ];
			SymInfo &regs1 = curSymTab[ tempArray.regs ];
			
			cmpOp1 = indexForm( array, regs1 );
			cmpOp2 = regs.getValue( );
			
			array.makArray( );
			array.modType( $1 );
			regs.modType( $1 );
		} read

		| CMP NAME REGS  {
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curSymTab[ $2 ];
			cmpOp1 = regs.getValue( );
			cmpOp2 = var.getName( );
			var.modType( $1 );
			regs.modType( $1 );
		} read

		| CMP STACKVAR REGS  {
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curActRecord -> at( $2 );
			cmpOp1 = regs.getValue( );
			cmpOp2 = var.getName( );	
			var.modType( $1 );
			regs.modType( $1 );
		} read
		
		| CMP ARRAYNAME REGS {

			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &array = curSymTab[ tempArray.name ];
			SymInfo &regs1 = curSymTab[ tempArray.regs ];
			
			cmpOp1 = regs.getValue( );
			cmpOp2 = indexForm( array, regs1 );
			array.makArray( );
			array.modType( $1 );
		} read

		| CMP NUM NAME {
			SymInfo &var = curSymTab[ $3 ];
			cmpOp1 = var.getName( );
			cmpOp2 = itoa( $2 );
			var.modType( $1 );
		} read

		| CMP NUM STACKVAR {
		
			SymInfo &var = curActRecord -> at( $3 );
			cmpOp1 = var.getName( );
			cmpOp2 = itoa( $2 );
			var.modType( $1 );
		} read
		
		| CMP NUM ARRAYNAME {

			SymInfo &array = curSymTab[ tempArray.name ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			
			cmpOp1 = indexForm( array, regs );
			cmpOp2 = itoa( $2 );
			array.makArray( );
			array.modType( $1 );
		} read

		| CMP NAME NUM  {
			SymInfo &var = curSymTab[ $2 ];
			cmpOp1 = itoa( $3 );
			cmpOp2 = var.getName( );
			var.modType( $1 );
		} read

		| CMP STACKVAR NUM  {
		
			SymInfo &var = curActRecord -> at( $2 );
			cmpOp1 = itoa( $3 );
			cmpOp2 = var.getName( );
			var.modType( $1 );
		} read
		
		| CMP ARRAYNAME NUM {

			SymInfo &array = curSymTab[ tempArray.name ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			
			cmpOp1 = itoa( $3 );
			cmpOp2 = indexForm( array, regs );
			array.makArray( );
			array.modType( $1 );
		} read

		| CMP NUM REGS  {
			cmpOp1 = curSymTab[ $3 ].getValue( );
			cmpOp2 = itoa( $2 );
		 } read

		| CMP REGS NUM {
			cmpOp1 = itoa( $3 );
			cmpOp2 = curSymTab[ $2 ].getValue( );
		} read
		
		| TEST REGS REGS {
				
			SymInfo &regs1 = curSymTab[ $2 ];
			SymInfo &regs2 = curSymTab[ $3 ];
			if ( string( $2 ) == $3 )
				cmpOp1 = regs1.getValue( );
			else {
				cmpOp1 = "((" + regs1.getValue( ) + ")&" +
					regs2.getValue( ) + ")" ;
			}
			cmpOp2 = "0";
			regs1.modType( $1 );
			regs2.modType( $1 );
			
		} read

		| TEST NUM REGS {
			
			cmpOp1 = "(" + itoa( $2 ) + "&" 
					+ curSymTab[ $3 ].getValue( ) + ")";
			cmpOp2 = "0";
		} read

		| TEST NAME REGS {
			
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curSymTab[ $2 ];
			cmpOp1 += "(" + var.getName( ) + "&" 
					+ regs.getValue( ) + ")";
			cmpOp2 = "0";
			var.modType( $1 );
			regs.modType( $1 );
		} read
		
		| TEST STACKVAR REGS {
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curActRecord -> at( $2 );
			cmpOp1 += "(" + var.getName( ) 
					+ "&" + regs.getValue( ) + ")";
			cmpOp2 = "0";
			var.modType( $1 );
			regs.modType( $1 );
		} read
		
		| TEST ARRAYNAME REGS {

			SymInfo &array = curSymTab[ tempArray.name ];
			SymInfo &regs = curSymTab[ tempArray.regs ];
			SymInfo &destRegs = curSymTab[ $3 ];

			cmpOp1 += "(" + indexForm( array, regs )
					+ "&" + destRegs.getValue( ) + ")";
			cmpOp2 = "0";
			array.modType( $1 );
			array.makArray( );
			destRegs.modType( $1 );
		} read
		
		| TEST NAME NUM {
			
			SymInfo &var = curSymTab[ $2 ];
			cmpOp1 = "(" + var.getName( ) + "&" + itoa( $3 ) + ")";
			cmpOp2 = "0";
			var.modType( $1 );
		} read

		| TEST STACKVAR NUM {
			
			cmpOp1 = "(" + curActRecord -> at( $2 ).getName( ) 
					+ "&" + itoa( $3 ) + ")";
			cmpOp2 = "0";
		} read
		
		| MOV REGS ESP{} read

		| MOV ESP REGS{} read

		| MOV ESP EBP{} read

		| OPCODE REGS ESP {}read//OPCODEL=SUBL

		| OPCODE NUM ESP {//OPCODEL = SUBL or ADDL or ANDL
			
			if ( string( $1 ) == "-" )
				if ( seenOnce == false )
					seenOnce = true;
		} read


		| POPL REGS read
		
		| POPL NAME read


/* floating point operations */

/*  make the top of the stack positive */
		| FABS {
                        FloatType a = floatStack.pop();
                        curInstr = "(" + a + "="
                                   + a + ">" + "0" + "?" + a + ":"
                                   + "-" + a + ")";
                        floatStack.push( curInstr );

		} read

/*	change the sign of the value at the top of the stack */
		| FCHS {

			floatStack.push( "-(" + floatStack.pop( ) + ")" );
		} read

		| FXCH {
			floatStack.swap( 1 );
		} read

		| FXCH FLOATREG {
			floatStack.swap( $2 );
		} read
		
		| FLD1 {
			floatStack.push( "1" );
		} read

		| FLDZ {
			floatStack.push( "0" );
		} read

		| FLD NAME {
			SymInfo &var = curSymTab[ $2 ];
			floatStack.push( var.getName( ) );
			var.modType( $1 );
		} read

		| FLD STACKVAR {
			SymInfo &var = curActRecord -> at( $2 );
			floatStack.push( var.getName( ) );
			var.modType( $1 );
		} read

		| FLD FLOATREG {
			floatStack.pushFrom( $2 );
		} read

		| FLD STRINGLABEL {
			floatStack.push( curSymTab[ itoa( $2 ) ].getValue( ) );
		} read
		
		| FILD NAME {

			SymInfo &var = curSymTab[ $2 ];
			floatStack.push( var.getName( ) );
			var.modType( $1 );
		} read

		| FILD STACKVAR {

			SymInfo &var = ( *curActRecord )[ $2 ];
			floatStack.push( var.getName( ) );
			var.modType( $1 );
		} read

/* floating point store instructions */

		| FST FLOATREG {
				
			const string &t = floatStack.seetop( );
			floatStack.storeAt($2, t);
			floatStack.pop( );
				
		} read

		| FST NAME {
		
			SymInfo &var = curSymTab[ $2 ];
			curInstr = var.getName( ) + "=" + floatStack.seetop( );
			floatStack.at( 0 ) = var.getName( );
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
				
		} read

		| FST STACKVAR {
		
			SymInfo &var = curActRecord -> at( $2 );
			curInstr = var.getName( ) + "=" + floatStack.seetop( );
			floatStack.at( 0 ) = var.getName( );
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
			
		} read

/* floating point store and pop instructions */	
		| FSTP FLOATREG {

			const string &t = floatStack.seetop( );
			floatStack.storeAt( $2, t );
			floatStack.pop( );
			
		} read
	
		| FSTP NAME {

			SymInfo &var = curSymTab[ $2 ];
			curInstr = var.getName( ) + "=" + floatStack.pop( );
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
				
		} read

		| FSTP STACKVAR {

			SymInfo &var = curActRecord -> at( $2 );
			curInstr = var.getName( ) + "=" + floatStack.pop( );
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
				
		} read
		
/* floating point store-integer instructions */

		| FIST NAME {
			SymInfo &var = curSymTab[ $2 ];

			curInstr = var.getName( ) + "=" + 
				 "(" + floatStack.seetop( ) + ")";
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
		} read

		| FIST STACKVAR {

			SymInfo &var = ( *curActRecord )[ $2 ];

			curInstr = var.getName( ) + "="
					+ "(" + floatStack.seetop( ) + ")";
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
		} read

/* floating point store-integer and pop instructions */
		| FISTP NAME {
			SymInfo &var = curSymTab[ $2 ];	

			curInstr = var.getName( ) + "=" 
						+ "(" + floatStack.pop( ) + ")";
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
		} read

		| FISTP STACKVAR {
		
			SymInfo &var = curActRecord -> at( $2 );

			curInstr = var.getName( ) + "=" 
						+ "(" + floatStack.pop( ) + ")";
			curBlock -> insert( curInstr + ";" );
			var.modType( $1 );
		} read

/* addtion instructions  */

/* FADD is typed */

/* add the value in NAME to st and store the result at st  */

/* add the value in FLOATREG to st and store the result at st  */
		| FADD FLOATREG {
			floatStack.at( 0 ) = "(" + floatStack.at ( 0 )
						+ "+" 
						+ floatStack.at( $2 ) + ")" ;

		} read

/*	add the value at FLOATREG-1 and that at FLOATREG-2 and store the result
	in st
	Here one of the floating point registers will be st
*/
		| FADD FLOATREG FLOATREG {
			
			floatStack.at( 0 ) = "(" + floatStack.at( $2 )
					  + "+" +
					  floatStack.at( $3 ) + ")" ;
		} read

		| FADD NAME {
		
			SymInfo &var = curSymTab[ $2 ];	
			floatStack.at( 0 ) = "(" + floatStack.at( 0 )
				 	+ "+" 
					+ var.getName( ) + ")" ;
			var.modType( $1 );
		} read
		 
		| FADD STACKVAR {
		
			SymInfo &var = ( *curActRecord )[ $2 ];
			floatStack.at( 0 ) = "(" + floatStack.at( 0 )
				 	+ "+" 
					+ var.getName( ) + ")" ;

			var.modType( $1 );

		} read
		
/*	add the contents of the floating point registers and store the contents
	at st
	Here one of the registers must be st
	Before storing pop the two operands
*/
		| FADDP FLOATREG FLOATREG {
			floatStack.push( 
				"(" + floatStack.pop( ) 
					+ "+" + 
				floatStack.pop( ) + ")"	
				);
		} read

/*	FIADD is typed */
		| FIADD NAME {
		
			SymInfo &var = curSymTab[ $2 ];
			
			floatStack.at( 0 ) = "(" + floatStack.at( 0 ) 
						+ "+" +
						var.getName( ) + ")" ;
			var.modType( $1 );
		} read

		| FIADD STACKVAR {
		
			SymInfo &var = ( *curActRecord )[ $2 ];
			
			floatStack.at( 0 ) = "(" + floatStack.at( 0 ) 
						+ "+" +	var.getName( ) + ")" ;
			var.modType( $1 );
		} read

/* subtraction instructions  */

/* subtract the value in NAME from st and store the result in st  */

/* subtract the value in FLOATREG to st and store the result in st  */
		| FSUB FLOATREG {
		
			floatStack.at( 0 ) = "(" + floatStack.at ( 0 )
						+ "-" 
						+ floatStack.at( $2 ) + ")" ;

		} read
/*	
	subtract the other register from st and store the result in st	
	Here one of the floating point registers will be st
*/
		| FSUB FLOATREG FLOATREG {
			FloatType op1, op2;
			if ( $3 != 0 ) 
				op2 = floatStack.at( $3 );
			else if ( $2 != 0 )
				op2 = floatStack.at( $2 );
			else
				op2 = floatStack.at( 0 );
			op1 = floatStack.at( 0 );
			floatStack.at( 0 ) = "(" + op2 + "-" + op1 + ")" ;

		} read

		| FSUB NAME {
			
			SymInfo &var = curSymTab[ $2 ];
			floatStack.at( 0 ) = "(" + floatStack.at( 0 )
				 	+ "-" 
					+ var.getName( ) + ")" ;
			var.modType( $1 );

		} read
		 
		| FSUB STACKVAR {
			
			SymInfo &var = ( *curActRecord )[ $2 ];
			floatStack.at( 0 ) = "(" + floatStack.at( 0 )
				 	+ "-" + var.getName( ) + ")" ;

			var.modType( $1 );

		} read


/*subtract the contents of the floating point registers and store the contents
	at st
	Here one of the registers must be st
	Before storing pop the two operands
*/
		| FSUBP FLOATREG FLOATREG {
			
			FloatType op1, op2;
			if ( $2 != 0 ) 
				op2 = floatStack.at( $2 );
			else 
				op2 = floatStack.at( $3 );
			op1 = floatStack.at( 0 );
			floatStack.push( "(" + op1 + "-" + op2 + ")" );
		} read

	
/*  reverse subtraction instructions */

/* FSUBR is typed */

/* subtract the value in st from FLOATREG store the result in st  */
		| FSUBR FLOATREG {
		
			floatStack.at( 0 ) = "(" + floatStack.at ( $2 )
						+ "-" 
						+ floatStack.at( 0 ) + ")" ;

		} read

/* subtract the value in st from NAME st and store the result in st  */
		| FSUBR NAME {
		
			SymInfo &var = curSymTab[ $2 ];
			floatStack.at( 0 ) = "(" + var.getName( )
				 	+ "-" 
					+ floatStack.at( 0 ) + ")" ;
			var.modType( $1 );

		} read

		| FSUBR STACKVAR {
		
			SymInfo &var = curActRecord -> at( $2 );
			floatStack.at( 0 ) = "(" + var.getName( ) + "-" 
					+ floatStack.at( 0 ) + ")" ;

			var.modType( $1 );

		} read


		| FSUBRP FLOATREG FLOATREG {
			
			FloatType op1, op2;
			if ( $2 == 0 ) 
				op2 = floatStack.at( $3 );
			else 
				op2 = floatStack.at( $2 );
			op1 = floatStack.at( 0 );

			floatStack.pop( );
			floatStack.pop( );

			floatStack.push( "(" + op2 + "-" + op1 + ")" );
		} read

/* floating point multiplication instructions  */

/* FMUL is typed */
		| FMUL NAME {
		
			SymInfo &var = curSymTab[ $2 ];
			floatStack.at( 0 ) = "(" + floatStack.at( 0 ) +
						"*" + var.getName( ) + ")" ;
			var.modType( $1 );
				
		} read

		| FMUL STACKVAR {
		
			SymInfo &var = ( *curActRecord )[ $2 ];
			floatStack.at( 0 ) = "(" + floatStack.at( 0 ) +
						"*" + var.getName( ) + ")" ;
			var.modType( $1 );
				
		} read

		| FMUL FLOATREG {
			floatStack.at( 0 ) = 
				"(" + floatStack.at( 0 ) +
						"*" + floatStack.at( $2 ) + ")";
		} read

		| FMUL FLOATREG FLOATREG {
			FloatType op1, op2;
			if ( $2 != 0 )
				op2 = floatStack.at( $2 );
			else
				op2 = floatStack.at( $3 );
			op1 = floatStack.at( 0 );

			floatStack.at( 0 ) = "(" + op1 + "*" + op2 + ")" ;
		} read

/* floating point multiply and pop instructions */
		| FMULP FLOATREG FLOATREG {
			FloatType op1, op2;
			if ( $2 != 0 )
				op2 = floatStack.at( $2 );
			else
				op2 = floatStack.at( $3 );
			op1 = floatStack.at( 0 );

			floatStack.pop( );
			floatStack.pop( );
			floatStack.push( "(" + op1 + "*" + op2 + ")" );
		} read


/*  division instructions */
		| FDIV FLOATREG {
			floatStack.at( 0 ) = 
				"(" + floatStack.at( 0 ) +
						"/" + floatStack.at( $2 ) + ")";
		} read

		| FDIV FLOATREG FLOATREG {
			FloatType op1, op2;
			if ( $2 != 0 )
				op2 = floatStack.at( $2 );
			else
				op2 = floatStack.at( $3 );
			op1 = floatStack.at( 0 );

			floatStack.at( 0 ) = "(" + op1 + "/" + op2 + ")";
		} read

		| FDIV NAME {
			SymInfo &var = curSymTab[ $2 ];
			floatStack.at( 0 ) = "(" + floatStack.at( 0 ) +
						"/" + var.getName( ) + ")" ;
			var.modType( FLOAT );
		} read
		
		| FDIV STACKVAR {
			SymInfo &var = ( *curActRecord )[ $2 ];
			floatStack.at( 0 ) = "(" + floatStack.at( 0 ) +
						"/" + var.getName( ) + ")" ;
			var.modType( FLOAT );
		} read

/* floating point reverse division instructions */
		| FDIVR NAME {

			SymInfo &var = curSymTab[ $2 ];
			floatStack.at( 0 ) = "(" + var.getName( ) +
						"/" + floatStack.at( 0 ) + ")" ;
			var.modType( FLOAT );
		
		} read

		| FDIVR STACKVAR {

			SymInfo &var = ( *curActRecord )[ $2 ];
			floatStack.at( 0 ) = "(" + var.getName( ) +
						"/" + floatStack.at( 0 ) + ")" ;
		
		} read

		| FDIVR FLOATREG {

			floatStack.at( 0 ) = 
				"(" + floatStack.at( $2 ) +
						"/" + floatStack.at( 0 ) + ")";
		
		} read

/* floatint point divide and pop instructions */

		| FDIVP FLOATREG FLOATREG {

			FloatType op1, op2;
			if ( $2 != 0 )
				op2 = floatStack.at( $2 );
			else
				op2 = floatStack.at( $3 );
			op1 = floatStack.at( 0 );

			floatStack.pop( );
			floatStack.pop( );
			floatStack.push( "(" + op1 + "/" + op2 + ")" );

		} read

/* floatint point reverse-divide and pop instructions */

		| FDIVRP FLOATREG FLOATREG {

			FloatType op1, op2;
			if ( $2 != 0 )
				op2 = floatStack.at( $2 );
			else
				op2 = floatStack.at( $3 );
			op1 = floatStack.at( 0 );

			floatStack.pop( );
			floatStack.pop( );
			floatStack.push( "(" + op2 + "/" + op1 + ")" );

		} read

		| FUCOMPP {
			cmpOp1 = floatStack.pop( );
			cmpOp2 = floatStack.pop( );
		} read

/* comparison for >= or > depending on the value NUM */
/* the comparison operator that is stored is the reverse of the actual 
   comparison that would have taken place. this because the comparison
   operator will be reversed during the reduction of the node containing it.
   ex: below jge will be stored as jl and jle is stored as jg
*/
		| FNSTSW REGS TEST NUM REGS {
			string op;
			if ( $4 == 5 )
				op = "jl";
			else if ( $4 == 69 )
				op = "jle";

			curBlock -> cmpOperator(  op );
			curBlock -> cmpOpFloat = true;
		} read

/* comparison for != */
/* jne stored as je */        /* and */      /* xor */
		| FNSTSW REGS OPCODE NUM REGS OPCODE NUM REGS {
			curBlock -> cmpOperator( "je" );
			curBlock -> cmpOpFloat = true;
		} read

/* comparison for == */
/* je stored as jne */       /* and */
		| FNSTSW REGS OPCODE NUM REGS CMP NUM REGS {
			curBlock -> cmpOperator( "jne" );
			curBlock -> cmpOpFloat = true;
		} read

		| FNSTCW STACKVAR
		  MOV STACKVAR REGS
		  MOV NUM REGS
		  MOV REGS STACKVAR 
		rest
		read

		| FLDCW STACKVAR
		  perform_operation
		  FLDCW STACKVAR
		  read

		| PUSHL EBP read

		| PUSHL REGS {
			if ( seenOnce )
				prototype.push( curSymTab[$2] );
		} read
			      
		| PUSHL NAME {
			if ( seenOnce )
				prototype.push( curSymTab[ $2 ] );
		} read
		
		| PUSHL ADDRESSNAME {
			if ( seenOnce ) {
				SymInfo var;
				var.modValue( "&" 
					+ curSymTab[ $2 ].getName( ) );
				prototype.push( var );
			}
		} read

		| PUSHL STACKVAR {
			if ( seenOnce )	{
				SymInfo &var = ( *curActRecord )[ $2 ];
				prototype.push( var );
				SymInfo &t = prototype.top();
				t.modName( var.getName( ) );
			}
		} read

		| PUSHL STR {
			if ( seenOnce )	{
				SymInfo temp( STRING, sizeof ( char * ), $2 );
				temp.makConst( );
				prototype.push( temp );
			}
		} read

		| PUSHL NUM {
			if ( seenOnce )	{
				SymInfo temp( 
					LONG, sizeof ( long ), itoa( $2 ) 
					);
				prototype.push( temp );
			}
		} read

/*	FILD one of FILDS, FILDL */
/*	FILD is typed */

		| FILD PTRESP LEAL NUM PTRESP ESP {

			SymInfo &regs = prototype.top( );
			prototype.pop( );
			floatStack.push( regs.getValue( ) );
		} read

/* for "leal -4(%eax) %ebx" */	

		| LEAL NUM POINTER REGS {
			SymInfo &regs = curSymTab[ $4 ];
			SymInfo &p = curSymTab[ $3 ];

			regs.modValue( "(" +  p.getValue( ) + itoa( $2 ) + ")"
					);
		} read

/* for "leal (%eax,%ebx) %ecx" */

		| LEAL SUM REGS {
			string first = $2;
			string second = string( first.begin() + 4, first.end());
			first = string( first.begin( ), first.begin( ) + 4 );
			curSymTab[ $3 ].value = 
					"(" + curSymTab[ first ].value + ")" +
					"+" +
					"(" + curSymTab[ second ].value + ")";
		} read

			
/* for "leal -4(%ebp) %eax" */

		| LEAL STACKVAR REGS {
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curActRecord -> at( $2 );
			regs.reference = &var;
			regs.modValue( "&" + var.getName( ) );
		} read

/* for "leal var %eax" */
		| LEAL NAME REGS {
			SymInfo &regs = curSymTab[ $3 ];
			SymInfo &var = curSymTab[ $2 ];
			regs.reference = &var;
			regs.modValue( "&" + var.getName( ) );
		} read

		| LEAL NUM PTRESP {} ESP read 
		| LEAL STACKVAR ESP {} read

/* one of fstpl and fstps */
		| FSTP PTRESP {

			SymInfo temp;
			temp.modValue( floatStack.pop( ) );
			temp.modType( $1 );
			prototype.push( temp );
		} read

		| CALL NAME {
			string call = string( $2 ) + "(";
			ActRecord temp;
			int no = 8;
			while ( !prototype.empty( ) ) {
				++temp.maxPars;
call += prototype.top( ).getValue( ) + (prototype.size( ) > 1 ? "," : "");
				temp.insert( no, prototype.top( ) );
				prototype.pop( );
				no += 4;
			}
			curFuncTab.insert( $2, temp );
			curSymTab[ EAX ].modValue( call + ")" );
/*
			SymInfo &eax = curSymTab[ EAX ];
			eax.modValue( call + ")" );
			eax.used = eax.defined = false;
*/
		} read


/* return 1 to indicate that this function has ended, but there is more data
   to be read
*/
		| FUNCEND {
			if ( !SAW_JUMP )
				curBlockTab.insert( curBlock );

			SymInfo &eax = curSymTab[ EAX ];
			curActRecord -> setRetValue( eax.getValue( ) );
			curActRecord -> setRetType( eax.getType( ) );

			if ( VERBOSE ) {
				verbose( "\tFunction takes " 
					+ itoa( curActRecord -> maxPars )
					+ " parameters" );
				verbose( "\tFinished Data Flow Analysis" );
			}
			return 1;
		} 

		;

perform_operation: FISTP STACKVAR {

		SymInfo &var = curActRecord -> at( $2 );
		curInstr = var.getName( ) + "=" 
					+ "(" + floatStack.pop( ) + ")";
		curBlock -> insert( curInstr + ";" );
		var.modType( $1 );
	}
	| FISTP NAME {

		SymInfo &var = curSymTab[ $2 ];
		curInstr = var.getName( ) + "=" + "(" + floatStack.pop( ) + ")";
		curBlock -> insert( curInstr + ";" );
		var.modType( $1 );
	}
	| FISTPLL STACKVAR {

		SymInfo &var = curActRecord -> at( $2 );
		curInstr = var.getName( ) + "=" 
					+ "(" + floatStack.pop( ) + ")";
		curBlock -> insert( curInstr + ";" );
		var.modType( LONG );
	}
	;

rest:  	FLDCW STACKVAR
	perform_operation 
	FLDCW STACKVAR 
	| %prec LOW
	;

%%

int yyerror( char *s )
{
	if ( strstr(s, "syntax" ) != NULL )
		cerr << "Illegal instruction found at line " 
			<< yylineno << endl;
	else
		cerr << s << endl;
	throw EXIT_FAILURE;
}

