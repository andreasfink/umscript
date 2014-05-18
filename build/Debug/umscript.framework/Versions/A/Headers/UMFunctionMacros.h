//
//  UMFunctionMacros.h
//  umruleengine
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction.h"
#import "UMTerm.h"
#import "UMFunction_math_add.h"
#import "UMFunction_math_substract.h"
#import "UMFunction_math_multiply.h"
#import "UMFunction_math_division.h"
#import "UMFunction_math_dot.h"
#import "UMFunction_math_percent.h"
#import "UMFunction_if.h"
#import "UMFunction_logic_not.h"
#import "UMFunction_logic_and.h"
#import "UMFunction_logic_or.h"
#import "UMFunction_logic_xor.h"
#import "UMFunction_bit_not.h"
#import "UMFunction_bit_and.h"
#import "UMFunction_bit_or.h"
#import "UMFunction_bit_xor.h"
#import "UMFunction_bit_shiftleft.h"
#import "UMFunction_bit_shiftright.h"
#import "UMFunction_equal.h"
#import "UMFunction_notequal.h"
#import "UMFunction_greaterthan.h"
#import "UMFunction_lessthan.h"
#import "UMFunction_startswith.h"
#import "UMFunction_endswith.h"
#import "UMFunction_setvar.h"
#import "UMFunction_setfield.h"
#import "UMFunction_getvar.h"
#import "UMFunction_getfield.h"
#import "UMFunction_block.h"
#import "UMFunction_return.h"


#define TermLogicNOT(a)           ([[UMTerm alloc]initFunction:[[UMFunction_logic_not alloc]init] parm:@[a]])
#define TermLogicAND(a,b)         ([[UMTerm alloc]initFunction:[[UMFunction_logic_and alloc]init] parm:@[a,b]])
#define TermLogicOR(a,b)          ([[UMTerm alloc]initFunction:[[UMFunction_logic_or alloc]init] parm:@[a,b]])
#define TermLogicXOR(a,b)         ([[UMTerm alloc]initFunction:[[UMFunction_logic_xor alloc]init] parm:@[a,b]])

#define TermBitNOT(a)             ([[UMTerm alloc]initFunction:[[UMFunction_bit_not alloc]init] parm:@[a]])
#define TermBitAND(a,b)           ([[UMTerm alloc]initFunction:[[UMFunction_bit_and alloc]init] parm:@[a,b]])
#define TermBitOR(a,b)            ([[UMTerm alloc]initFunction:[[UMFunction_bit_or alloc]init] parm:@[a,b]])
#define TermBitXOR(a,b)           ([[UMTerm alloc]initFunction:[[UMFunction_bit_xor alloc]init] parm:@[a,b]])

#define TermBitSHIFTLEFT(a,b)     ([[UMTerm alloc]initFunction:[[UMFunction_bitshiftright alloc]init] parm:@[a,b]])
#define TermBitSHIFTRIGHT(a,b)    ([[UMTerm alloc]initFunction:[[UMFunction_bit_sifhtright alloc]init] parm:@[a,b]])

#define TermEQUAL(a,b)              ([[UMTerm alloc]initFunction:[[UMFunction_equal alloc]init] parm:@[a,b]])
#define TermNOTEQUAL(a,b)           ([[UMTerm alloc]initFunction:[[UMFunction_notequal alloc]init] parm:@[a,b]])
#define TermGREATERTHAN(a,b)        ([[UMTerm alloc]initFunction:[[UMFunction_greaterthan alloc]init] parm:@[a,b]])
#define TermLESSTHAN(a,b)           ([[UMTerm alloc]initFunction:[[UMFunction_lessthan alloc]init] parm:@[a,b]])
#define TermSTARTSWITH(a,b)         ([[UMTerm alloc]initFunction:[[UMFunction_startswith alloc]init] parm:@[a,b]])
#define TermENDSWITH(a,b)           ([[UMTerm alloc]initFunction:[[UMFunction_endswith alloc]init] parm:@[a,b]])
#define TermSTARTSWITH(a,b)         ([[UMTerm alloc]initFunction:[[UMFunction_startswith alloc]init] parm:@[a,b]])
#define TermSETVAR(name,value)      ([[UMTerm alloc]initFunction:[[UMFunction_setvar alloc]init] parm:@[name,value]])
#define TermGETVAR(name)            ([[UMTerm alloc]initFunction:[[UMFunction_getvar alloc]init] parm:@[name]])
#define TermSETFIELD(name,value)    ([[UMTerm alloc]initFunction:[[UMFunction_setfield alloc]init] parm:@[name,value]])
#define TermGETFIELD(name)          ([[UMTerm alloc]initFunction:[[UMFunction_getfield alloc]init] parm:@[name]])

