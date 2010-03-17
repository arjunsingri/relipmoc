#include<stdio.h>
#include<stdlib.h>


/*  program to print all armstrong numbers upto the  given number  */
/* an armstrong number is a number which is such that the sum of the cubes
of the digits making up the number is equal to the number itself.
ex: 153 = 1^3 + 5^3 + 3^3
where "^" means "to the power"
*/

int isarmstrong(long int );
int isprime(long int );
int power( int x, int y );

int main(void)
{
	long int num, i;
	int j;
	j = printf("Enter the number : ");
	j = scanf("%ld", &num);
	j = printf( "The armstrong number upto %d are\n", num );
	for (i = 1; i <= num; ++i)
		if (isarmstrong(i)) 
			j = printf("%ld\n", i);
	return 0;
}

int isarmstrong(long int n)
{
	long int i, sum, tem, temp;
	volatile int div = 10;
	i = sum = 0;
	tem = temp = n;

	while (n) {
		n = n / div;  /*  i = no of digits in the number  */
		++i;
	}

	while (tem) {
		sum += power(tem % div, i);
		tem /= div;
	}

	if (temp == sum)
		return 1;
	return 0;

}

int isprime(long int n)
{
	long int i, j;
	int r = 1;
	for (i = 2; i * i <= n; i += 2)
		if ( n % i == 0 )
			r = 0;
	return r;
}

int power( int x, int y )
{
	int prod = 1;
	int i;
	for ( i = 1; i <= y; ++i )
		prod = prod * x;
	return prod;
}
