#ifndef __SYMTAB__RELIPMOC__H
#define __SYMTAB__RELIPMOC__H

using namespace std;
#include<string>
#include<map>
#include<iostream>
#include"syminfo.h"

class LabelTab;
class BlockTab;

class SymTab {
	
public:
	typedef string Index;
	typedef map< Index, SymInfo > SymTabContainer;
private:
	map<Index, SymInfo> symbolList;
public:

	typedef pair<Index, SymInfo> SymTabEntry;
	typedef map<Index, SymInfo>::iterator iterator;
	typedef map<Index, SymInfo>::const_iterator const_iterator;
	SymTab(void);
	void insert(Index, SymInfo );
	SymTabContainer::size_type erase( Index );
	void print(void);
	const SymInfo getDat(Index &);
	SymInfo &operator[] (Index a);
	iterator begin(void) { return symbolList.begin(); }
	iterator end(void) { return symbolList.end(); }
	
	const_iterator begin(void) const { return symbolList.begin(); }
	const_iterator end(void) const { return symbolList.end(); }
};

#endif 
