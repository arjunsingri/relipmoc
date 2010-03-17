#ifndef __RELIPMOC_FUNCTAB__H
#define __RELIPMOC_FUNCTAB__H

#include<map>
#include<string>
#include"actrecord.h"

using namespace std;

class FuncTab {
                                                                                
	map< string, ActRecord > funcTab;
	typedef pair< string, ActRecord > Index;
public:
	ActRecord & getActRecord( const string &funcName );
	ActRecord & operator[ ] ( const string &funcName );
                                                                                
	void insert( const string &funcName, const ActRecord &funcRecord );
	int size( void ) { return funcTab.size( ); }

	typedef map< string, ActRecord >::iterator iterator;

	iterator begin( void ) { return funcTab.begin( ); }
	iterator end( void ) { return funcTab.end( ); }
                                                                                
	typedef map< string, ActRecord >::const_iterator const_iterator;

	const_iterator begin( void ) const { return funcTab.begin( ); }
	const_iterator end( void ) const { return funcTab.end( ); }
};
#endif

