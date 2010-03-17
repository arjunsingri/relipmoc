#include"blocktab.h"
#include"labeltab.h"
#include<stdlib.h>

Loop::Loop(void)
{
	lhead = 0;
	type = NONE;
}
//see if block a belongs to "this" loop
bool Loop::belongs(BasicBlock *a)
{
	return loopNodes.find(a) != loopNodes.end();
}

//insert p into the loop unless it is already there
//return true if inserted, false otherwise
bool Loop::insert(BasicBlock *p)
{
	return ( loopNodes.insert( p ) ).second;
}

Interval::Interval(void)
{
	ihead = 0;
}

Interval::iterator Interval::begin(void) 
{ 
	return interval.begin(); 
}

Interval::iterator Interval::end(void) 
{ 
	return interval.end(); 
}

void Interval::print( ostream &out )
{
	out << "Interval Head: " << ihead -> no << endl;
	out << "Nodes that belong to this interval: ";
	for (Interval::iterator i = begin(); i != end(); i++)
		out << (*i) -> no << ' ';
	out << endl;
}

//return true if "a" belongs to "this" interval, false otherwise
bool Interval::belongs(BasicBlock *a)
{
	return oneOf(interval, a);
}

void Interval::insert(BasicBlock *a)
{
	interval.insert(a);
}

void Interval::erase(BasicBlock *a)
{
	interval.erase(a);
	loopNodes.erase(a);
	BBVector::iterator j = find(latchNodes.begin(), latchNodes.end(), a);
	if (j != latchNodes.end())
		latchNodes.erase(j);
}

bool Interval::findLoops(void)
{
/* find the set of latching nodes for "this" iterval. this is done by finding
   the intersection of predecessors of the header and the nodes that belong
   to "this" interval
*/
	set_intersection( interval.begin( ), interval.end( ),
		ihead -> predecessors.begin( ), ihead -> predecessors.end( ),
						back_inserter( latchNodes ) );

	if ( latchNodes.size( ) == 0 )
		return false;
/* add all the predecessors of the all the latching nodes */
/* NOTE: all the latching nodes */
/* since an interval contains atmost one loop, all latching nodes determine 
   the same loop 
*/

/* find the nodes which belong to the loop determined by each of the latching 
	nodes and "lhead" 
*/	
	lhead = ihead;
	
	Loop::insert( lhead );
	
	for ( unsigned int i = 0; i < latchNodes.size( ); ++i ) {
		stack<BasicBlock *> s;
		if ( Loop::insert( latchNodes[ i ] ) )
			s.push( latchNodes[ i ] );

		while ( !s.empty( ) ) {
			BasicBlock *p = s.top( );
			s.pop( );
			for ( BBSet::iterator i = p -> predecessors.begin( );
					i != p -> predecessors.end( ); ++i )
				if ( Loop::insert( *i ) )
					s.push( *i );	
		}
	}
	return true;
}

// find the type (pre-tested, post-tested, endless) the loop of "this" interval

void Loop::findLoopType(void)
{
/* 
*	there are two latching nodes to "this"'s  interval head, has to 
*	contain a pre-tested loop 
*/
/*	if (latchNodes.size() >= 2)
		type = PRE;
	else*/ {
		if (latchNodes[0] -> noChildren() == 2) {
			if (lhead -> noChildren() == 2) {
				if ( lhead == latchNodes[ 0 ] )
					type = POST;
/* 
*  if both the children of the header node belong to "this"'s loop, then  the 
*  loop has to be a post-tested loop
*/
				else if (belongs(lhead -> getTakenPtr()) && 
					belongs(lhead -> getNTakenPtr()))	
						type = POST;
						
/* even if one of the children of the header node do not belong to the loop 
   then it is a pre-tested loop
*/
				else
					type = PRE;
			}
//if the header node doesn't have two children
			else
				type = POST;
		}
//the latching node doesn't have two children
		else if (lhead -> noChildren() == 2)
				type = PRE;
		else
			type = ENDLESS;
	}
}

void Interval::reduceLoop(void)
{
	interval.erase(lhead -> getTakenPtr());
	if ( type == PRE ) 
		reduceWhile( );

	else if ( type == POST ) 
		reduceDoWhile( );
	else if ( type == ENDLESS )
		reduceEndless( );
}

void Interval::reduceWhile(void)
{
	if (VERBOSE)
		verbose("\treducing while; loop header no: " + itoa(lhead -> no));

	++noWhiles;
	string comma;
	if ( !lhead -> empty() ) {
		comma = lhead -> first( );
		comma.erase( comma.find( ";" ) );
		lhead -> deleteAt( 0 );
		while ( !lhead -> empty( ) ) {
			comma += "," + lhead -> first( );
			comma.erase( comma.find( ";" ) );
			lhead -> deleteAt( 0 );
		}
	}
	
	lhead -> insert( "\n\nwhile(" );
	lhead -> insert( comma.size() ? comma + ",": "" );
	lhead -> insert( lhead -> leftOp( ) );
	lhead -> insert( convert(lhead -> cmpOperator( ) ) );
	lhead -> insert( lhead -> rightOp( ) );
	lhead -> insert( ") {" );

	lhead -> mergeInstructions( lhead -> getTakenPtr( ) );
		
	lhead -> insert( "}\n\n" );
	lhead -> mergeLink( lhead -> getTakenPtr( ),
				&BasicBlock::taken, &BasicBlock::takenNo );
}

void Interval::reduceDoWhile(void)
{

	if ( VERBOSE )
		verbose( "\treducing do-while; loop header no: " 
							+ itoa( lhead -> no ) );

	++noDoWhiles;
	lhead -> insert( 0, "\n\ndo {" );
	if ( lhead != lhead -> getTakenPtr( ) )
		lhead -> mergeInstructions( lhead -> getTakenPtr( ) );
	else {
		lhead -> predecessors.erase( lhead -> getTakenPtr( ) );
		lhead -> TakenPtr( 0 );
	}
	lhead -> insert( "}while(" );
	lhead -> insert( lhead -> leftOp( ) );
	lhead -> insert( convert( lhead -> cmpOperator( ) ) );
	lhead -> insert( lhead -> rightOp( ) );
	lhead -> insert( ") ;\n\n" );
	
	lhead -> mergeLink(lhead -> getTakenPtr(), 
				&BasicBlock::taken, &BasicBlock::takenNo);
}

void Interval::reduceEndless( void )
{
	if ( VERBOSE )
		verbose( "\treducing endless loop; loop header number: " 
							+ itoa( lhead -> no ) );

	++noEndless;
	if ( lhead != lhead -> getTakenPtr( ) ) {
		lhead -> insert( "\n\nwhile(1){" );
		lhead -> mergeInstructions( lhead -> getTakenPtr( ) );
	}
	else {
		lhead -> insert(0, "while(1){");
		lhead -> predecessors.erase( lhead -> getTakenPtr( ) );
		lhead -> TakenPtr( 0 );
	}
	lhead -> insert("}\n\n");
	lhead -> mergeLink(lhead -> getTakenPtr(), 
				&BasicBlock::taken, &BasicBlock::takenNo);
}

//find the conditional statements of "this" interval
bool Interval::findConditionals( void )
{
//temp contains the latching nodes and the header node
	BBVector temp( latchNodes.begin( ), latchNodes.end( ) );

//lhead could be null, if "this" doesn't have any loops
	if ( lhead )
		temp.push_back( lhead ); 	
	bool found = true;
	bool foundOne = false;
	BasicBlock *cond = 0;		//node containing the conditional
	
	while ( found == true ) {
		found = false;
		int num = -1;
		for ( Interval::iterator j = interval.begin( );
						j != interval.end( ); ++j ) {

			if ( ( *j ) -> noChildren( ) == 2 )
			if (((type == POST && Loop::size() > 2 && *j == lhead)
				|| !oneOf(temp, *j)
				|| latchNodes.size() >= 2 && (*j) != lhead)
				&&
//if both the children of "*j" belong to "this" interval
				( checkIf( *j ) || checkIfElse( *j ) ) ) {

				if ((*j) -> no > num) {
					num = (*j) -> no;
					cond = *j;
					found = true;
				}
			}
		}
		if (found)
			found = reduceConditional(cond);
	}
	/*repeat the above procedure
	* for every conditional from highest to least no */
	return foundOne;
}
                                                                                
void Interval::reduceIfElse( BasicBlock *t )
{
	if ( VERBOSE )
		verbose( "\treducing if-else; node no: " + itoa( t -> no ) );

	++noIfElses;
	t -> insert( "\n\nif ( " );
        t -> insert( t -> leftOp( ) );
        t -> insert( rev( convert( t -> cmpOperator( ) ) ) );
        t -> insert( t -> rightOp( ) );
        t -> insert( ") {" );
        t -> mergeInstructions( t -> getTakenPtr( ) );
                                                                                
        t -> insert( "}\n else {" );
	t -> mergeInstructions(t -> getNTakenPtr());
           t -> insert("}\n\n");
		//Block merge code follows:
	blockMerge(t, t -> getTakenPtr(), t -> getNTakenPtr());
}

void Interval::reduceIf(BasicBlock *t)
{
	if (VERBOSE)
		verbose( "\treducing if; node no: " + itoa(t -> no));

	++noIfs;
	t -> insert( "\n\nif ( " );
	t -> insert( t -> leftOp( ) );
	t -> insert( rev(convert( t -> cmpOperator( ) ) ) );
	t -> insert( t -> rightOp( ) );
	t -> insert( ") {" );
	if ( t -> cmpOpFloat == false )
		t -> mergeInstructions( t -> getTakenPtr( ) );
	else
		t -> mergeInstructions( t -> getNTakenPtr( ) );
	t -> insert( "}\n\n" );
	if ( t -> cmpOpFloat == false )
		blockMerge( t, t -> getTakenPtr( ) );
	else
		blockMerge( t, 0, t -> getTakenPtr( ) );
}

bool Interval::reduceConditional( BasicBlock *t )
{
	while ( t -> taken -> canT2BeApplied( ) )
		t -> taken -> applyT2( );

	while ( t -> ntaken -> canT2BeApplied( ) )
		t -> ntaken -> applyT2( );

	if ( t -> cmpOpFloat == false )
		swap( t -> taken, t -> ntaken );

//if both the children of "t" lead to the same node
        if ( checkIfElse( t ) ) 
                // merge t -> taken & t -> ntaken
		reduceIfElse( t );

	else if ( checkIf( t ) ) 
		reduceIf( t );
	else {
		if ( t -> cmpOpFloat == false )
			swap( t -> taken, t -> ntaken );
		return false;
	}
	return true;
}

bool Interval::checkIf( const BasicBlock *h )
{
	if ( !belongs( h -> getTakenPtr( ) ) 
			&& !belongs( h -> getNTakenPtr( ) ) )
		return false;

	if ( h -> getTakenPtr( ) -> getTakenPtr( ) 
					== h -> getNTakenPtr( ) )
		return true;
	else if ( h -> getNTakenPtr( ) -> getTakenPtr( )
					== h -> getTakenPtr( ) )
		return true;
	return false;
}

bool Interval::checkIfElse( const BasicBlock *h )
{
	if ( !belongs( h -> getTakenPtr( ) )
		|| !belongs( h -> getNTakenPtr( ) ) )
		return false;

	if ( h -> getTakenPtr( ) -> getTakenPtr( ) == 
				h -> getNTakenPtr( ) -> getTakenPtr( ) )
		return true;
	return false;
}

void Interval::blockMerge(BasicBlock *dest, BasicBlock *take, BasicBlock *ntake)
{
	dest -> mergeLink(take, &BasicBlock::taken, &BasicBlock::takenNo);
	dest -> mergeLink(ntake, &BasicBlock::ntaken, &BasicBlock::ntakenNo);
	
	if ( dest -> getTakenPtr( ) == dest -> getNTakenPtr( ) ) {
		dest -> NTakenPtr( 0 );
		dest -> NTakenNo( 0 );
		if ( dest -> canT2BeApplied( ) )
			dest -> applyT2( );
	}

	erase( take );
	erase( ntake );
}
