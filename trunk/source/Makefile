CPP = c++
PARSEGEN=yacc
LEXER=flex
LINKS= -lfl
OBJOPTIONS= -c  -O0
OPTIONS= -O0
OBJS= basicblock.o blocktab.o interval.o stringtab.o labeltab.o relipmoC.o syminfo.o symtab.o actrecord.o functab.o floatstack.o yacc.o lex.o arjun.o instructions.o

relipmoC: $(OBJS) 
	$(CPP) $(OBJS) -o relipmoC $(LINKS) $(OPTIONS)

relipmoC.o: relipmoC.h blocktab.h stringtab.h basicblock.h labeltab.h symtab.h              actrecord.h relipmoC.cpp types.h functab.h arjun.h
	$(CPP) relipmoC.cpp $(OBJOPTIONS)
	
blocktab.o: blocktab.h blocktab.cpp basicblock.h labeltab.h interval.h types.h			arjun.h
	$(CPP) blocktab.cpp $(OBJOPTIONS)

instructions.o: instructions.h instructions.cpp
	$(CPP) instructions.cpp $(OBJOPTIONS)

basicblock.o: basicblock.h types.h basicblock.cpp
	$(CPP) basicblock.cpp $(OBJOPTIONS) 	

interval.o: interval.cpp interval.h basicblock.h types.h arjun.h
	$(CPP) interval.cpp $(OBJOPTIONS)

stringtab.o: stringtab.h stringtab.cpp
	$(CPP) stringtab.cpp $(OBJOPTIONS)

labeltab.o: labeltab.h labeltab.cpp
	$(CPP) labeltab.cpp $(OBJOPTIONS)

syminfo.o: syminfo.h syminfo.cpp
	$(CPP) syminfo.cpp $(OBJOPTIONS)

actrecord.o: syminfo.h actrecord.h actrecord.cpp
	$(CPP) actrecord.cpp $(OBJOPTIONS)

functab.o: syminfo.h actrecord.h functab.cpp functab.h
	$(CPP) functab.cpp $(OBJOPTIONS)

symtab.o: syminfo.h symtab.h symtab.cpp
	$(CPP) symtab.cpp $(OBJOPTIONS)

floatstack.o: floatstack.h floatstack.cpp
	$(CPP) floatstack.cpp $(OBJOPTIONS)

yacc.o:  yacc.cpp
	$(CPP) yacc.cpp $(OBJOPTIONS)
                                                                                
yacc.cpp: start.y relipmoC.h arjun.h
	$(PARSEGEN) -d -o$@ start.y

lex.o: lex.cpp 
	$(CPP) lex.cpp $(OBJOPTIONS)
	
lex.cpp: start.l  arjun.h yacc.cpp.h relipmoC.h
	$(LEXER) -s -o$@ start.l 

arjun.o: arjun.cpp arjun.h
	$(CPP) arjun.cpp $(OBJOPTIONS)

clean:
	rm *.o -f 2>/dev/null
