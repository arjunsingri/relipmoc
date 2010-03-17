#ifndef __INSTRUCTIONS__RELIPMOC__H
#define __INSTRUCTIONS__RELIPMOC__H

#include<cstdlib>
#include<iostream>
#include<list>
#include<string>
using namespace std;

class InstContainer {

private:
	list< string > instructions;
	
public:
	InstContainer( void );
	~InstContainer( void );

	size_t size( void ) const;
	bool empty( void ) const;

	void insert( const string ins );
	void insert( int pos, const string ins );
	void deleteAt( int pos );

//end current sequence; begin a new one
	void merge( InstContainer &rhs );

	bool first( string & ) const;
	string first( void ) const;

	void print( void ) const;

	typedef list< string >::iterator iterator;
	typedef list< string >::const_iterator const_iterator;
	
	iterator begin( void ) { return instructions.begin( ); }
	iterator end( void ) { return instructions.end( ); }

	const_iterator begin( void ) const { return instructions.begin( ); }
	const_iterator end( void ) const { return instructions.end( ); }
};

#endif
