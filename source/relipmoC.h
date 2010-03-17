#ifndef __RELIPMOC__RELIPMOC__H
#define __RELIPMOC__RELIPMOC__H

#include<fstream>
#include<queue>
#include<unistd.h>
#include<assert.h>
#include<sys/types.h>
#include<sys/wait.h>
#include"blocktab.h"
#include"stringtab.h"
#include"symtab.h"
#include"actrecord.h"
#include"functab.h"

using namespace std;
int getCFG( LabelTab &, BlockTab & );
void generateBody( const BasicBlock * const );
extern int yyparse(LabelTab &, BlockTab & );
void asm2C( void );
void generateFile( vector< BlockTab *> & );
void generateProts( const FuncTab & );
void generateDecls( const SymTab & );
void generateFunction( const BlockTab & );

void verbose( const string );
void printHelp( void );
#endif

