#include"labeltab.h"

int LabelTab::lab;

//insert a dummy label at postion 0
LabelTab::LabelTab( void )
{
    labelList.insert( LabelType( 0, 0 ) );
}

void LabelTab::insert( int lab, int blockNum )
{
	labelList.insert( LabelType( lab, blockNum ) );
}

//return the block number to which the label "lab" corresponds to
int LabelTab::getBlkNo( int lab )
{
	return labelList[ lab ];
}

//make label "lab" correspond to block "blockNum"
void LabelTab::update( int lab, int blockNum )
{
	labelList[ lab ] = blockNum;
}

//return a temporary label
int LabelTab::tempLabel( void )
{
	return --lab;
}

void LabelTab::print( void )
{
	for ( const_iterator i = begin( ); i != end( ); ++i ) 
		if ( i -> first ) {
			cout << "Label: " << i -> first << "   ";
			cout << "BlockNum: " << i -> second << endl;
		}
}

