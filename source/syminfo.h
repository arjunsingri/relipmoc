#ifndef __RELIPMOC__SYMINFO__H
#define __RELIPMOC__SYMINFO__H

using namespace std;
#include<string>
#include<map>
#include<fstream>
#include"arjun.h"

enum SYMTYPE { 	REG,
		UNSIGNED, SIGNED,
		NOTYPE, 
		CHAR, BYTE,
		SINT,
		INT, LONG, FLOAT,
		DOUBLE,
		LDOUBLE,
		STRING,
                FUNC,
	};

class SymTab;
class LabelTab;
class BlockTab;

class SymInfo {

	SYMTYPE type;
	
	int size;
	string name;	//name of this symbol
        string value;
        string initValue; //initial value
        
	bool _isArray;

	bool _seen;	//has the definition of this symbol been seen
	bool _static; 	//is the symbol a static symbol
	bool _local;  	//is the symbol a local static symbol
	bool isTemp;  	//is this symbol a temporary symbol
	bool _const; 	//must this symbol be qualified with "const"
	bool _unsigned; //is this symbol unsigned
	bool nameSet;
	bool isFixed;	//is the type fixed
	SymInfo *reference;	//another symbol to which this may refer to
	bool _isReg;		//is this a register  
public:
	mutable bool used;
	mutable bool defined;

	SymInfo( SYMTYPE = LONG, int = 0, const string = "" );

	void modInitValue( const string );
	void modType( SYMTYPE t );
	void fixType( SYMTYPE t );
	void modSize( int s ) { size = s; }
	void modValue( const string &v ) { value = v; }
	void modName( const string &a ) { name = a; }
	
	void makArray( void ) { _isArray = true; }
	void makStatic( void ) { _static = true; }
	void makLocal( void ) { _local = true; }
	void makConst( void ) { _const = true; }
	void makUnsigned( void ) { _unsigned = true; }

        SYMTYPE Type( void ) const { return type; }
        SYMTYPE getType( void ) const { return type; }
	const string getName( void ) const { return name; }
	const string getValue( void ) const { return value; }
        int getSize( void ) const { return size; }

	bool isArray( void ) const { return _isArray; }
	bool isStatic( void ) const { return _static; }
	bool isLocal( void ) const { return _local; }
	bool isConst( void) const { return _const; }
	bool isUnsigned( void ) const { return _unsigned; }
	bool isReg( void ) const { return _isReg; }

	void print( void );
	void declare( const string & , ostream & = cout ) const ;
	string declare( const string &, int ) const;
	friend class SymTab;
	friend int yyparse(LabelTab &, BlockTab &);
};

size_t sizeOfType( SYMTYPE a );
string e2str( SYMTYPE a ); //convert type a to "a"
SYMTYPE str2e( string a ); //convert "a" to type a
#endif

