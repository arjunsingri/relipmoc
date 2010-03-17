#include<stdio.h>

/* this program finds the factorial of a number */

int factorial( int );

int main( void )
{
	int n;
	int i;
	i = printf( "Enter the number: " );
	i = scanf( "%d", &n );
	i = printf( "The factorial of %d is %d\n", n, factorial( n ) );
	return 0;
}

int factorial( int n )
{
	int prod = 1;
	int i;
	for ( i = 1; i <= n; ++i )
		prod = prod * i;

	return prod;
}

