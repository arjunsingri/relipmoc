#include<stdio.h>
#include<stdlib.h>

/* this program doesn't do any useful work.
It has been included in the test case to show that "relipmoC" can handle
such code.
*/

long a,b;

int function( long, long );

int main( void )
{
	int i = scanf("%d%d", &a, &b);
	i = function(a,b) + function(a,b) + function(a,b) * function(a,b) ^
	function(a,b) & function(a,b) | function(a,b) / function(a,b) % 
	function(a,b) + function(a,b) & function(a,b) - ( function(a,b) +
	 function(a,b) / function(a,b) * function(a,b) * function(a,b) %
 function(a,b) * function(a,b) ^ function(a,b) % function(a,b) | 
function(a,b) & function(a,b) - function(a,b) * function(a,b) +
 function(a,b) / function(a,b) * function(a,b) | function(a,b) ^
 function(a,b) % function(a,b) + function(a,b) / function(a,b) +
 function(a,b) + ( function(a,b) - function(a,b) * function(a,b) %
 function(a,b) ^ function(a,b)) + function(a,b) & function(a,b) -
 function(a,b) / function(a,b) * function(a,b) + function(a,b) )+
function(a,b) + function(a,b) * function(a,b) + function(a,b) / 
function(a,b) * function(a,b) * function(a,b) ^ function(a,b);
	i = printf( "a = %d b = %d i = %d\n", a, b, i );
	return 0;
}

int function( long x, long y )
{
	return y = x + a + b;
}

