//
//  umscriptTests.m
//  umscriptTests
//
//  Created by Andreas Fink on 19.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "UMFunction.h"
#import "UMTerm.h"
#import "UMEnvironment.h"
#import "UMScriptDocument.h"

@interface umscriptTests : XCTestCase
{
    UMEnvironment *env;
}
@end

@implementation umscriptTests

- (void)setUp
{
    [super setUp];
    env = [[UMEnvironment alloc]init];
    [env setVariable:[UMDiscreteValue discreteString:@"A"] forKey:@"var1"];
    [env setVariable:[UMDiscreteValue discreteString:@"A"] forKey:@"var2"];
    [env setVariable:[UMDiscreteValue discreteString:@"B"] forKey:@"var3"];
    [env setVariable:[UMDiscreteValue discreteString:@"BBB"] forKey:@"var4"];
    [env setVariable:[UMDiscreteValue discreteBool:NO] forKey:@"var5"];
    [env setVariable:[UMDiscreteValue discreteInt:123] forKey:@"var6"];
    NSData *d = [NSData dataWithBytes:"hello world" length:11];
    [env setVariable:[UMDiscreteValue discreteData:d] forKey:@"var7"];
    
    [env setField:[UMDiscreteValue discreteString:@"A"] forKey:@"field1"];
    [env setField:[UMDiscreteValue discreteString:@"A"] forKey:@"field2"];
    [env setField:[UMDiscreteValue discreteString:@"B"] forKey:@"field3"];
    [env setField:[UMDiscreteValue discreteString:@"BBB"] forKey:@"field4"];
    [env setField:[UMDiscreteValue discreteBool:NO] forKey:@"var5"];
    [env setField:[UMDiscreteValue discreteInt:123] forKey:@"var6"];
    [env setField:[UMDiscreteValue discreteData:d] forKey:@"var7"];
    
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testBoolOperations
{
    UMDiscreteValue *y = [UMDiscreteValue discreteBool:YES];
    UMDiscreteValue *n = [UMDiscreteValue discreteBool:NO];
    
    XCTAssertTrue([[y logicAnd: y]boolValue]==YES,@"YES AND YES should be YES");
    XCTAssertTrue([[y logicAnd: n]boolValue]==NO,@"YES AND NO should be NO");
    XCTAssertTrue([[n logicAnd: y]boolValue]==NO,@"NO AND YES should be NO");
    XCTAssertTrue([[n logicAnd: n]boolValue]==NO,@"NO AND NO should be NO");
    
    XCTAssertTrue([[y logicOr: y]boolValue]==YES,@"YES OR YES should be YES");
    XCTAssertTrue([[y logicOr: n]boolValue]==YES,@"YES OR NO should be YES");
    XCTAssertTrue([[n logicOr: y]boolValue]==YES,@"NO OR YES should be YES");
    XCTAssertTrue([[n logicOr: n]boolValue]==NO,@"NO OR NO should be NO");
    
    XCTAssertTrue([[y logicXor: y]boolValue]==NO,@"YES OR YES should be NO");
    XCTAssertTrue([[y logicXor: n]boolValue]==YES,@"YES OR NO should be YES");
    XCTAssertTrue([[n logicXor: y]boolValue]==YES,@"NO OR YES should be YES");
    XCTAssertTrue([[n logicXor: n]boolValue]==NO,@"NO OR NO should be NO");
    
    XCTAssertTrue([[y logicNot]boolValue]==NO,@"YES NOT should be NO");
    XCTAssertTrue([[n logicNot]boolValue]==YES,@"NO NOT should be YES");
}


- (void) testIntegers
{
    UMDiscreteValue *a1 = [UMDiscreteValue discreteInt:1];
    UMDiscreteValue *a2 = [UMDiscreteValue discreteInt:2];
    UMDiscreteValue *a3 = [UMDiscreteValue discreteInt:3];
    UMDiscreteValue *a4 = [UMDiscreteValue discreteInt:4];
    XCTAssertTrue(a1.intValue == 1,@"1 is no longer 1");
    XCTAssertTrue(a2.intValue == 2,@"2 is no longer 2");
    XCTAssertTrue(a3.intValue == 3,@"3 is no longer 3");
    XCTAssertTrue(a4.intValue == 4,@"4 is no longer 4");
    
    UMDiscreteValue *result;
    
    result = [a1 addValue:a2];
    XCTAssertTrue(result.intValue == 3,@"1+2=3 but returns %c",result.intValue);
    
    result = [a4 subtractValue:a2];
    XCTAssertTrue(result.intValue == 2,@"4-2=2 but returns %c",result.intValue);
    
    result = [a2 subtractValue:a4];
    XCTAssertTrue(result.intValue == -2,@"1-2=3 but returns %c",result.intValue);
}

- (void) testBitwiseOperations
{
    UMDiscreteValue *a1 = [UMDiscreteValue discreteInt:1];
    UMDiscreteValue *a2 = [UMDiscreteValue discreteInt:2];
    UMDiscreteValue *a3 = [UMDiscreteValue discreteInt:3];
    
    UMDiscreteValue *result;
    
    result = [a1 bitAnd: a2];
    XCTAssertTrue(result.intValue==0,@"1 & 2 = 0 but returns %d",result.intValue);
    
    result = [a1 bitAnd: a3];
    XCTAssertTrue(result.intValue==1,@"1 & 3 = 1 but returns %d",result.intValue);
    
    result = [a1 bitOr: a2];
    XCTAssertTrue(result.intValue==3,@"1 | 2 = 3 but returns %d",result.intValue);
    
    result = [a1 bitOr: a3];
    XCTAssertTrue(result.intValue==3,@"1 | 3 = 3 but returns %d",result.intValue);
    
    result = [a1 bitXor: a3];
    XCTAssertTrue(result.intValue==2,@"1 ^ 3 = 2 but returns %d",result.intValue);
    
}

- (void)testSimpleFunction
{
    UMDiscreteValue *result = nil;
    UMTerm *discrete1 = [[UMTerm alloc]initWithDiscreteValue:[UMDiscreteValue discreteInt:55]];
    
    result = [discrete1 evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==55,@"block returns %d but should return 1",result.intValue);
    
    UMTerm *discrete2 = [[UMTerm alloc]initWithDiscreteValue:[UMDiscreteValue discreteInt:123]];
    result = [discrete2 evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==123,@"block returns %d but should return 1",result.intValue);
    
    UMFunction *mathaddfunc = [env functionByName:@"MATHADD"];
    XCTAssertTrue(mathaddfunc!=NULL,@"function mathadd is not found %@",mathaddfunc);
    
    UMFunction *blockfunc = [env functionByName:@"BLOCK"];
    XCTAssertTrue(blockfunc!=NULL,@"function block is not found %@",blockfunc);
    
    UMFunction *setvarfunc = [env functionByName:@"SETVAR"];
    XCTAssertTrue(setvarfunc!=NULL,@"function block is not found %@",blockfunc);
    
    UMFunction *getvarfunc = [env functionByName:@"GETVAR"];
    XCTAssertTrue(getvarfunc!=NULL,@"function block is not found %@",blockfunc);
    
    UMFunction *returnfunc = [env functionByName:@"return"];
    XCTAssertTrue(returnfunc!=NULL,@"function return is not found %@",returnfunc);
    
    UMTerm *additionTerm1 = [[UMTerm alloc]initWithFunction:mathaddfunc
                                                  andParams:@[discrete1,discrete2]];
    result = [additionTerm1 evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==178,@"block returns %d but should return 178",result.intValue);
    
    UMTerm *discrete3 = [[UMTerm alloc]initWithDiscreteValue:[UMDiscreteValue discreteInt:23]];
    UMTerm *discrete4 = [[UMTerm alloc]initWithDiscreteValue:[UMDiscreteValue discreteInt:41]];
    UMTerm *varname1 = [[UMTerm alloc]initWithDiscreteValue:[UMDiscreteValue discreteString:@"var1"]];
    
    
    UMTerm *additionTerm2 = [[UMTerm alloc]initWithFunction:mathaddfunc
                                                  andParams:@[discrete3,discrete4]];
    result = [additionTerm2 evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==64,@"block returns %d but should return 73",result.intValue);
    
    UMTerm *setvarterm = [[UMTerm alloc]initWithFunction:setvarfunc andParams:@[varname1,additionTerm1]];
    UMTerm *getvarterm = [[UMTerm alloc]initWithFunction:getvarfunc andParams:@[varname1]];
    
    UMTerm *returnterm = [[UMTerm alloc]initWithFunction:returnfunc andParams:@[getvarterm]];
    
    UMTerm *additionTerm12 = [[UMTerm alloc]initWithFunction:blockfunc
                                                   andParams:@[setvarterm,additionTerm2,returnterm]];
    
    result = [additionTerm12 evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==178,@"block returns %d but should return 178",result.intValue);
    
    NSString *code = [additionTerm12 codeWithEnvironment:env];
    FILE *f = fopen("/Users/afink/output.txt","w+");
    if(f)
    {
        const char *c = [code UTF8String];
        size_t len = strlen(c);
        fwrite(c,len,1,f);
        fclose(f);
    }
}

- (void)testAddWithTerms
{
    UMTerm *a = [UMTerm termWithDirectInteger:3];
    UMTerm *b = [UMTerm termWithDirectInteger:4];
    UMTerm *c = [a add: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==7,@"3+4=7 not %d",result.intValue);
}

- (void)testDotStringsWithTerms
{
    UMTerm *a = [UMTerm termWithDirectString:@"3"];
    UMTerm *b = [UMTerm termWithDirectString:@"4"];
    UMTerm *c = [a dot: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    NSString *s = result.stringValue;
    XCTAssertTrue([s isEqualToString:@"34"],@"\"3\"+\"4\"=\"34\" not %@",result);
}

- (void)testSubWithTerms
{
    UMTerm *a = [UMTerm termWithDirectInteger:3];
    UMTerm *b = [UMTerm termWithDirectInteger:4];
    UMTerm *c = [a sub: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue( (result.intValue==-1),@"3-4=-1 not %d",result.intValue);
}

- (void)testSubStringsWithTerms
{
    UMTerm *a = [UMTerm termWithDirectString:@"3"];
    UMTerm *b = [UMTerm termWithDirectString:@"4"];
    UMTerm *c = [a sub: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue(result.isNull,@"\"3\"-\"4\"=(null) not %@",result);
}

- (void)testMultiplyWithTerms
{
    UMTerm *a = [UMTerm termWithDirectInteger:3];
    UMTerm *b = [UMTerm termWithDirectInteger:4];
    UMTerm *c = [a mul: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==12,@"3*4=12 not %d",result.intValue);
}

- (void)testDivideWithTerms
{
    UMTerm *a = [UMTerm termWithDirectInteger:12];
    UMTerm *b = [UMTerm termWithDirectInteger:4];
    UMTerm *c = [a div: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue( (result.intValue==3),@"12/4=3 not %d",result.intValue);
}

- (void)testCompileScript1
{
    UMScriptDocument *s = [[UMScriptDocument alloc]initWithFilename:@"umscriptTests/test1.ums"];
    [s compileSource];
    [s runScriptWithEnvironment:env];
}

- (void)testAddCompiled
{
    NSString *code = @"{ $AVAR = 1111 + 2;";
    UMScriptDocument *s = [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    XCTAssertTrue(result.intValue==3,@"1+2=3 not %d",result.intValue);

}
@end
