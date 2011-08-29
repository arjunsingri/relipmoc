#ifndef __RELIPMOC__ARJUN__H
#define __RELIPMOC__ARJUN__H

#include<string>
#include<cassert>
#include<cstring>
#include<algorithm>
#include<iostream>
#include<sstream>
#include<iomanip>
#include<stdlib.h>

using namespace std;

extern int PRECISION;
//string itoa( long long );
string itoa( int );
int atoi( const string & );
long htoi( const string & );
string ftoa( float );
string convert( const string & );
string rev( const string & );
string convert2Float( int );
string getChar( int );

template< class U, class T > bool oneOf( U &container, T obj )
{
        return 
	find( container.begin( ), container.end( ), obj ) != container.end( );
}

#endif
