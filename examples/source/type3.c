#include<stdio.h>

/* this program simply contains staements operating on variables of different
types. This isn't a "proper" test case, it was used mainly for debugging
relipmoC.
the assembly code would be correctly decompiled in this case.

*/

int a = 0,b=9;
unsigned char arjun;
float c,d;

static int arjunsingri=0;
static float singri = 9.2;
int function(long x,float y,long z,short int a, float b, float c, long d, float e, long f);
int main(void)
{
	static long arjunsingri = 3;
	float singri = 3;
	short int a;
	int z;

	if ( a > b > a + b )
		arjunsingri = arjun << 3;
	++z;
	singri = singri + 3;
	a = arjun;
	arjunsingri = a << 1;	

	arjun = arjun + 4;

	arjun = c / z;
	a = a / arjun;
	if ( arjun == 1 )
	a = scanf("%d",&singri);

	arjun = singri;

	arjunsingri = (long)(arjun);

	arjun = function(arjun, singri,arjun,a,arjunsingri,singri,arjun,c,b);
	++arjunsingri;

	++a;
	c = ++d;
	return 0;
}

int function(long x,float y,long z,short int a, float b, float q, long d, float e, long f)
{

	++x;
	++y;
	++z;
	++a;	
	++b;
	++e;
	d = y;
	q = y;
	++singri;
	arjunsingri = d/a+y -  z+b+q*y;
	a = arjunsingri + b + c;
	d = f + e + a;
	arjunsingri = d;
	++arjunsingri;

	return d;
}

