/* illustrates implict type conversions*/

char a = 'a';
int b;
float c = 1.618;

int main( void )
{	
	char int2char = -a;
	char float2char = a;
	
	int char2int = -a;
	int float2int = c;
	
	float char2float = c;
	float int2float = b;

	char2int += 3;	
	int2char--;
	++float2char;
	++char2float;
	return 0;
	
}

	
