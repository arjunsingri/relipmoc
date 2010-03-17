#include"instructions.h"

InstContainer::InstContainer( void ) 
{}

InstContainer::~InstContainer( void )
{}


size_t InstContainer::size( void ) const
{
	return instructions.size( );
}

bool InstContainer::empty( void ) const
{
	return instructions.empty( );
}

void InstContainer::insert( const string str )
{
	instructions.push_back( str );
}

void InstContainer::insert( int pos, const string str )
{
	int i;
	iterator curIns;
	for ( i = 0, curIns = begin( ); curIns != end( ) && i < pos;
								++i, ++curIns )
		;
	instructions.insert( curIns, str );
}

void InstContainer::deleteAt( int pos )
{
	int i;
	iterator curIns;
	for ( i = 0, curIns = begin( ); curIns != end( ) && i < pos;
								++i, ++curIns )
		;
	instructions.erase( curIns );
}

//end current sequence; begin a new one
void InstContainer::merge( InstContainer &rhs )
{
	instructions.splice( instructions.end( ), rhs.instructions );
}

/* return true and store the first instruction in str if the container is
	not empty, otherwise return false
*/
bool InstContainer::first( string &str ) const
{
	if ( empty( ) )
		return false;

	str = instructions.front( );
	return true;
}

/* return the first instruction when called for the first time. Every next time
	it is called return the next instruction in the container.
	return true if str contains a valid instruction and false if
	the container doesn't contain any more instructions.
*/

string InstContainer::first( void ) const
{
	if ( empty( ) )
		return "";

	return instructions.front( );
}

void InstContainer::print( void ) const
{
	for ( list< string >::const_iterator curIns = instructions.begin( );
				curIns != instructions.end( ); ++curIns )
		cout << *curIns;
}

