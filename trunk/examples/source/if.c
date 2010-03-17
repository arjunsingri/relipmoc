#include<stdio.h>

/* the floating point constant "3.4" used below in the program would be
converted in to IEEE format for floating point numbers.
It is 1079613850 for 3.4

So relipmoC has to recoginize that b is a floating point variable and hence
the deduce that 1079613850 has to be converted back to 3.4
*/
 
int a = 0;
float b = 3.4;

int main( void )
{
	int i;
	if ( a == b )
		i = puts( "Hello, world\n" );
	else
		i = puts( "Bye, world\n" );

	return 0;
}

