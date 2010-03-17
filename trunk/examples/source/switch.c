/* this test case includes a character variable and a switch statement.
relipmoC converts all switch statements into equivalent if..else statements.
gcc implements the switch statement by first collecting all the case lables
and then sorts them. It then generates code which performs a binary search over
the sorted case labels to match the argument to the switch statement, which
in the below program is the value contained in the variable "var". So the 
output of relipmoC reflects this, i.e., it would contain a series of
if..else statements which do a binary search.
*/

char var = 'z';
float c = -23.6711;

int main( void )
{
	switch( var ) {

		case 'a':
			++var;
			break;
		case 'm':
			--c;
			break;
		default:
			var += 'a' + 'z';
			break;
	}

	return 0;
}

