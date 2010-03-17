#include"floatstack.h"

using namespace std;
FloatType FloatStack::temp;

FloatStack::FloatStack( void ) : floatReg( 8 ), top( 0 )
	{}

/*  swap the value at pos1 with that at pos2 */
/* the values pos1 and pos2 are measured from top of the stack */
void FloatStack::swap( long pos1, long pos2 )
{
	temp = at( pos1 );
	at( pos1 ) = at( pos2 );
	at( pos2 ) = temp;
}

/* push a onto the stack */
void FloatStack::push( const string a )
{
	floatReg.at( top++ ) = a;
}

/* push the element at "pos" onto the stack */
/* pos is measured from the top of the stack */
void FloatStack::pushFrom( long pos )
{ 
	push( at( pos ) );
}

/* return the value at the top of the stack  */
const string &FloatStack::seetop( void )
{
	return at( 0 );
}

const string &FloatStack::pop(void)
{
	return floatReg.at( --top );
}

/* store a at "pos" */
/* pos is measured from the top of the stack */
void FloatStack::storeAt(long pos, const string a)
{
	at( pos ) = a;
}

string &FloatStack::at( long pos )
{
	return floatReg.at( top - pos - 1);
}

void FloatStack::print(void)
{
	for ( int i = 0; i < top; ++i )
		cout << at( i ) << endl;
}

