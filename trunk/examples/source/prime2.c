#include<stdio.h>

/* this program finds all the prime numbers between two numbers
*/

int main( void )
{
	int i,j,a,b,flag;
	int n = printf( "\nEnter the two numbers\n" );
	n = scanf( "%d %d", &a, &b);
	for ( i = a; i <= b; ++i ) {
		flag = 0;
		for ( j = 2; j < i ; ++j ) {
			if ( flag == 0 )
				if ( i % j== 0 )
					flag = i;
		}
		if ( flag == 0 )
			n = printf( "%d\t", i );
	}
	n = printf( "\n" );
	return 0;
}

