//
//  flex_definitions.h
//  umscript
//
//  Created by Andreas Fink on 21.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMTerm.h"
#import "UMScriptCompilerEnvironment.h"
#import "UMFunctionMacros.h"

#import "bisonbridge.h"

#define YY_TYPEDEF_YY_SCANNER_T
typedef  void *yyscan_t;


#import "_generated_umscript.y.h"

extern int yycompile(UMScriptCompilerEnvironment *env, int fdes_in, int fdes_out);
