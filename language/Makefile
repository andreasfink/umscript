##
# File: Makefile
# Project "umscript"
# (c) 2014 SMSRelay AG
# Create: Andreas Fink (andreas@fink.org)
#
#

all:	y.tab.c

lex.yy.c:	uscript.l
	lex uscript.l
	
y.tab.c:	uscript.y
	yacc -d uscript.y
		
y.tab.h:		uscript.y
	yacc -d uscript.y

