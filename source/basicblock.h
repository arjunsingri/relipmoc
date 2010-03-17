#ifndef __BASICBLOCK__RELIPMOC__H
#define __BASICBLOCK__RELIPMOC__H

using namespace std;
#include<string>
#include<vector>
#include<set>
#include<fstream>
#include<bitset>
#include"arjun.h"

class BlockTab;
class Interval;
class BasicBlock;

#include"types.h"
#include"instructions.h"

enum CONDITIONAL { NOCOND, IF, IFELSE };

class BasicBlock {
private:
//	typedef vector< string > InstContainer;

	InstContainer instructions;
	
        BasicBlock *taken;     //goto this block if the condition is true
	int takenNo;		//its block number	

        BasicBlock *ntaken;    //goto this block otherwise
	int ntakenNo;		//its block number
 
	string _leftOp, _rightOp; 
	/* operands of comparision instruction of this block */
	string cmpOp;   //comparison operator for the above operands for ints
	
   	BBSet predecessors; 

	mutable CONDITIONAL condType;
public:
//	typedef InstContainer::iterator iterator;
//	typedef InstContainer::const_iterator const_iterator;

	int no;			//reverse-postorder number for this block
	bool visited;		

	bool cmpOpFloat; 	//comparison was for floating point data
	//head node of the interval to which this node belongs to
	BasicBlock *head;

	BasicBlock( void );
	
	static BasicBlock* getNewBlock( void );
	
	void print( void ) const;
	
	void insert( const string );
	void insert( int , const string );
	int noChildren( void ) const;
#if 0	
	iterator begin( void ) { return instructions.begin( ); }
	iterator end( void ) { return instructions.end( ); }
	
	const_iterator begin( void ) const { return instructions.begin( ); }
	const_iterator end( void ) const { return instructions.end( ); }
#endif
	string first( void );
		
	void deleteAt( int );
	size_t size( void ) { return instructions.size( ); }
	bool empty( void ) { return instructions.empty( ); }
	
	const string leftOp( void ) const { return _leftOp; }
	void leftOp( const string &s ) { _leftOp = s; }

	const string rightOp( void ) const { return _rightOp; }
	void rightOp( const string &s ) { _rightOp = s; }
	
	const string cmpOperator( void ) const { return cmpOp; }
	void cmpOperator( const string &s ) { if ( !cmpOpFloat ) cmpOp = s;}

	void insertIfCond( void );
	
	const int getTakenNo( void ) const { return takenNo; }
	void TakenNo( int n ) { takenNo = n; }
	BasicBlock *getTakenPtr( void ) const { return taken; }
	void TakenPtr( BasicBlock *const p ) { taken = p; }

	const int getNTakenNo( void ) const { return ntakenNo; }
	void NTakenNo( int n ) { ntakenNo = n; }
	BasicBlock *getNTakenPtr( void ) const { return ntaken; }
	void NTakenPtr( BasicBlock *const p ) { ntaken = p; }

//	InstContainer & Instructions( void ) { return instructions; }
	bool canT2BeApplied( void ) const;
	void applyT2( void );
	void mergeInstructions( BasicBlock * );
	void mergeLink( BasicBlock *,
				BasicBlock *BasicBlock::*, int BasicBlock::* );

	friend class BlockTab;
	friend class Interval;
}; 

#endif

