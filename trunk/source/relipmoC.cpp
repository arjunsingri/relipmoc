/* relipmoC 0.01: A gcc3.2.2 i386 assembly to C code translator
 *
 * Copyright (C) 29 June 2004 Arjun S J, Darshan D Desai. Contact us at arjunsingri@yahoo.co.in or ddddd@indiatimes.com
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include"relipmoC.h"

extern FILE *yyin, *yyout;
StringTab curStringTab;
SymTab curSymTab;
FuncTab curFuncTab;

int noIfElses, noIfs, noWhiles, noDoWhiles, noEndless;

bool CFG;
bool INTERVALS;
bool VERBOSE;
bool INDENT = true;
string PREFIX;
int PRECISION = 8;
bool VERSION;
bool STDOUT;
bool CPP;

int main( int argc, char *argv[ ] )
{
	if ( argc < 2 ) {
		cout << "Usage: relipmoC [OPTIONS] assembly_file" << endl;
		cout << "Try relipmoC --help for more information.\n";
		exit( EXIT_FAILURE );
	}
	string outputFile;	//name of output-file
	string asmFile;	//name of input i386 assembly file

/*  collect all command line options  */
	for ( int i = 1; i < argc; ++i ) {

		if ( *argv[ i ] == '-' ) {
			++argv[ i ];
			if ( *argv[ i ] == '\0' )
				++i;
			else if ( *argv[ i ] == '-' ) {
				++argv[ i ];
				if ( *argv[ i ] == '\0' )
					++i;
				string cmdOption = argv[ i ];

				if ( string( "cfg" ) == cmdOption )
			/*  print control flow graph and exit  */
					CFG = true;

				else if ( string( "intr" ) == cmdOption )
			/*  print the intervals and exit  */
					INTERVALS = true;

				else if ( string( "noindent" ) == cmdOption )
			/*  indent the generated C file  */
					INDENT = false;

				else if ( string( "c++" ) == cmdOption )
			/* asm file was obtained by compiling c++ code */
					CPP = true;

				else if ( string( "help" ) == cmdOption )
/*  print brief information about the command line options and exit  */
					printHelp( );

/*  add the prefix to the names of all the local variables and paramters of a function */
				else if ( string( "prefix" ) == 
					string( cmdOption.begin( ),
						cmdOption.begin( ) + 6 )
					)

				PREFIX.assign( cmdOption.begin( ) + 7,
							cmdOption.end( ) );

/*  print the version and exit  */
				else if ( string( "version" ) == cmdOption )
					VERSION = true;

/*  print information about the current status of the process */
				else if ( string( "verbose" ) == cmdOption )
					VERBOSE = true;
					
				else if ( string( "precision") == 
						string( cmdOption.begin( ),
						cmdOption.begin( ) + 9 )
					) {
					PRECISION = atoi( 
						string( cmdOption.begin( ) + 10,
							cmdOption.end( ) ) );
					if ( PRECISION > 20 ) {
						cerr << "\nMaximum precision" 
							"allowed is 20\n"
						   "Treating as precision=20\n";
						PRECISION = 20;
					}
				}

				else {
					cerr << "Invalid option: " 
							<< cmdOption << endl;
					exit( EXIT_FAILURE );
				}
				continue;
			}

			else if ( strlen( argv[ i ] ) != 1 ) {
				cerr << "Invalid option: " << argv[ i ] << endl;
				exit( EXIT_FAILURE );
			}
			char c = *argv[ i ]++;

			switch ( c ) {

				case 'o':
/*  print the output to the file with name "outputFile"  */
					if ( *argv[ i ] == '\0' )
						++i;
					char c;
					while ( ( c = *argv[ i ]++ ) != '\0' )
						outputFile.push_back( c );
					break;

				case 'n':
					INDENT = false;
					break;

				case 'V':
					VERBOSE = true;
					break;
				case 'h':
					printHelp( );
					break;
				case 'v':
					VERSION = true;
					break;
				case 's':
/*  print the output to stdout  */
					STDOUT = true;
					break;
				default:
					cerr << "Invalid option: " << c << endl;
					exit( EXIT_FAILURE );
			}
		}
		else
			asmFile = argv[ i ];
	}
	if ( VERSION ) {
		cout << "relipmoC version 0.01" << endl;
		exit( EXIT_SUCCESS );
	}

	if ( asmFile.empty( ) ) {
		cout << "relipmoC: no input files\n";
		exit( EXIT_FAILURE );
	}

/* check for the file format */
	string format;
	format.assign( asmFile.begin() + asmFile.find_last_of( "." ), 
							asmFile.end( ) );
	if ( format != ".s" ) {
		cout << "File format not recoqnized\n" 
			<< "\"" << format << "\"" << " of " << asmFile << endl;
		cout << "Format \".s\" required" << endl;
		exit( EXIT_FAILURE );
	}
	
	if ( ( yyin = fopen( asmFile.c_str( ), "r") ) == NULL ) {
		perror( asmFile.c_str( ) );
		exit( EXIT_FAILURE );
    	}
	yyout = stdout;

	int fd[ 2 ];
	pid_t pid;
	assert( pipe( fd ) >= 0 );
	assert( ( pid = fork( ) ) >= 0 );
	int status;
try {
	if ( pid > 0 ) {		//parent
		close( fd[ 0 ] );	//close "read" end of parent
		if ( fd[ 1 ] != STDOUT_FILENO ) {
			assert( dup2( fd[ 1 ], STDOUT_FILENO ) != -1 );
			close( fd[ 1 ] );
		}
		asm2C( );
	}
	else {				//child
		close( fd[ 1 ] );	//close "write" end of child
		if ( fd[ 0 ] != STDIN_FILENO ) {
			assert( dup2( fd[ 0 ], STDIN_FILENO ) != -1 );
			close( fd[ 0 ] );
		}

		fflush( stdout );

		if ( !STDOUT  && !outputFile.size( ) && !CFG && !INTERVALS )
			outputFile.assign( asmFile + ".c" );

		if ( INDENT && !CFG && !INTERVALS ) {
			if ( ( !STDOUT || outputFile.size( ) )
						&& !CFG && !INTERVALS ) {
				assert( execlp( "indent", "indent",
						"-cdw", "-npsl", "-nprs", "-cs",
						 "-nce", "-bad", "-bap", "-lp",
						 "-sob", "-i8", "-prs",
						 "-kr",
						 "-o", outputFile.c_str( ),
						 ( char * ) 0 
						) >= 0
					);
			}		
			else
				assert( execlp( "indent", "indent", 
						"-cdw", "-npsl", "-nprs", "-cs",
						"-nce", "-bad", "-bap", "-lp",
						"-sob", "-i8", "-prs",
						"-kr",
						( char * )( 0 ) 
					       ) >= 0 );

		}
		else {
			fflush( stdout );
			if ( ( !STDOUT || outputFile.size( ) )
						&& !CFG && !INTERVALS ) {
				assert( execlp( "myecho", 
					"myecho", outputFile.c_str( ),
					( char * )( 0 ) ) >= 0 );
			}
			else
				assert( execlp( "myecho", 
					"myecho", ( char * )( 0 ) ) >= 0 );
		}
	}
}
catch ( int s )
{
	status = s;
}
	fflush( stdout );
	close( STDOUT_FILENO );
	waitpid( pid, NULL, 0 );
	return status;
}

//convert the assembly language program in "asmFile" into a C language program
void asm2C( void )
{
//get one function at a time and translate it to C
	int i;
	vector< BlockTab * > allFunctions;
 	do {
		BlockTab *curBlockTab = new BlockTab;
		LabelTab curLabelTab;
		if ( ( i = yyparse( curLabelTab, *curBlockTab ) ) == true ) {
			if ( VERBOSE )
				verbose( "\tLinking blocks" );
			curBlockTab -> linkBlocks( curLabelTab );
			if ( VERBOSE )
				verbose( "\tFinished linking blocks" );
			if ( VERBOSE )
				verbose( "\tStarting Control Flow Analysis" );
			curBlockTab -> reduce( );
			if ( VERBOSE )
				verbose( "\tFinished Control flow Analysis\n" );
			allFunctions.push_back( curBlockTab );
		}
	} while ( i );

	if ( VERBOSE ) {
		verbose( "\nFinished Decompiling\n" );
		verbose( "No of \"if..else\" stms found   : " + itoa( noIfElses ) );
		verbose( "No of \"if\" stmts found        : " + itoa( noIfs ) );
		verbose( "No of \"while\" loops found     : " + itoa( noWhiles ) );
		verbose( "No of \"do-while\" loops found  : " + itoa( noDoWhiles ));
		verbose( "No of \"endless\" loops found   : " + itoa( noEndless ) );
	}
	cout << "#include<ourHeader.h>\n\n";

/* generate the declarations for global variables */
	generateDecls( curSymTab );

/* generate the prototypes for the functions defined in the program */
	generateProts( curFuncTab );

/* generate the C file */
	generateFile( allFunctions );
}

void generateFile( vector< BlockTab *> &allFunctions )
{
	for ( vector< BlockTab *>::iterator i = allFunctions.begin( );
					i != allFunctions.end( ); ++i ) {
	
		BlockTab *curBlockTab = *i;
		curBlockTab -> applyT2( );
		generateFunction( *curBlockTab );
		delete curBlockTab;
	}
}

/*  generate function represented by curBlockTab  */
void generateFunction( const BlockTab &curBlockTab )
{
	/* generate function parameter list */
	const ActRecord &rec = curFuncTab[ curBlockTab.funcName ];
	cout << rec.generateFuncDefn( );
	cout << "{";
	cout << rec.generateLocalDecls( ) << "\n\n";
	generateBody( curBlockTab[ 1 ] );
/*  generate the return statement  */
	cout << "\n\nreturn " << rec.getRetValue( ) << ';' << endl;
	cout << "}\n\n";
}

void generateBody( const BasicBlock * const p )
{
	if ( p != 0 ) {						
		p -> print( );
	        cout << endl;
		generateBody( p -> getNTakenPtr( ) );
		generateBody( p -> getTakenPtr( ) );
	}
}

/*  generate declarations for global variables used in the program  */
void generateDecls( const SymTab &curSymTab )
{
	for ( SymTab::const_iterator curSym = curSymTab.begin( ); 
					curSym != curSymTab.end( ); ++curSym ) {
		if ( curSym -> second.isReg( ) == true 
			|| curSym -> second.Type( ) == FUNC 
			|| curSym -> second.isLocal( ) )
			continue;
		curSym -> second.declare( curSym -> first );
	}
	cout << "\n\n";
}

/*  generate prototypes that were defined in the input program  */
void generateProts( const FuncTab &curFuncTab )
{
	for ( FuncTab::const_iterator i = curFuncTab.begin( );
				i != curFuncTab.end( ); ++i ) {
		const string &v = i -> second.generateFuncDefn( );
		cout << ( v.size( ) ? v + ";" : "" ) << endl;
	}
	cout << "\n\n";
}

void verbose( const string message )
{
	cerr << message << endl;
}

void printHelp( void )
{
	cout << 
"Usage: relipmoC [ OPTIONS ] asmfile\n"
"Convert the assembly language in asmfile to equivalent C code\n"
"\n"
"Options:\n"
"	-n --noindent           Don't indent the generated C code\n"
"\n"
"	-o <file>               Place the output into <file>\n"
"\n"
"	-h --help               Display this information and exit\n"
"\n"
"	--prefix=PREFIX         use PREFIX as a prefix with local variables"
				" and\n"
"				function parameters\n"
"\n"
"	--precision=NUMBER      Set the precision of the generated floating\n"
"				point numbers to NUMBER\n"
"\n"
"	-s                      instructs relipmoC to write the generated C "
				"file\n"
"				to stdout\n"
"\n"
"	-V --verbose            Display information about the conversion "
				"process\n"
"\n"
"	-v --version            Display the version number\n";

	exit( EXIT_SUCCESS );
}
