#include"syminfo.h"

SymInfo::SymInfo( SYMTYPE t, int s, const string val ) 
			: value( val ), _seen( false ),
			type( t ), isFixed( false ), size( s ), 
			_static( false ), _local( false ),
			isTemp( false ), _const( false ), _unsigned( false ),
			_isReg( false ), _isArray( false ),
			reference( 0 ), 
			nameSet( false )
{}

void SymInfo::fixType( SYMTYPE a  )
{
	SYMTYPE temp = type;
	type = a;
	isFixed = true;
}

void SymInfo::modType( SYMTYPE a )
{
	SYMTYPE temp = type;

	if ( _isReg == true ) 
		type = a;

	else if ( a > type && !isFixed ) 
		type = a;
	else {
		cerr << "Type of " << getName( ) << " NOT changed from " 
			<< e2str( temp ) << " to " << e2str( a ) << endl;
	}
}

void SymInfo::modInitValue( const string v )
{
	initValue = isTemp == true ? convert2Float( atoi( v )) : v;
}

string SymInfo::declare( const string &name, int ) const
{
	ostringstream out;
	declare( name, out );
	return out.str( );
}

void SymInfo::declare( const string &name, ostream &out ) const
{
 
	if ( isTemp == true )
		return;

	assert ( Type( ) != FUNC || !_isReg );

	if ( isStatic( ) )
		out << "static ";

	if ( isConst( ) )
		out << " const ";

	if ( isUnsigned( ) )
		out << " unsigned ";

	//output the type
	if ( Type( ) == NOTYPE ) {
		if ( getSize( ) == 4 )
			out << e2str( LONG ) << ' ';
		else if ( getSize( ) == 2 )
			out << e2str( SINT ) << ' ';
		else if ( getSize( ) == 1 )
			out << e2str( CHAR ) << ' ';
		else
			out << e2str( LONG ) << ' ';
	}
	else
		out << e2str( Type( ) ) << ' ';

	out << name;
	if ( isArray( ) )
		out << "[ " << getSize( ) / sizeOfType( getType( ) ) << " ]";

        if ( initValue.size( ) ) {
		out << "= ";
		if ( Type( ) == FLOAT )
			out << convert2Float( atoi( initValue ) );
		else if ( Type( ) == CHAR )
			cout << getChar( atoi( initValue ) );
		else
                	out << initValue;
	}
        out << ';';
}

size_t sizeOfType( SYMTYPE a )
{
	switch( a ) {
	
		case BYTE:	return sizeof ( char );
		
		case SINT: 	return sizeof ( short int );
		
		case INT:    	return sizeof ( int );
		
		case LONG:   	return sizeof ( long );
		
		case FLOAT:  	return sizeof ( float );
		
		case DOUBLE: 	return sizeof ( double );
		
		case LDOUBLE: 	return sizeof ( long double );
		
		default: cerr << "no match for " << a 
				<< " in function sizeOfType";
			abort();
	}
}

string e2str( SYMTYPE a )
{
        switch (a) {
                                                                                
		case STRING: return "char *";
		case CHAR: return "char";
		case BYTE: return "char";
		case SINT: return "short int";
		case INT:    return "int";
		case LONG:   return "int";
		case FLOAT:  return "float";
		case DOUBLE: return "double";
		case LDOUBLE: return "long double";

		case NOTYPE: 
	
				cerr << "Error: trying to convert NOTYPE";
				abort( );

		case FUNC: cerr << "Error: tyring to convert type FUNC";
				abort();

		case REG: cerr << "Error: trying to convert type REG";
				abort();

		default: cerr << "no match for " << a << " in function e2str";
			abort();
        }
}

SYMTYPE str2e( string a )
{
	if ( a == "byte" || a == "char" )
		return CHAR;
	if ( a == "short int" || a == "value" )
		return SINT;

	if ( a == "int" )
		return INT;
	if ( a == "long" )
		return LONG;
	if ( a == "float" )
		return FLOAT;

	if ( a == "" ) {
		cerr << "Error: trying to convert NOTYPE";
		abort( );
	}

	if ( a == "function" ) {
		cerr << "Error: tyring to convert type FUNC";
		abort();
	}
	cerr << "No match for " << a << " in function str2e";
	abort();
}

