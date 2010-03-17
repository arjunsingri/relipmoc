#include"functab.h"

void FuncTab::insert( const string &funcName, const ActRecord &funcRecord )
{
/* funcRecord will be inserted into funcTab if doesn't already exist. this will
   be automatically done by funcTab since its a "map"
*/
	iterator i = funcTab.find( funcName );
	ActRecord &rec = ( *i ).second;
	if ( i == end( ) )
        	funcTab.insert( Index( funcName, funcRecord ) );
	else if ( funcRecord.maxPars >= rec.maxPars )
		rec.maxPars = funcRecord.maxPars;
}
                                                                                
ActRecord & FuncTab::operator [ ] ( const string &funcName )
{
        ActRecord &r = funcTab[ funcName ];
        if ( r.getName( ).size( ) == 0 )
                r.setName( funcName );
        return r;
}

ActRecord& FuncTab::getActRecord( const string &funcName )
{
        return funcTab[ funcName ];
}
