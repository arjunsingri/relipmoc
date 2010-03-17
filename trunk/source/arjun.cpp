#include"arjun.h"

using namespace std;

string itoa( long long num )
{
	ostringstream out;
	out << num;
	return out.str( );
}

string itoa( int num )
{
	return itoa( ( long long )num );
}

//overloaded atoi
int atoi( const string &a )
{
	return atoi( a.c_str( ) ); 
}

/*  convert s from hexadecimal to decimal  */
long htoi( const string &s )
{
	int start = 0;
	if ( s.at( 0 ) == '0' && ( s.at( 1 ) == 'x' || s.at( 1 ) == 'X' ) )
		start += 2;
	
	long pow = 1;
	long sum = 0;
                                                                                
	for ( int i = s.size( ) - 1; i >= start; --i, pow <<= 4 )
		sum += pow *
		(isalpha( s.at( i ) ) ? ( s.at( i ) - 'a' + 10 ):s.at(i) - '0');
	
	return sum;
}

string ftoa( long double num )
{
	ostringstream out;
	out.precision( PRECISION );
	out << num;
	return out.str( );
}

string ftoa( float num )
{
	return ftoa( ( long double )num );
}

string convert(const string &a)
{
	if (a == "ja" || a == "jg" || a == "seta" || a == "setg")
		return ">";
		
	if (a == "je" || a == "jz" || a == "sete" || a == "setz")
		return "==";

	if (a == "jge" || a == "jae" || a == "setge" || a == "setae")
		return ">=";

	if (a == "jb" || a == "jl" || a == "setl" || a == "setb")
		return "<";

	if (a == "jbe" || a == "jle" || a == "setbe" || a == "setle")
		return "<=";

	if (a == "jne" || a == "jnz" || a == "setne" || a == "setnz")
		return "!=";
	cerr << "No match for " << a << " in function convert" << endl;
	abort();
}

string rev(const string &a)
{
	if (a == ">")
		return "<=";
	if (a == "<=")
		return ">";
	
	if (a == "==")
		return "!=";
	if (a == "!=")
		return "==";

	if (a == ">=")
		return "<";
	if (a == "<")
		return ">=";
	cerr << "\nNo match for " << a << " in function rev" << endl;
	abort();
}

string convert2Float( int num )
{
        if ( num == 0 )
		return 0;
                                                                                
        bool sign = num & 0x80000000;
        int exp = num >> 23;	//remove significand
        exp &= 0x000000FF;
        exp -= 0x7F;		//de - bias
        
	int signi = num & 0x007FFFFF;	//get significand
	
        string a;
        for ( int i = 23; i >= 1; --i, signi >>= 1 )
                a.push_back( ( signi & 1 ) + '0' );
                                                                                
        a.push_back( '1' );			//the default '1'
        reverse( a.begin( ), a.end( ) );

        if ( exp >= 0 )
                a.insert( a.begin( ) + exp + 1, '.' );
        else {
                for ( int i = exp; i < 0; i++ )
                        a.insert( a.begin( ), '0' );
                a.insert( a.begin( ) + 1, '.' );
        }
	
	int pos = a.find('.');
        int msb = 0;
        int pow = 1;
                                                                                
        for (int i = pos - 1; i >= 0; i--) {
                msb += (a[i] - '0') * pow;
                pow <<= 1;
        }
        long double lsb = 0;
        pow = 2;
        for (int i = pos + 1; i < a.size(); i++) {
                lsb += (float)(a[i] - '0') / pow;
                pow <<= 1;
        }
	ostringstream out;
	out.precision( PRECISION );
	out << ( sign ? -(msb + lsb) : msb + lsb ) ;
	return out.str( );
}

/* convert asciiVal to its character representation */

string getChar( int asciiVal )
{
	string t = "\'";

	switch ( asciiVal ) {

		case '\'': 
				t.append( "\\\'" );
				break;
		case '\"': 
				t.append( "\\\"" );
				break;
		case '\n': 
				t.append( "\\n" );
				break;
		case '\r': 
				t.append( "\\r" );
				break;
		case '\f':
				t.append( "\\f" );
				break;
		case '\v': 
				t.append( "\\v" );
				break;
		case '\a': 
				t.append( "\\a" );
				break;
		case '\t': 
				t.append( "\\t" );
				break;
		case '\\': 
				t.append( "\\\\" );
				break;
		case '\0':
				t.append( "\\0" );
				break;
		default:
			t.push_back( asciiVal );
			break;
	}
	t.push_back( '\'' );
	return t;
}

