#include"actrecord.h"

ActRecord::ActRecord( void ) : 
			maxLocalOffset( 0 ), maxLocals( 0 ),
			maxParOffset( 0 ), maxPars( 0 ),
			retType( INT )
{}

/* 
  insert the symbol "par" with offset "offset" if itsn't already there 
   else return the symbol
*/
SymInfo & ActRecord::insert( const Index offset, const SymInfo &par)
{
	iterator i = aRecord.find( offset );
	pair< iterator, bool > ele;
/* symbol not found; insert it */
	if ( i == end( ) ) {
		ele = aRecord.insert( ActRecordEntry( offset, par ) );
		SymInfo &var = 	( *ele.first ).second;
		var.modName( genUniqName( offset ) );
		var.modValue( (*ele.first).second.getName( ) );
		if ( var.Type( ) == REG )
			var.modType( LONG );	//default type is LONG
		if ( maxLocalOffset > offset )
			maxLocalOffset = offset;
		return var;
	}
	else
		return ( *i ).second;
}

SymInfo & ActRecord::operator[ ] ( const Index a )
{
	return insert( a );
}

SymInfo & ActRecord::at( const Index a )
{
	return insert( a );
}

/* generate the function body */
string ActRecord::generateFuncDefn( void ) const
{
/* function name is null string - function defintion not found; must be a
	library function
*/
	if ( !fName.size( ) )
		return "";

	string decl = e2str( getRetType( ) ) + " " + fName + "(";
	const_iterator i = aRecord.lower_bound( 8 );
	
	if ( i == end( ) )
		decl += "void";	//no parameters
	else {
		int no = maxPars;
		for ( ; i != end( ); ++i, --no ) {
			const SymInfo &var = ( *i ).second;
			decl += e2str( var.Type( ) ) + " " + var.getName( );
			decl += ( no > 1 ? "," : "" );
		}
	}
	decl += ")";
	return decl;
}

/* generate the declarations for the local varaibles */
string ActRecord::generateLocalDecls( void ) const
{
	string decl = generateStaticDecls( );

/* no local variables found */
	if ( this -> empty( ) )
		return decl;

/*
	find the offset of the last local variable; this is the offset with the
	least value( < 0 ). if this offset is positive then there are no local
	variables.
*/
	decl += "\n\n";
	for ( const_reverse_iterator i = rbegin( ); i != rend( ); ++i ) {
		if ( ( *i ).first < 0 ) {
			const SymInfo &var = (*i).second;
			decl += var.declare( var.getName( ), 1 );
		}
	}
	return decl;
}

string ActRecord::generateStaticDecls( void ) const
{
	string decl;
	for ( SymTab::iterator i = curSymTab.begin( );
					i != curSymTab.end( );	++i ) {
		const SymInfo &var = ( *i ).second;
		if ( var.isLocal( ) ) {
			decl += var.declare( var.getName( ), 1 );
			curSymTab.erase( ( *i ).first );
		}
	}
	return decl;
}

//return "local"(-offset) if offset < 0 and "par"offset otherwise
string genUniqName( int offset )
{
	return PREFIX + ( offset < 0 ? "local_" : "par_" ) 
						+ itoa ( abs( offset ) );
}

