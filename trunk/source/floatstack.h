#ifndef __RELIPMOC__FLOATSTACK__H
#define __RELIPMOC__FLOATSTACK__H

#include<string>
#include<vector>
#include<iostream>
using namespace std;

typedef string FloatType;
class FloatStack {

	vector<FloatType> floatReg;
	long top;
public:
	typedef vector< FloatType >::iterator iterator;
	
	static FloatType temp;
	FloatStack(void);
	
	iterator begin( void ) { return floatReg.begin( ); }
	iterator end( void ) { return floatReg.end( ); }

	void push(const string ); 
	void pushFrom(long pos);
	void storeAt(long , const string );

	string &at(long );
	const string &seetop(void);
	const string &pop(void);

	void swap( long pos1, long pos2 = 0 ); 

	void print(void);
};

#endif
