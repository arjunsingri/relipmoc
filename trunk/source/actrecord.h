#ifndef __RELIPMOC__ACTRECORDS__H
#define __RELIPMOC__ACTRECORDS__H

#include<string>
#include<map>
#include"symtab.h"
#include"syminfo.h"

using namespace std;
extern SymTab curSymTab;
extern string PREFIX;

class ActRecord {

	map< int, SymInfo > aRecord;
	typedef int Index;
	typedef map< int, SymInfo >::value_type ActRecordEntry;
	SYMTYPE retType;	//return type
	string retValue;	//return value

	string generateStaticDecls( void ) const;
public:
/* maximum offset in the stack for a local variable of this function
   stored as as positive integer
*/
        int maxLocalOffset;

/* maximum number of local variables */
	int maxLocals;                                                                                
/*      maximum offset in the stack for a passed parameter variable of this
        function
        stored as as positive integer
*/
        int maxParOffset;
/* maximum number of parameters */
	int maxPars;

//name of the function to which this record belongs to
	string fName;

	ActRecord( void );

	SymInfo & operator[ ] ( const Index a );
	SymInfo &at( const Index a );
	SymInfo &insert( const Index offset, const SymInfo& par = SymInfo( ) );

	bool empty( void ) const { return aRecord.empty( ); }
	int size( void ) const { return aRecord.size( ); }

	string getName( void ) const { return fName; }
	SYMTYPE getRetType( void ) const { return retType; }
	const string getRetValue( void ) const { return retValue; }
	bool isParameter( const int offset );
	bool isLocalVariable( const int offset );
	bool isTemp( const int offset );

	void setName( const string &fnam ) { fName = fnam; }
	void setRetType( SYMTYPE type ) { retType = type; }
	void setRetValue( const string &val ) { retValue = val; }
	string getPrototype( void ) const ;
	string generateCall( const string funcName );
	string generateFuncDefn( void ) const;
	string generateLocalDecls( void ) const;
	
	typedef map< int, SymInfo >::iterator iterator;	
	iterator begin( void ) { return aRecord.begin( ); }
	iterator end( void ) { return aRecord.end( ); }
	
	typedef map< int, SymInfo >::const_iterator const_iterator;	
	const_iterator begin( void ) const { return aRecord.begin( ); }
	const_iterator end( void ) const { return aRecord.end( ); }
	
	typedef map< int, SymInfo >::reverse_iterator reverse_iterator;	
	reverse_iterator rbegin( void ) { return aRecord.rbegin( ); }
	reverse_iterator rend( void ) { return aRecord.rend( ); }
	
	typedef map< int, SymInfo >::const_reverse_iterator 
							const_reverse_iterator;	
	const_reverse_iterator rbegin( void ) const { return aRecord.rbegin( ); }
	const_reverse_iterator rend( void ) const { return aRecord.rend( ); }
};

string genUniqName( int );
#endif
