#include"basicblock.h"
#include"blocktab.h"
#include"labeltab.h"
#include<stdlib.h>

BlockTab::BlockTab( void )
{
	curBlockNum = 1; 
	blockList.push_back( 0 );
}

void BlockTab::print( ostream &out )
{
	vector< bool > visited( curBlockNum + 1, false );
	print( blockList[ 1 ], visited, out );
}

void BlockTab::print( BasicBlock *p, vector< bool > &visited, ostream &out )
{
	if ( p && visited[ p -> no ] == false ) {
		visited[ p -> no ] = true;
		
		out << p -> no << "  " << "Taken: " << p -> getTakenNo( ) << "  ";
		out << "NTaken: " << p -> getNTakenNo( ) << endl;
//		p -> print( );	
		print( p -> getTakenPtr( ), visited, cerr );
		print( p -> getNTakenPtr( ), visited, cerr );
	}
}

//blockList will contain a single block as all the blocks would have been merged
BlockTab::~BlockTab( void )
{
	if ( blockList.size( ) == 2 )
		delete blockList[ 1 ];
}

BasicBlock *& BlockTab::operator[] (int i ) 
{
	return blockList[ i ];
}

const BasicBlock *const BlockTab::operator[] (int i ) const
{
	return blockList[ i ];
}

void BlockTab::insert( BasicBlock *p, int t, int nt )
{
	p -> no = curBlockNum;
	p -> TakenNo( t );
	p -> NTakenNo( nt );
	blockList.push_back( p );
}

BasicBlock *BlockTab::linkBlocks( LabelTab &curLabelTab )
{
	int i;
	for ( i = 1; i <= curBlockNum; i++ ) {
		int n = curLabelTab.getBlkNo( blockList[i] -> getTakenNo( ) );
	        BasicBlock *t = blockList[ n ];
        
		blockList[ i ] -> TakenPtr( t );

        	if ( t != 0 ) {
            		t -> predecessors.insert( blockList[ i ] );
			blockList[ i ] -> TakenNo( t -> no );
		}
        
		n = curLabelTab.getBlkNo( blockList[ i ] -> getNTakenNo( ) );
        	t = blockList[ n ];
		blockList[ i ] -> NTakenPtr( t );

        	if ( t != 0 ) {
            		t -> predecessors.insert(blockList[ i ] );	
			blockList[ i ] -> NTakenNo( t -> no );
		}
	}
	return i == 1 ? 0 : blockList[ 1 ];
}

void BlockTab::number( void )
{
	int n = curBlockNum;
	number( blockList[ 1 ], n );
}

void BlockTab::number( BasicBlock *p, int &n )
{
	if ( p != 0 && p -> visited == false ) {
		p -> visited = true;

		number( p -> getTakenPtr( ), n );

		number( p -> getNTakenPtr( ), n );

		p -> no = n--;
		for ( BBSet::iterator i = p -> predecessors.begin( );
					i != p -> predecessors.end( ); i++ ) 
			if ( ( *i ) -> getTakenPtr( ) == p ) 
				( *i ) -> TakenNo( p -> no );
			else 
				( *i ) -> NTakenNo( p -> no );
		swap( p, blockList[ p -> no ] );
	}
}

void BlockTab::findIntervals( void )
{
	vector< bool > visited( curBlockNum + 1, false );
	list< BasicBlock * > left;
	left.push_back( blockList[ 1 ] );        //entry node
	visited[ blockList[ 1 ] -> no ] = true;
	
	while ( !left.empty( ) ) { 
		Interval current;	
		current.Head( *left.begin( ) );
		bool added = true;
		while ( added == true ) {
		added = false;
		for ( list< BasicBlock * >::iterator i = left.begin( );
							i != left.end( ); ) {
//includes:check if first set includes the second set 

			if ( current.Head( ) == *i || 
				includes( current.begin( ), current.end( ), 
				( *i ) -> predecessors.begin( ), 
						(*i) -> predecessors.end())) {

				current.insert(*i);
				(*i) -> head = current.Head();
               			if ((*i) -> getTakenPtr() && 
					!visited[(*i) -> getTakenPtr() -> no]) {
					
				    visited[(*i) -> getTakenPtr() -> no] = true;
					left.push_back((*i) -> getTakenPtr());
					added = true;
				}
	       			if ((*i) -> getNTakenPtr() && 
					!visited[(*i)-> getNTakenPtr() -> no]) {
				   visited[(*i) -> getNTakenPtr() -> no] = true;
					left.push_back((*i) -> getNTakenPtr());
					added = true;
				}
				left.erase(i++); 
	       		}
			else
				i++;
		}
		}
		all.push_back(current);
	}
}

//reduce all the intervals into a single node

void BlockTab::reduce(void)
{
	number( );
	if ( CFG ) {	
		print( cerr );
		throw EXIT_SUCCESS;
	}
	if ( INTERVALS ) {
		findIntervals( );
		for ( Intervals::iterator i = all.begin( ); 
							i != all.end( ); ++i ) {
			i -> print(cerr ); 
			cerr << endl;
		}
		throw EXIT_SUCCESS;
	}
	do {
		all.resize( 0 );
		findIntervals( );
/* reduce each interval starting from the bottom-most one */
		for ( Intervals::reverse_iterator curI = all.rbegin( );
					curI != all.rend( );  ++curI ) {
			bool r;
			applyT2( );
			if ( r = curI -> findLoops( ) )
				curI -> findLoopType( );

			curI -> findConditionals( );
			applyT2( );
			if ( r )
				curI -> reduceLoop( );
		}
	} while ( all.size( ) > 1 );
}

//return the interval to which p belongs
Intervals::iterator BlockTab::whichInterval(BasicBlock *p)
{
	Intervals::iterator j = all.begin();
	while ( j != all.end() && (*j).Head() -> no != p -> head -> no )
		j++;
	return j;
}

void BlockTab::applyT2(void)
{
	vector<bool> visited(curBlockNum + 1, false);
	applyT2(blockList[1], visited);
}

void BlockTab::applyT2(BasicBlock *p, vector<bool> &visited)
{
	if ( p && visited[ p -> no ] == false ) {

		visited[ p -> no ] = true;
		Intervals::iterator j;
		while ( p -> canT2BeApplied( ) ) {
			BasicBlock *temp = p -> getTakenPtr();
			j = whichInterval( temp );

			if ( find( j -> latchNodes.begin( ),
					j -> latchNodes.end( ), temp ) 
					!= j -> latchNodes.end( )
				)
				j -> latchNodes.push_back(temp);
				j -> erase(temp);
				p -> applyT2();
				if ( j -> size( ) == 0 )
					all.erase( j );
		}

		applyT2(p -> getTakenPtr(), visited);
		applyT2(p -> getNTakenPtr(), visited);
	}
}
