#include"stringtab.h"

void StringTab::insert( const Index label, const string str )
{
	stringList.insert( StringType( label, str ) );
}

string StringTab::getString( const Index label )
{
	return stringList[ label ];
}

void StringTab::print( void )
{
	for ( const_iterator i = begin( ); i != end( ); ++i ) {
		cout << "Index: " <<  ( *i ).first << ' ';
		cout << ( *i ).second << endl;
	}
}

