%{using namespace std;
#include"relipmoC.h"
#include"yacc.cpp.h"
extern StringTab curStringTab; 
extern SymTab curSymTab;
extern ActRecord *curActRecord;
extern SYMTYPE opcode;
extern Array tempArray;
static string staticName;
extern bool CPP;
%}

%option lex-compat

%x SEENARRAY
%x FUNCTIONEND
%x IS_STATIC_LOCAL

WS [\n\t\r ]*
IDENTIFIER [[:alpha:]_]([[:alnum:]]+)?
NUMBER	(\-|\+)?[[:digit:]]+
HEX	0(x|X)?[[:alnum:]]+
STR  \"([^\\"]*|[\\](.|\n))*\"
REGISTER ((%eax)|(%ebx)|(%ecx)|(%edx)|(%esi))

%%
 string temp;

<*>{WS}                     
	
".file".*
".bss"
".LFB"{NUMBER}":"
".LCFI"{NUMBER}":"
".LFE"{NUMBER}":"

".data"		{ /*data section starts; contains declarations of global vars*/}

".text"		{/*code section starts */ }

".section"

".rodata"(".str1.1,\"aMS\",@progbits,1")? //{ cout << yytext << "check asm file";}

".ident"{WS}{STR}

".local"			{
					return LOCAL;
					//"IDENTIFIER" is "static"
				}

".Lfe"{NUMBER}+:{WS}*".size".*	return FUNCEND;

".string"			return STRSECTION;     

{STR}			      { 
				strcpy( yylval.name, yytext );
				return STR;			
			      }	

".globl"                      /* "IDENTIFIER" is global */ return GLOBAL;

".align"{WS}*{NUMBER}		//swallow align statement

".type"				return TYPE;

@object				return OBJECT;

@function			return FUNCTION;

".size"				return SIZE;

".byte"|".long"|".value"       	{
					strcpy( yylval.name, yytext + 1 );
					return DTYPE;
				}

".zero"				{if ( CPP != true ) {
				cerr << ".zero encountered\nsee start.l";
					abort();}
					//return ZERO;
					strcpy( yylval.name, "long" );
					return DTYPE;
				}

".comm"				return COMM;	

:				return ':';//indicates a label

${NUMBER}+		      	{
					yylval.num = atoi( yytext + 1 );
					return NUM;
				}

$.LC{NUMBER}+			{
				//a string label found, return its value i.e.,
				//its corresponding string
				StringTab::Index t = atoi( yytext + 4 );
				strcpy( yylval.name, curStringTab[ t ].c_str());
				return STR;
			      }
	
${IDENTIFIER}([.]{NUMBER})?   {
				/*$Identifier means the address of the 
				  identifier. change return value from NAME to
				  something that indicates this */
					strcpy( yylval.name, yytext + 1 );
					return ADDRESSNAME;
			      }
	
pushl				return PUSHL;
popl				return POPL;

call				return CALL;

nop
cltd
cwtl
leave
ret

addl				{
					strcpy( yylval.name, "+" );
					opcode = LONG;
					return OPCODE;
				}

addw				{
					strcpy( yylval.name, "+" );
					opcode = SINT;
					return OPCODE;
				}

addb				{
					strcpy( yylval.name, "+" );
					opcode = CHAR;
					return OPCODE;
				}

subl				{
					strcpy( yylval.name, "-" );
					opcode = LONG;
					return OPCODE;
				}

subw				{
					strcpy( yylval.name, "-" );
					opcode = SINT;
					return OPCODE;
				}
				
subb				{
					strcpy( yylval.name, "-" );
					opcode = CHAR;
					return OPCODE;
				}
				
mull				return MULL;
mulb				return MULB;
imull				return IMULL;
idivl				return IDIVL; 
divl				return DIVL;

incl				{	
					yylval.type = LONG;
					return INC;
				}
incw				{	
					yylval.type = SINT;
					return INC;
				}
incb				{	
					yylval.type = CHAR;
					return INC;
				}
				
incb				{	
					yylval.type = CHAR;
					return INC;
				}
decl				{
					yylval.type = LONG;
					return DEC;
				}
decw				{
					yylval.type = SINT;
					return DEC;
				}
decb				{
					yylval.type = CHAR;
					return DEC;
				}
				
negl				{
					yylval.type = LONG;
					return NEG;
				}
negw				{
					yylval.type = SINT;
					return NEG;
				}
negb				{
					yylval.type = CHAR;
					return NEG;
				}

notl				{
					yylval.type = LONG;
					return NOT;
				}
								
notw				{
					yylval.type = SINT;
					return NOT;
				}

notb				{
					yylval.type = CHAR;
					return NOT;
				}

andl				{
					strcpy( yylval.name, "&" );
					opcode = LONG;
					return OPCODE;
				}
andw				{
					strcpy( yylval.name, "&" );
					opcode = SINT;
					return OPCODE;
				}
	
andb				{
					strcpy( yylval.name, "&" );
					opcode = CHAR;
					return OPCODE;
				}
				
orl				{
					strcpy( yylval.name, "|" );
					opcode = LONG;
					return OPCODE;
				}

orw				{
					strcpy( yylval.name, "|" );
					opcode = SINT;
					return OPCODE;
				}

orb				{
					strcpy( yylval.name, "|" );
					opcode = CHAR;
					return OPCODE;
				}
				
xorl				{
					strcpy( yylval.name, "^" );
					opcode = LONG;
					return OPCODE;
				}
xorw				{
					strcpy( yylval.name, "^" );
					opcode = SINT;
					return OPCODE;
				}
xorb				{
					strcpy( yylval.name, "^" );
					opcode = CHAR;
					return OPCODE;
				}

sall				{
					strcpy( yylval.name, "<<" );
					opcode = LONG;
					return OPCODE;
				}

salw				{
					strcpy( yylval.name, "<<" );
					opcode = SINT;
					return OPCODE;
				}

salb				{
					strcpy( yylval.name, "<<" );
					opcode = CHAR;
					return OPCODE;
				}


shll				{
					strcpy( yylval.name, "<<" );
					opcode = LONG;
					return OPCODE;
				}
shlw				{
					strcpy( yylval.name, "<<" );
					opcode = SINT;
					return OPCODE;
				}
shlb				{
					strcpy( yylval.name, "<<" );
					opcode = CHAR;
					return OPCODE;
				}


sarl				{
					strcpy( yylval.name, ">>" );
					opcode = LONG;
					return OPCODE;
				}

sarw				{
					strcpy( yylval.name, ">>" );
					opcode = SINT;
					return OPCODE;
				}

sarb				{
					strcpy( yylval.name, ">>" );
					opcode = CHAR;
					return OPCODE;
				}


shrl				{
					strcpy( yylval.name, ">>" );
					opcode = LONG;
					return OPCODE;
				}
shrw				{
					strcpy( yylval.name, ">>" );
					opcode = SINT;
					return OPCODE;
				}
shrb				{
					strcpy( yylval.name, ">>" );
					opcode = CHAR;
					return OPCODE;
				}



movl				{
					yylval.type = LONG;
					return MOV;
				}

movw				{
					yylval.type = SINT;
					return MOV;
				}

movb				{
					yylval.type = CHAR;
					return MOV;
				}

movsbl				{
					yylval.type = SIGNED;
					return MOVBL;
				}
movzbl				{
					yylval.type = UNSIGNED;
					return MOVBL;
				}



movsbw				{
					yylval.type = SIGNED;
					return MOVBW;
				}
movzbw				{
					yylval.type = UNSIGNED;
					return MOVBW;
				}


movswl				{
					yylval.type = SIGNED;
					return MOVWL;
				}
movzwl				{
					yylval.type = UNSIGNED;
					return MOVWL;
				}

				
cmpl				{
					yylval.type = LONG;
					return CMP;
				}
cmpw				{
					yylval.type = SINT;
					return CMP;
				}
cmpb				{
					yylval.type = CHAR;
					return CMP;
				}
testl				{
					yylval.type = LONG;
					return TEST;
				}
testw				{
					yylval.type = SINT;
					return TEST;
				}
testb				{
					yylval.type = CHAR;
					return TEST;
				}

{NUMBER}\(%ebp\)	{
				yylval.num = 
				atoi( string( yytext , yytext + yyleng - 6 ) );
				return STACKVAR;
			}

leal				return LEAL;

{NUMBER}[(]{REGISTER}[)]	{
					temp.assign( yytext,
							yytext + yyleng - 6 );
					yylval.num = atoi( temp );
					yyless( temp.size( ) );
					return NUM;
				}


{IDENTIFIER}[+]{NUMBER}		{
					temp.assign( yytext );
					int x = temp.find( "+" );
					temp.assign( yytext, yytext + x );
					strcpy( yylval.name, temp.c_str( ) );
					yyless( x + 1 );
					return ARRAYNAME;
				}

				
{IDENTIFIER}[(][,]{REGISTER}[,]{NUMBER}[)]	{

				temp.assign( yytext );
				int x = temp.find( "(" );
				tempArray.name.assign( yytext, yytext + x );
				strcpy( yylval.name, tempArray.name.c_str( ) );
				int y = temp.find_last_of( "," );
				tempArray.regs.assign( yytext + x + 2,
								 yytext + y );
				tempArray.size = atoi( 	string( yytext + y + 1,
							yytext + yyleng - 1
							) );
				return ARRAYNAME;	
			}


[(]{REGISTER}[)]		{
					temp.assign( yytext + 1,
							yytext + yyleng - 1 );
					strcpy( yylval.name, temp.c_str( ) );
					return POINTER;
				}


[(]{REGISTER},{REGISTER}[)]	{
					temp.assign( yytext + 1, yytext + 5 );
					temp += string( yytext + 6, yytext + 10 );
					strcpy( yylval.name, temp.c_str( ) );
					return SUM;
				}

%esp				return ESP;

[(]%esp[)]			return PTRESP;

%ebp				return EBP;


%eax |
%ebx |
%ecx |
%edx |
%ebp |
%edi |
%esi				{ 
					strcpy( yylval.name, yytext );
					return REGS;	
				}

%ax |
%bx |
%cx |
%dx				{	
					char reg[] ={'%', 'e', ' ', 'x', '\0' };
					reg[ 2 ] = yytext[ 1 ];
					strcpy( yylval.name, reg );
					return REGS;
				}

%si|%di|%bp|%sp			{
					cout << "Index registers used\n";
					abort( );
				}
%(al|ah) |
%(bl|bh) |
%(cl|ch) |
%(dl|dh)			{
					char reg[] ={'%', 'e', ' ', 'x', '\0' };
					reg[ 2 ] = yytext[ 1 ];
					strcpy( yylval.name, reg );
					return REGS;
				}

%st				{
					yylval.num = 0;
					return FLOATREG;
				}

%st\({NUMBER}\)			{
					temp.assign( yytext + 4,
							yytext + yyleng - 1 );
					yylval.num = atoi( temp );
					return FLOATREG;
				}

fld1				return FLD1;
fldz				return FLDZ;

fld				{
					yylval.type = FLOAT;
					return FLD;
				}
flds				{
					yylval.type = FLOAT;
					return FLD;
				}
fldl				{
					yylval.type = DOUBLE;
					return FLD;
				}
fldt				{
					yylval.type = LDOUBLE;
					return FLD;
				}

fild				{
					yylval.type = LONG;
					return FILD;
				}
filds				{
					yylval.type = SINT;
					return FILD;
				}
fildl				{
					yylval.type = LONG;
					return FILD;
				}

fildll				return FILD;

fist				{
					yylval.type = LONG;
					return FIST;
				}
fists				{
					yylval.type = SINT;
					return FIST;
				}
fistl				{
					yylval.type = LONG;
					return FIST;
				}
				
fistp				{
					yylval.type = LONG;
					return FISTP;
				}
fistps				{
					yylval.type = SINT;
					return FISTP;
				}
fistpl				{
					yylval.type = LONG;
					return FISTP;
				}

fistpll				return FISTPLL;

fsts				{
					yylval.type = FLOAT;
					return FST;
				}
fstl				{
					yylval.type = DOUBLE;
					return FST;
				}
fstt				{
					yylval.type = LDOUBLE;
					return FST;
				}

fstp				{
					yylval.type = FLOAT;
					return FSTP;
				}

fstps				{
					yylval.type = FLOAT;
					return FSTP;
				}
fstpl				{
					yylval.type = DOUBLE;
					return FSTP;
				}
fstpt				{
					yylval.type = LDOUBLE;
					return FSTP;
				}

fadd				{
					yylval.type = FLOAT;
					return FADD;
				}
fadds				{
					yylval.type = FLOAT;
					return FADD;
				}
faddl				{
					yylval.type = DOUBLE;
					return FADD;
				}
faddt				{
					yylval.type = LDOUBLE;
					return FADD;
				}

fiadd				{
					yylval.type = LONG;
					return FIADD;
				}
fiadds				{
					yylval.type = SINT;
					return FIADD;
				}
				
fiaddl				{
					yylval.type = LONG;
					return FIADD;
				}

faddp				return FADDP;

fsub				{
					yylval.type = FLOAT;
					return FSUB;
				}
fsubs				{
					yylval.type = FLOAT;
					return FSUB;
				}
fsubl				{
					yylval.type = DOUBLE;
					return FSUB;
				}
fsubt				{
					yylval.type = LDOUBLE;
					return FSUB;
				}

fsubp				return FSUBP;

fsubr				{
					yylval.type = FLOAT;
					return FSUBR;
				}
				
fsubrs				{
					yylval.type = FLOAT;
					return FSUBR;
				}
fsubrl				{
					yylval.type = DOUBLE;
					return FSUBR;
				}
fsubrt				{
					yylval.type = LDOUBLE;
					return FSUBR;
				}

fsubrp				return FSUBRP;

fmul				{
					yylval.type = FLOAT;
					return FMUL;
				}
				
fmuls				{
					yylval.type = FLOAT;
					return FMUL;
				}
fmull				{
					yylval.type = DOUBLE;
					return FMUL;
				}
fmult				{
					yylval.type = LDOUBLE;
					return FMUL;
				}

fmulp				return FMULP;

fdiv				{
					yylval.type = FLOAT;
					return FDIV;
				}
				
fdivs				{
					yylval.type = FLOAT;
					return FDIVS;
				}
fdivl				{
					yylval.type = DOUBLE;
					return FDIVS;
				}
fdivt				{
					yylval.type = LDOUBLE;
					return FDIVS;
				}

fdivp				return FDIVP;

fdivr				return FDIVR;

fdivrp				return FDIVRP;

fnstsw				return FNSTSW;
fucompp				return FUCOMPP;
fnstcw				return FNSTCW;
fldcw				return FLDCW;

fabs				return FABS;
fchs				return FCHS;
fxch				return FXCH;

jmp				return JMP;

j[[:alpha:]]{1,2}		strcpy( yylval.name, yytext );return CJMP;

set[[:alpha:]]{1,2}		strcpy( yylval.name, yytext ); return CSET;

{IDENTIFIER}([.]{NUMBER})?	{
					strcpy ( yylval.name, yytext );
					return NAME;
				}

\.LC{NUMBER}+			{ 
					//a string label
					yylval.num = atoi( yytext + 3 );
					return STRINGLABEL;
			    	}

\.L{NUMBER}+		    	{ 
					//a loop label
			      		yylval.num = atoi(yytext + 2);
			      		return LABEL;
 			    	}			
	
{NUMBER}			{
					yylval.num = atoi(yytext);
					return NUM; 
				}

${HEX}				{
					strcpy( yylval.name, yytext );
					return HEXNUM;
				}
,|")"
<<EOF>>				return END;//end of file

%%

int yywrap( void )
{
	return 1;
}

