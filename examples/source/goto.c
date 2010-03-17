#include<stdio.h>

/* this program implements a loop using goto statements.
when the assembly code corresponding to this code is decompiled by
relipmoC, the output would contain a "while" loop. 
relipmoC can "handle" goto statements as long as they can be converted to 
equivalent loop constructs, otherwise relipmoC fails, i.e., it goes into
an infinite loop. You might think that relipmoC should atleast print a
message saying that it can not handle it. But the problem in the first place
is recognizing that such a case exists.
*/

int main( void )
{
	int x;
	int i = scanf( "%d", &x );
begin:	if ( x > 0 )
		goto end;
	i = printf( "Hello, world\n" );
	++x;
	goto begin;
end:
	i = printf( "%d", x );
	return 0;
}

