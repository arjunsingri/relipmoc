#include<stdio.h>

/* when the assembly equivalent of this code is decompiled the "for" loop
would be converted to an equivalent "while" loop. this because there isn't a
concept of "for loops" in assembly statements and the compiler generates the
same code for both "while" and "for" loops.
The other statements are just there to show that "relipmoC" can handle them.
*/

int var, i = 3;

int main( void )
{
	for ( i = var; i < 10; ++i )
		++var;

	if ( var > 10 )
		var = i / var;
	else
		var = var ^ -i;

	return 0;
}

