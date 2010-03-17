#ifndef __BLOCKTAB__RELIPMOC__H
#define __BLOCKTAB__RELIPMOC__H
 
using namespace std;
extern bool CFG;
extern bool INTERVALS;
#include<iostream>
#include<vector>
#include<string>
#include<list>
#include"basicblock.h"
#include"labeltab.h"
#include"interval.h"

#include"types.h"

class BlockTab {
private:
	BBVector blockList;
	void number( BasicBlock *, int & );
	void number( void );
	void applyT2( BasicBlock *, vector< bool > & );
public:
	Intervals all;
	int curBlockNum;
	string funcName;

	typedef BBVector::iterator iterator;
	
	BlockTab(void);
	~BlockTab(void);

	BasicBlock *blockHead(void) { return blockList[1]; }
	void freeBlocks(BasicBlock *);

	void print( ostream & = cout );
	void print(BasicBlock *, vector<bool> &, ostream& = cout );

	void insert(BasicBlock *, int = 0, int = 0);
	BasicBlock *&operator[] (int ); 
	const BasicBlock *const operator[] (int ) const ; 
	
	BasicBlock *linkBlocks(LabelTab &);
	void findIntervals(void);
	Intervals::iterator whichInterval(BasicBlock *);
	void reduce(void);
	void applyT2(void);
	
	iterator begin(void) { return blockList.begin(); }
	iterator end(void) { return blockList.end(); }
};

#endif

