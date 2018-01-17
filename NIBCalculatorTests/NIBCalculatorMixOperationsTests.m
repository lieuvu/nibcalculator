//
//  NIBCalculatorMixOperationsTests.m
//  NIBCalculatorTests
//
//  Created by Lieu Vu on 10/5/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NIBOperator.h"
#import "NIBCalculatorBrain.h"
#import "NIBConstants.h"

@interface NIBCalculatorMixOperationsTests : XCTestCase

@property (readwrite, strong, nonatomic) NIBCalculatorBrain *calculator;

@end

@implementation NIBCalculatorMixOperationsTests

- (void)setUp {
    [super setUp];
    self.calculator = [[NIBCalculatorBrain alloc] init];    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMixMainOperations
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test mix operations 2.4+8.7- */
    expectedResult = [[NSNumber alloc] initWithDouble:2.4+8.7];
    [self.calculator pushOperand:2.4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:8.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.4+8.7-” is incorrect!");
    
    /* test mix operations 2.3+3.2* */
    expectedResult = [[NSNumber alloc] initWithDouble:3.2];
    [self.calculator pushOperand:2.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.3+3.2*” is incorrect!");
    
    /* test mix operations 2.4*4.2+ */
    expectedResult = [[NSNumber alloc] initWithDouble:2.4*4.2];
    [self.calculator pushOperand:2.4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:4.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.4*4.2+” is incorrect!");
    
    /* test mix operations 2.8+8.3-3.8= */
    expectedResult = [[NSNumber alloc] initWithDouble:2.8+8.3-3.8];
    [self.calculator pushOperand:2.8];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:8.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:3.8];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.8+8.3-3.8” is incorrect!");
    
    /* test mix operations 2.3+3.2*3.5= */
    expectedResult = [[NSNumber alloc] initWithDouble:2.3+3.2*3.5];
    [self.calculator pushOperand:2.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:3.5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.3+3.2*3.5=” is incorrect!");
    
    /* test mix operations 2.5+3.9/3= */
    expectedResult = [[NSNumber alloc] initWithDouble:2.5+3.9/3];
    [self.calculator pushOperand:2.5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3.9];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.5+3.9/3=” is incorrect!");
    
    /* test mix operations 2.6+3.5/0= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:2.6];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3.5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.6+3.5/0=” is incorrect!");
    
    /* test mix operations 2.7+3.4*3.3- */
    expectedResult = [[NSNumber alloc] initWithDouble:2.7+3.4*3.3];
    [self.calculator pushOperand:2.7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3.4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.7+3.4*3.3-” is incorrect!");
    
    /* test mix operations 2.3*4.2-1.5+ */
    expectedResult = [[NSNumber alloc] initWithDouble:2.3*4.2-1.5];
    [self.calculator pushOperand:2.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:4.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:1.5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The mix operation ”2.3*4.2-1.5+” is incorrect!");
}

- (void)testMixMainOperationsAndBinaryRootOperation
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test -3.3root-4.7+ */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3.3, -1.0/4.7)];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:-4.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation -3.3root-4.7+ is incorrect");
    
    /* test -3.3root-4.7* */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3.3, -1.0/4.7)];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:-4.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation -3.3root-4.7* is incorrect");
    
    /* test -3.3root-4.7*2= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3.3, -1.0/4.7)*2];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:-4.7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation -3.3root-4.7*2= is incorrect");
    
    /* test -3.3+(-5.7)root5+ */
    expectedResult = [[NSNumber alloc] initWithDouble:-3.3-pow(5.7, 1.0/5)];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:-5.7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation -3.3+-5.7root5+ is incorrect");
    
    /* test -3.3+(-5.7)root5+3*2- */
    expectedResult = [[NSNumber alloc] initWithDouble:-3.3-pow(5.7, 1.0/5)+3*2];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:-5.7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation -3.3+-5.7root5+3*2- is incorrect");
}

- (void)testMixMainOperationsAndBinaryExponentOperation
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;

    /* test 2.2+3^4* */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3, 4)];
    [self.calculator pushOperand:2.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator pushOperand:4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation ”2.2+3^4* (x^y)” is incorrect");

    /* test 7^1+5+ */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(7, 1)+5];
    [self.calculator pushOperand:7.0];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation ”2.2+4^3- (x^y)” is incorrect");
    
    /* test 2.2+4^3- */
    expectedResult = [[NSNumber alloc] initWithDouble:2.2+pow(4, 3)];
    [self.calculator pushOperand:2.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYPowerX]];
    [self.calculator pushOperand:4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation ”2.2+4^3- (y^x)” is incorrect");
}

- (void)testMixMainOperationsAndBinaryLogarithmOperation
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;

    /* test 2.2+log5.7(3)- */
    expectedResult = [[NSNumber alloc] initWithDouble:2.2+log(3)/log(5.7)];
    [self.calculator pushOperand:2.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:5.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation 2.2+log5.7(3)- is incorrect");

    /* test 2.2+log5.7(3)-3*4+ */
    expectedResult = [[NSNumber alloc] initWithDouble:2.2+log(3)/log(5.7)-3*4];
    [self.calculator pushOperand:2.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:5.7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation 2.2+log5.7(3)-3*4 is incorrect");
}

- (void)testMixMainOperationsAndEEOperation
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;

    /* test 2.2+3EE2- */
    expectedResult = [[NSNumber alloc] initWithDouble:2.2+300];
    [self.calculator pushOperand:2.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEE]];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation 2.2+3EE2- is incorrect");

    /* test 2.2+3EE5.7-3*4+ */
    expectedResult = [[NSNumber alloc] initWithDouble:2.2+3*pow(10, 5.7)-3*4];
    [self.calculator pushOperand:2.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEE]];
    [self.calculator pushOperand:5.7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation 2.2+3EE5.7-3*4+ is incorrect");
}

- (void)testMixMainOperationAndParenthesisOperation
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;

    /* test (1+7*2) */
    expectedResult = [[NSNumber alloc] initWithDouble:1+7*2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation (1+7*2) is incorrect");

    /* test (1+7*2= */
    expectedResult = [[NSNumber alloc] initWithDouble:1+7*2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation (1+7*2= is incorrect");

    /* test (1+7*2== */
    expectedResult = nil;
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation (1+7*2== is incorrect");

    /* test (1+7/2=3= */
    expectedResult = nil;
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator pushOperand:3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation (1+7/2=3= is incorrect");

    /* test 3*(1+7*2) */
    expectedResult = [[NSNumber alloc] initWithDouble:1+7*2];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation 3*(1+7*2) is incorrect");

    /* test 3*(1+7*2)= */
    expectedResult = [[NSNumber alloc] initWithDouble:3*(1+7*2)];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]] doubleValue]] ;
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation 3*(1+7*2)= is incorrect");

    /* test 3*(1+7*2= */
    expectedResult = [[NSNumber alloc] initWithDouble:3*(1+7*2)];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation 3*(1+7*2= is incorrect");

    /* test 3*(1+7*2=4= */
    expectedResult = nil;
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator pushOperand:4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation 3*(1+7*2=4= is incorrect");

    /* test (3+(1+7*2))*2= */
    expectedResult = [[NSNumber alloc] initWithDouble:36.0];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]] doubleValue]];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]] doubleValue]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]] ;
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation(3+(1+7*2))*2= is incorrect");
    
    /* test (5+2%= */
    expectedResult = [[NSNumber alloc] initWithDouble:5+0.02];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:2];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonPercentage]] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation ”(5+2%%=” is incorrect");
    
    /* test (5+sqrt(4)=3= */
    expectedResult = nil;
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSquareRootOfX]] doubleValue]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator pushOperand:3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation ”(5+sqrt(4)=3=” is incorrect");
}

- (void)testMixMainOperationsAndUnaryOperations
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 5+sqrt(2)= */
    expectedResult = [[NSNumber alloc] initWithDouble:5+sqrt(2)];
    [self.calculator pushOperand:5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:2];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSquareRootOfX]] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation ”5+sqrt(2)=” is incorrect");
    
    /* test 5+2%= */
    expectedResult = [[NSNumber alloc] initWithDouble:5+0.02];
    [self.calculator pushOperand:5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:2];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonPercentage]] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation mix operation ”5+2%%=” is incorrect");
}

@end
