//
//  umscriptTests.m
//  umscriptTests
//
//  Created by Andreas Fink on 19.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <XCTest/XCTest.h>

#import "UMFunction.h"
#import "UMTerm.h"
#import "UMEnvironment.h"
#import "UMScriptDocument.h"

@interface umscriptTests : XCTestCase
{
    UMEnvironment *env;
    BOOL filePathSet;
}
@end

@implementation umscriptTests

- (void)setUp
{
    [super setUp];
    env = [[UMEnvironment alloc]init];

    NSString* path = [[[NSProcessInfo processInfo]environment]objectForKey:@"SRCROOT"];
    //NSLog(@"SRCROOT=%@",path);
    if(path)
    {
        if(0==chdir(path.UTF8String))
        {
            filePathSet = YES;
        }
    }

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


- (void)testAddWithTerms
{
    UMTerm *a = [UMTerm termWithDirectInteger:3 withEnvironment:env];
    UMTerm *b = [UMTerm termWithDirectInteger:4 withEnvironment:env];
    UMTerm *c = [a add: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==7,@"3+4=7 not %d",result.intValue);
}

- (void)testDotStringsWithTerms
{
    UMTerm *a = [UMTerm termWithDirectString:@"3" withEnvironment:env];
    UMTerm *b = [UMTerm termWithDirectString:@"4" withEnvironment:env];
    UMTerm *c = [a dot: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    NSString *s = result.stringValue;
    XCTAssertTrue([s isEqualToString:@"34"],@"\"3\"+\"4\"=\"34\" not %@",result);
}

- (void)testSubWithTerms
{
    UMTerm *a = [UMTerm termWithDirectInteger:3 withEnvironment:env];
    UMTerm *b = [UMTerm termWithDirectInteger:4 withEnvironment:env];
    UMTerm *c = [a sub: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue( (result.intValue==-1),@"3-4=-1 not %d",result.intValue);
}

- (void)testSubStringsWithTerms
{
    UMTerm *a = [UMTerm termWithDirectString:@"3" withEnvironment:env];
    UMTerm *b = [UMTerm termWithDirectString:@"4" withEnvironment:env];
    UMTerm *c = [a sub: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue(result.isNull,@"\"3\"-\"4\"=(null) not %@",result);
}

- (void)testMultiplyWithTerms
{
    UMTerm *a = [UMTerm termWithDirectInteger:3 withEnvironment:env];
    UMTerm *b = [UMTerm termWithDirectInteger:4 withEnvironment:env];
    UMTerm *c = [a mul: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue(result.intValue==12,@"3*4=12 not %d",result.intValue);
}

- (void)testDivideWithTerms
{
    UMTerm *a = [UMTerm termWithDirectInteger:12 withEnvironment:env];
    UMTerm *b = [UMTerm termWithDirectInteger:4 withEnvironment:env];
    UMTerm *c = [a div: b];
    UMDiscreteValue *result = [c evaluateWithEnvironment:env];
    XCTAssertTrue( (result.intValue==3),@"12/4=3 not %d",result.intValue);
}

- (void)testCompileScript1
{
    if(filePathSet)
    {
    char buffer[256];
    NSLog(@"PWD=%s",getcwd(buffer, sizeof(buffer)));

    UMScriptDocument *s = [[UMScriptDocument alloc]initWithFilename:@"umscriptTests/test1.ums"];
    [s compileSource];
    [s runScriptWithEnvironment:env];
    }
}

- (void)testAddCompiled
{
    NSString *code = @"int main() { return 1 + 2; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    s.name = @"Untitled";
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    XCTAssertTrue(result.intValue==3,@"1+2=3 not %d",result.intValue);

}

- (void)testScript1
{
    NSString *code = @"int main() { $a = 1;"
    @"$b=2;"
    @"$c=3;"
    @"if($a==1) { return $b + 100; } else { return $c + 200; }; return 222; }";
    
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    s.name = @"Untitled";
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];

    XCTAssertTrue(result.intValue==102,@"should be 102 but is %d",result.intValue);
}

- (void)testScript2
{
    NSString *code = @"int main() { $a = 1;"
    @"$b=2;"
    @"$c=3;"
    @"while($a==1)"
    @"{"
    @"  $b++;"
    @"  if( $b > 100)"
    @"  {"
    @"     break;"
    @"  }"
    @"}"
    @"return $b; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    s.name = @"Untitled";
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    
    XCTAssertTrue(result.intValue==101,@"should be 102 but is %d",result.intValue);
}

- (void)testBlock
{
    NSString *code = @"int main() { $a = 1;"
    @"$b=-1;"
    @"$c=-1;"
    @"$d=-1;"
    @"$e=-1;"
    @"$f=-1;"
    @"$g=-1; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    XCTAssertTrue(s.compiledCode.param.count == 7,@"value is %d",(int)s.compiledCode.param.count);
}

- (void)testAddingVariables
{
        NSString *code =
    @"int main () { $a = 1;"
    @"$b = 2;"
    @"$c = 4;"
    @"$d = $a + $b + $c;"
    @"$e = -1;"
    @"return $d; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    XCTAssertTrue(result.intValue==7,@"should be 7 but is %d",result.intValue);
}

- (void)testAddingVariablesInBlock
{
    NSString *code =
    @"int main() {"
    @"$a = 1;"
    @"$b = 2;"
    @"$c = 4;"
    @"$d = $a + $b + $c;"
    @"$e = -1;"
    @"return $d;"
    @"}";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    XCTAssertTrue(result.intValue==7,@"should be 7 but is %d",result.intValue);
}

- (void)testSwitchWithFallthrough
{
    NSString *code = @"int main()  { $a = 1;"
    @"$b = -1;"
    @"switch($a)"
    @"{"
    @"   case 1:"
    @"        $b = $b + 100;"
    @"   case 2:"
    @"        $b = $b + 200;"
    @"        break;"
    @"   case 3:"
    @"        $b = $b + 400;"
    @"        break;"
    @"   default:"
    @"        $b = $b + 800;"
    @"        break;"
    @"}"
    @"return $b; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    
    XCTAssertTrue(result.intValue==299,@"should be 299 but is %d",result.intValue);
}

- (void)testSwitchWithDefault
{
    NSString *code = @"int main() { $a = 99;"
    @"$b = -1;"
    @"switch($a)"
    @"{"
    @"   case 1:"
    @"        $b = $b + 100;"
    @"   case 2:"
    @"        $b = $b + 200;"
    @"        break;"
    @"   case 3:"
    @"        $b = $b + 400;"
    @"        break;"
    @"   default:"
    @"        $b = $b + 800;"
    @"        break;"
    @"}"
    @"return $b; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    
    XCTAssertTrue(result.intValue==799,@"should be 799 but is %d",result.intValue);
}


- (void)testGoto
{
    NSString *code = @"int main() { $a = 100;"
    @"goto test;"
    @"$a++;"
    @"test:"
    @"return $a; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    
    XCTAssertTrue(result.intValue==100,@"should be 100 but is %d",result.intValue);
}

- (void)testString
{
    NSString *code = @"int main() { $a = \"abc\";"
    @"return $a; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];

    XCTAssertTrue([result.stringValue isEqualToString:@"abc"],@"should be abc but is %@",result.stringValue);
}

- (void)testSubstring1
{
    NSString *code = @"int main() { $a = \"0123456789ABCDEFG\";"
    @"$b = substr($a,0,3);"
    @"return $b; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    
    XCTAssertTrue([result.stringValue isEqualToString:@"012"],@"should be 012 but is %@",result.stringValue);
}


- (void)testSubstring2
{
    NSString *code = @"int main() { $a = \"0123456789ABCDEFG\";"
    @"$b = substr($a,1,2);"
    @"return $b; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    
    XCTAssertTrue([result.stringValue isEqualToString:@"12"],@"should be 12 but is %@",result.stringValue);
}

- (void)testSubstring3
{
    NSString *code = @"int main() { $a = \"0123456789ABCDEFG\";"
    @"$b = substr($a,3,5);"
    @"return $b; }";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    
    XCTAssertTrue([result.stringValue isEqualToString:@"34567"],@"should be 34567 but is %@",result.stringValue);
}

- (void)testSubstringWithoutLength
{
    NSString *code = @"int main() { $a = \"0123456789ABCDEFG\";"
    @"$b = substr($a,3);"
    @"return $b;}";
    UMScriptDocument *s =  [[UMScriptDocument alloc]initWithCode:code];
    [s compileSource];
    UMDiscreteValue *result = [s runScriptWithEnvironment:env];
    
    XCTAssertTrue([result.stringValue isEqualToString:@"3456789ABCDEFG"],@"should be 3456789ABCDEFG but is %@",result.stringValue);
}




@end
