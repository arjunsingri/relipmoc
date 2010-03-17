#ifndef __LABELTAB__RELIPMOC__H
#define __LABELTAB__RELIPMOC__H

using namespace std;
#include<map>
#include<vector>
#include<string>
#include<iostream>

class LabelTab {
    
private:
	typedef pair< int, int > LabelType; 
	map< int, int > labelList;
    	static int lab;
public:
	typedef map< int, int >::iterator iterator;
	typedef map< int, int >::const_iterator const_iterator;

	LabelTab( void );
	void insert( int , int = 0 );
	int getBlkNo( int );
	void update( int , int );	
	void print( void );
	~LabelTab( void ) {}
	static int tempLabel( void );

	iterator begin( void ) { return labelList.begin( ); }
	iterator end( void ) { return labelList.end( ); }
	
	const_iterator begin( void ) const { return labelList.begin( ); }
	const_iterator end( void ) const { return labelList.end( ); }
};
#endif

