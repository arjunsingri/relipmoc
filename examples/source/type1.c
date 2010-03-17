/* in this test case, the function f has been defined before its called. So
relipmoC encounters the function f before the main function. relipmoC doesn't
have backward propagation of types, there's only forward propagation.
when you decompile the assembly version of this program you will notice
that the types of the variables c and d in the argument list of function f
will be "int" instead of being "short int" and "char" respectively. This is
because there isn't enough information in the function f to deduce the types
of its arguments.
The information that is needed for the correct deduction is found in the
main function, but by then it is too late as the function f has already been
decompiled. This problem can be solved by storing the decompiled defintions of
all the functions till the end of the program. But this requires relatively 
more memory.
*/


long a;
long arjun = 232;
float b = 3.5;
long singri;

int f(int a, float b, short int  c, char d, int z)
{
	++a;
	++b;
	++c;
	return a+b+c+d+z;
}


int main(void)
{
	static int z=234;
	++b;

	return f(a, singri, arjun,b,b);
}


