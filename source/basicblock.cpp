#include"basicblock.h"

BasicBlock::BasicBlock( void ) : visited( false ), cmpOpFloat( false )
{}

//return the number of children of "this" basicblock
int BasicBlock::noChildren( void ) const
{
	return ( taken ? 1 : 0 ) + ( ntaken ? 1 : 0 );
}

BasicBlock* BasicBlock::getNewBlock( void )
{
	return new BasicBlock;
}

//insert instruction "instr" into "this" basicblock
void BasicBlock::insert( const string instr )
{
	instructions.insert( instr );
}

void BasicBlock::insert( int pos, const string instr )
{
	instructions.insert( pos, instr );
}

void BasicBlock::deleteAt( int pos )
{
	instructions.deleteAt( pos );
}

/* get the first instruction from the basic block */
string BasicBlock::first( void )
{
	return instructions.first( );
}

void BasicBlock::print( void ) const
{
/* print the instructions contained in this block */
	instructions.print( );
}

//q is assumed to have a single child : "taken"
void BasicBlock::mergeLink( BasicBlock *q, 
		BasicBlock *BasicBlock::*child, int BasicBlock::*childNo )
{
	if ( q ) {
		if ( q -> taken ) {
			BasicBlock *t;
			if ( q -> taken == this && q -> ntaken ) {
				t = q -> ntaken;
				this -> predecessors.erase( q );
			}
			else
				t = q -> taken;
			this ->* child = t;
			this ->* childNo = t -> no;
			t -> predecessors.erase( q );
			t -> predecessors.insert( this );
		}
		else {
			this ->* child = 0;
			this ->* childNo = 0;
		}
		delete q;
	}
//if p -> taken is pointing to itself p
//make p -> taken point to p -> ntaken and null p -> ntaken
	if ( getTakenPtr( ) == this ) {
		TakenPtr( getNTakenPtr( ) );
		NTakenPtr( 0 );
		TakenNo( getNTakenNo( ) );
		NTakenNo( 0 );
		predecessors.erase( this );
	}
}

/* copy the instructions in "*t" into "this" */
void BasicBlock::mergeInstructions( BasicBlock *t )
{
//	copy( t -> begin( ), t -> end( ), back_inserter( Instructions( ) ) );
	instructions.merge( t -> instructions );
}

/* return true if the T2 transformation can be applied and false otherwise */
bool BasicBlock::canT2BeApplied( void ) const
{
	if ( noChildren( ) == 1 )
		if ( this != getTakenPtr( ) 
			&& getTakenPtr( ) -> predecessors.size( ) == 1
			&& getTakenPtr( ) -> noChildren( ) <= 1 )
			return true;
	return false;
}

//merge "this" and getTakenPtr() into "this"
void BasicBlock::applyT2( void )
{
	mergeInstructions( this -> getTakenPtr( ) );
	mergeLink( getTakenPtr( ), &BasicBlock::taken, &BasicBlock::takenNo );
}

/* insert the if condition which is leftOp cmpOperator rightOp */
void BasicBlock::insertIfCond( void )
{
	insert( leftOp( ) );
	insert( rev( convert( cmpOperator( ) ) ) );
	insert( rightOp( ) );
}
