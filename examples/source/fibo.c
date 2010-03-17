#include<stdio.h>

/* this program finds the nth fibonacci number, where n is entered by the
user. the program uses double recursion and relipmoC correctly decompiles it.
*/

int findFiboN( long n );
int main( void )
{
	long n;
	int i;
	i = printf( "Enter the number: " );
	i = scanf( "%d", &n );
	i = printf( "The %d fibonacci number is: %d\n", n, findFiboN( n ) );
	return 0;
}

int findFiboN( long n )
{
	int i;
	if ( n <= 1 )
		return n;

	i = findFiboN( n - 1 ) + findFiboN( n - 2 );
	return i;
}

