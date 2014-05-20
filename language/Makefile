##
# File: Makefile
# Project "umscript"
# (c) 2014 SMSRelay AG
# Create: Andreas Fink (andreas@fink.org)
#
#

all:	y.tab.m lex.yy.m

uscript.l.m:	uscript.l
	flex uscript.l
	mv lex.yy.c uscript.l.m
	
uscript.y.m:	uscript.y
	yacc uscript.y --output-file uscript.y.m


