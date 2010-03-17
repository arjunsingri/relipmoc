#ifndef __INTERVAL__RELIPMOC__H
#define __INTERVAL__RELIPMOC__H
 
using namespace std;
#include<iostream>
#include<vector>
#include<string>
#include<list>
#include<stack>

#include"basicblock.h"
#include"arjun.h"

class BlockTab;
class Interval;
extern void verbose(const string );
extern bool VERBOSE;
extern int noIfElses, noIfs, noWhiles, noDoWhiles, noEndless;

#include"types.h"

class Loop {

	enum LoopType {NONE, PRE, POST, ENDLESS };
	BasicBlock *lhead;
	BBSet loopNodes;
	BBVector latchNodes;
	LoopType type; //type of loop 
public:
	typedef BBSet::iterator iterator;
	Loop(void);

	bool insert(BasicBlock *);	
	size_t size(void) { return loopNodes.size(); }
	bool belongs(BasicBlock *);
	void findLoopType(void);

	iterator begin(void) { return loopNodes.begin(); }
	iterator end(void) { return loopNodes.end(); }
	
	friend class Interval;	
	friend class BlockTab;	
};
	
class Interval : public Loop {

	BBSet interval;     //set of basicblock pointers
	BasicBlock *ihead;  //interval head

	typedef BBSet::iterator iterator;
public:	
	Interval(void);
	
	BasicBlock* Head(void) { return ihead; } 
	void Head(BasicBlock *const p) { ihead = p; }
	size_t size( void ) { return interval.size( ); }

	void insert(BasicBlock *);
	void erase(BasicBlock *);
	
	bool findLoops(void);
	void reduceLoop(void);
	void reduceWhile(void);
	void reduceDoWhile(void);
	void reduceEndless( void );

	bool findConditionals(void);
	bool checkIf( const BasicBlock * );
	bool checkIfElse( const BasicBlock * );
	void reduceIf( BasicBlock * );
	void reduceIfElse( BasicBlock * );
	bool reduceConditional( BasicBlock * );
	
	void blockMerge(BasicBlock *, BasicBlock *, BasicBlock * = 0);
	bool belongs(BasicBlock *);
	void print( ostream & = cout );

	iterator begin(void); 
	iterator end(void);
	friend class BlockTab;	
};

typedef vector<Interval> Intervals;

#endif

