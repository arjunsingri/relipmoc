#include<stdio.h>

/* this program finds if the number entered by the user is a prime number
or not
*/

int main(void)
{
	int n, i, flag = 0;
	int j;
	j = printf( "\nENTER THE NUMBER\n" );
	j = scanf( "%d", &n );
	for ( i = 2; i < n; ++i )
		if ( flag == 0 )
	   		if ( n % i == 0 )
	   			flag = i;

	if ( !flag )
		j = printf("%d IS a prime number\n",n);
	else
		j = printf("%d IS NOT a prime number\n"
			"It is divisible by %d\n", n, flag);
	return 0;
	
}
