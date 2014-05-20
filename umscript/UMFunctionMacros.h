//
//  UMFunctionMacros.h
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction.h"
#import "UMTerm.h"
#import "UMFunction_add.h"
#import "UMFunction_sub.h"
#import "UMFunction_mul.h"
#import "UMFunction_div.h"
#import "UMFunction_dot.h"
#import "UMFunction_modulo.h"
#import "UMFunction_if.h"
#import "UMFunction_not.h"
#import "UMFunction_and.h"
#import "UMFunction_or.h"
#import "UMFunction_xor.h"
#import "UMFunction_bit_not.h"
#import "UMFunction_bit_and.h"
#import "UMFunction_bit_or.h"
#import "UMFunction_bit_xor.h"
#import "UMFunction_bit_shiftleft.h"
#import "UMFunction_bit_shiftright.h"
#import "UMFunction_equal.h"
#import "UMFunction_notequal.h"
#import "UMFunction_greaterthan.h"
#import "UMFunction_greaterorequal.h"
#import "UMFunction_lessthan.h"
#import "UMFunction_lessorequal.h"
#import "UMFunction_startswith.h"
#import "UMFunction_endswith.h"
#import "UMFunction_setvar.h"
#import "UMFunction_setfield.h"
#import "UMFunction_getvar.h"
#import "UMFunction_getfield.h"
#import "UMFunction_block.h"
#import "UMFunction_return.h"
#import "UMFunction_assign.h"
#import "UMFunction_while.h"
#import "UMFunction_dowhile.h"
#import "UMFunction_for.h"
#import "UMFunction_preincrease.h"
#import "UMFunction_predecrease.h"
#import "UMFunction_postincrease.h"
#import "UMFunction_postdecrease.h"
#import "UMFunction_switch.h"

#define TermLogicNOT(a)           [[UMTerm alloc]initWithFunction:[[UMFunction_logic_not alloc]init], @[a]]
#define TermLogicAND(a,b)         [[UMTerm alloc]initWithFunction:[[UMFunction_logic_and alloc]init],  @[a,b]]
#define TermLogicOR(a,b)          [[UMTerm alloc]initWithFunction:[[UMFunction_logic_or alloc]init],  @[a,b]]
#define TermLogicXOR(a,b)         [[UMTerm alloc]initWithFunction:[[UMFunction_logic_xor alloc]init],  @[a,b]]

#define TermBitNOT(a)             [[UMTerm alloc]initWithFunction:[[UMFunction_bit_not alloc]init],  @[a]]
#define TermBitAND(a,b)           [[UMTerm alloc]initWithFunction:[[UMFunction_bit_and alloc]init],  @[a,b]]
#define TermBitOR(a,b)            [[UMTerm alloc]initWithFunction:[[UMFunction_bit_or alloc]init],  @[a,b]]
#define TermBitXOR(a,b)           [[UMTerm alloc]initWithFunction:[[UMFunction_bit_xor alloc]init],  @[a,b]]

#define TermBitSHIFTLEFT(a,b)     [[UMTerm alloc]initWithFunction:[[UMFunction_bitshiftright alloc]init],  @[a,b]]
#define TermBitSHIFTRIGHT(a,b)    [[UMTerm alloc]initWithFunction:[[UMFunction_bit_sifhtright alloc]init],  @[a,b]]

#define TermEQUAL(a,b)              [[UMTerm alloc]initWithFunction:[[UMFunction_equal alloc]init],  @[a,b]]
#define TermNOTEQUAL(a,b)           [[UMTerm alloc]initWithFunction:[[UMFunction_notequal alloc]init],  @[a,b]]
#define TermGREATERTHAN(a,b)        [[UMTerm alloc]initWithFunction:[[UMFunction_greaterthan alloc]init],  @[a,b]]
#define TermLESSTHAN(a,b)           [[UMTerm alloc]initWithFunction:[[UMFunction_lessthan, alloc]init]  @[a,b]]
#define TermSTARTSWITH(a,b)         [[UMTerm alloc]initWithFunction:[[UMFunction_startswith alloc]init],  @[a,b]]
#define TermENDSWITH(a,b)           [[UMTerm alloc]initWithFunction:[[UMFunction_endswith alloc]init],  @[a,b]]
#define TermSETVAR(name,value)      [[UMTerm alloc]initWithFunction:[[UMFunction_setvar alloc]init],  @[name,value]]
#define TermGETVAR(name)            [[UMTerm alloc]initWithFunction:[[UMFunction_getvar alloc]init],  @[name]]
#define TermSETFIELD(name,value)    [[UMTerm alloc]initWithFunction:[[UMFunction_setfield alloc]init],  @[name,value]]
#define TermGETFIELD(name)          [[UMTerm alloc]initWithFunction:[[UMFunction_getfield alloc]init],  @[name])

#define TermADD(a,b)                [[UMTerm alloc]initWithFunction:[[UMFunction_add alloc]init],  @[a,b]]
#define TermSUB(a,b)                [[UMTerm alloc]initWithFunction:[[UMFunction_sub alloc]init],  @[a,b]]
#define TermMUL(a,b)                [[UMTerm alloc]initWithFunction:[[UMFunction_mul alloc]init],  @[a,b]]
#define TermDIV(a,b)                [[UMTerm alloc]initWithFunction:[[UMFunction_div alloc]init],  @[a,b]]
#define TermMODULO(a,b)             [[UMTerm alloc]initWithFunction:[[UMFunction_modulo alloc]init],  @[a,b]]
