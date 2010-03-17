#include<stdio.h>

/* this test case contains a C structure. relipmoC decompiles the structure
variables to a series of local variables. But this only works under
special cases. in all others, relipmoC fails.
when generating the assembly code for a program, the compiler would have
converted the members of a local structure variable to addresses which are
identical to that of local variables. so the only to find if they are a part
of the structure is by analysing the instructions that operate on those
members. we have to look for instructions that operate on entire structures,
for ex: assignment statements. even this doesn't reveal enough information
for correct decompilation of structures.

*/

struct temp {
	int a;	
	short int b;
};

int main( void )
{
	struct temp x = { 234, 3}, y;
	int i;
	
	y.a = x.a + x.b + 1;
	y.b = x.a + x.b;
		
	i = printf("\ny.a = %d y.b = %d\n", y.a, y.b );

	return 0;
}

