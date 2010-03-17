#include"symtab.h"

SymTab::SymTab( void )
{
	SymInfo a( REG, 4 );
	a._isReg = true;
	insert( "%eax", a );
	insert( "%ebx", a );
	insert( "%ecx", a );
	insert( "%edx", a );
	insert( "%esp", a );
	insert( "%ebp", a );
	insert( "%edi", a );
	insert( "%esi", a );
}

void SymTab::insert( Index name, SymInfo a )
{
	pair< iterator, bool >ele = symbolList.insert( SymTabEntry( name, a ) );
	SymInfo &var = ( *ele.first ).second;
	const unsigned int pos = name.find( "." );;
	if ( pos != string::npos ) {
		name.erase( pos );
		var.makLocal( );
	}

	var.modName( name );
	var.modValue( name );
	var.nameSet = true;
}

SymTab::SymTabContainer::size_type SymTab::erase( Index name )
{
	return symbolList.erase( name );
}

SymInfo &SymTab::operator [ ] ( Index a )
{
	SymInfo &t = symbolList[ a ];
	if ( t.nameSet == false ) {
		t.modName( a );
		t.nameSet = true;
		if ( !t.getValue( ).size( ) )
			t.modValue( t.getName( ) );
	}
	return t;
}

#if 0
void SymTab::print(void)
{
	for (iterator i = begin(); i != end(); i++) {
		i -> second.print();
		cout << endl;
	}
}
#endif
