/* this test case contains all the operators available under C.
The conditional operator would be converted to an equivalent if..else statement.
*/

long arjun;
long darshan;
float farjun;
float fdarshan;

int main( void )
{
	++arjun;
	darshan++;

	--arjun;
	darshan--;

	arjun = !darshan;
	arjun = ~darshan;
	
	arjun = arjun + darshan	;
	arjun = arjun - darshan	;

	arjun = arjun * darshan	;
	arjun = arjun % darshan	;
	farjun = farjun / darshan;


	arjun = arjun | darshan	;
	arjun = arjun & darshan	;
	arjun = arjun ^ darshan	;

	farjun = darshan << 4;
	darshan = arjun >> 3;
	
	arjun = farjun <= darshan;

	arjun = farjun && darshan;

	arjun = arjun < farjun ? darshan : fdarshan;

	return 0;
}


