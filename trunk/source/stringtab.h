#ifndef __STRINGTAB__RELIPMOC__H
#define __STRINGTAB__RELIPMOC__H

using namespace std;
#include<string>
#include<map>
#include<vector>
#include<algorithm>
#include<iostream>

class StringTab {
public:
	typedef int Index;
private:
/*
	struct StringType : pair<Index, string> {
		
		StringType(const Index i, const string s) { }
		Index getIndex(void) { return first; }
		string getString(void) { return second; }
	};
*/
	typedef map< Index, string > StringContainer;
	typedef pair< Index, string > StringType;
	map< Index, string > stringList;
	
public:

	typedef StringContainer::iterator iterator;
	typedef StringContainer::const_iterator const_iterator;

	void insert( const Index , const string );
	string &operator[ ]( Index &i ) { return stringList[ i ]; }
	string getString( const Index );

	void print( void );

	iterator begin( void ) { return stringList.begin( ); }
	iterator end( void ) { return stringList.end( ); }
	
	const_iterator begin( void ) const { return stringList.begin( ); }
	const_iterator end( void ) const { return stringList.end( ); }
};

#endif

