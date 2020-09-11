

//
//  NIBCalculatorFunctionalOperationTests.m
//  NIBCalculatorTests
//
//  Created by Lieu Vu on 9/29/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NIBOperator.h"
#import "NIBCalculatorBrain.h"
#import "NIBConstants.h"

#pragma mark -

@interface NIBCalculatorFunctionalOperationsTests : XCTestCase

@property (readwrite, strong, nonatomic) NIBCalculatorBrain *calculator;

@end

#pragma mark -

@implementation NIBCalculatorFunctionalOperationsTests

- (void)setUp {
    [super setUp];
    self.calculator = [[NIBCalculatorBrain alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after Calculation invocation of each test method in Calculation class.
    [super tearDown];
}

#pragma mark - Percentage Operation Testing

- (void)testPercentage
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 2% */
    expectedResult = [[NSNumber alloc] initWithDouble:0.02];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonPercentage]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 2%% is incorrect");
}

#pragma mark - Root Functions Testing

- (void)testSquareRoot
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test square root of -2.5 */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-2.5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSquareRootOfX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation square root of -2.5 is incorrect");
    
    /* test square root of 2.5 */
    expectedResult = [[NSNumber alloc] initWithDouble:sqrt(2.5)];
    [self.calculator pushOperand:2.5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSquareRootOfX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation square root of 2.5 is incorrect");
}

- (void)testCubicRoot
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test cubic root of 3.5 */
    expectedResult = [[NSNumber alloc] initWithDouble:cbrt(3.5)];
    [self.calculator pushOperand:3.5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCubicRootOfX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cubic root of 3.5 is incorrect");
    
    /* test cubic root of -3.5 */
    expectedResult = [[NSNumber alloc] initWithDouble:cbrt(-3.5)];
    [self.calculator pushOperand:-3.5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCubicRootOfX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cubic root of -3.5 is incorrect");
}

- (void)testYthRootOfX
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;

    /* test -5.7root5= */
    expectedResult = [[NSNumber alloc] initWithDouble:-pow(5.7, 1.0/5)];
    [self.calculator pushOperand:-5.7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 5th root of -5.7 is incorrect");

    /* test -10.3root4= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-10.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 4th root of -10.3 is incorrect");

    /* test 1root0= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 0th root of 1 is incorrect");

    /* test 7.3root5.2= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(7.3, 1.0/5.2)];
    [self.calculator pushOperand:7.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:5.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 5.2th root of 7.3 is incorrect");

    /* test -4.5root5.2= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-4.5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:5.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 5.2th root of -4.5 is incorrect");
    
    /* test -5root0.75= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(5.0, 1/0.75)];
    [self.calculator pushOperand:-5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:0.75];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 0.75th root of -5 is incorrect");

    /* test 9.5root-3.5= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(9.5, -1.0/3.5)];
    [self.calculator pushOperand:9.5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:-3.5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.5th root of 9.5 is incorrect");

    /* test -3.3root-4.7= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3.3, -1.0/4.7)];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:-4.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -4.7th root of -3.3 is incorrect");
    
    /* test 2root(1/3)= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(2, 3)];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:1.0/3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 1/3th root of 2 is incorrect");
    
    /* test 2root(-1/3)= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(2, -3)];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYthRootOfX]];
    [self.calculator pushOperand:-1.0/3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -1/3th root of 2 is incorrect");
}

#pragma mark - Exponential Functions Testing

- (void)testXSquared
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 3.3^2 */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3.3, 2)];
    [self.calculator pushOperand:3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXSquared]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 3.3^2 is incorrect");
    
    /* test -3.3^2 */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(-3.3, 2)];
    [self.calculator pushOperand:-3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXSquared]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^2 is incorrect");
}

- (void)testXCubed
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 3.3^3 */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3.3, 3)];
    [self.calculator pushOperand:3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXCubed]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 3.3^3 is incorrect");
    
    /* test -3.3^3 */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(-3.3, 3)];
    [self.calculator pushOperand:-3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXCubed]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^3 is incorrect");
}

- (void)testEulerNumberPowerX
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test e^2.2 */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(M_E, 2.2)];
    [self.calculator pushOperand:2.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEulerNumberPowerX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation e^(2.2) is incorrect");
    
    /* test e^(-2.2) */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(M_E, -2.2)];
    [self.calculator pushOperand:-2.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEulerNumberPowerX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation e^(2.2) is incorrect");
}

- (void)testTenPowerX
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 10^2.3 */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(10.0, 2.3)];
    [self.calculator pushOperand:2.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTenPowerX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 10^(2.3) is incorrect");
    
    /* test 10^(-2.3) */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(10.0, -2.3)];
    [self.calculator pushOperand:-2.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTenPowerX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 10^(-2.3) is incorrect");
}

- (void)testTwoPowerX
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 2^2.4 */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(2.0, 2.4)];
    [self.calculator pushOperand:2.4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTwoPowerX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 2^(2.4) is incorrect");
    
    /* test 2^(-2.4) */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(2.0, -2.4)];
    [self.calculator pushOperand:-2.4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTwoPowerX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 2^(-2.4) is incorrect");
}

- (void)testXPowerY
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test -3.3^5.2= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3.3, 5.2)];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator pushOperand:5.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^5.2= (x^y) is incorrect");
    
    /* test -3.3^2.75= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator pushOperand:2.75];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^2.75= (x^y) is incorrect");
    
    /* test -3.3^-2.75= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator pushOperand:-2.75];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^-2.75= is (x^y) incorrect");
    
    /* test -3.3^M_PI= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator pushOperand:M_PI];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^M_PI= (x^y) is incorrect");
    
    /* test -3.3^(sqrt(2))= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator pushOperand:sqrt(2)];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^(sqrt(2))= (x^y) is incorrect");
    
    /* test e^2.2= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(M_E, 2.2)];
    [self.calculator pushOperand:M_E];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator pushOperand:2.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation e^(2.2)= (x^y) is incorrect");
}

- (void)testYPowerX
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test -3.3^5.2= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(3.3, 5.2)];
    [self.calculator pushOperand:5.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYPowerX]];
    [self.calculator pushOperand:-3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^5.2= (y^x) is incorrect");
    
    /* test -3.3^2.75= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:2.75];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYPowerX]];
    [self.calculator pushOperand:-3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^2.75= (y^x) is incorrect");
    
    /* test -3.3^-2.75= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-2.75];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYPowerX]];
    [self.calculator pushOperand:-3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^-2.75= (y^x) is incorrect");
    
    /* test -3.3^M_PI= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:M_PI];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYPowerX]];
    [self.calculator pushOperand:-3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^M_PI= (y^x) is incorrect");
    
    /* test -3.3^(sqrt(2))= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:sqrt(2)];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYPowerX]];
    [self.calculator pushOperand:-3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3.3^(sqrt(2))= (y^x) is incorrect");
    
    /* test e^2.2= */
    expectedResult = [[NSNumber alloc] initWithDouble:pow(M_E, 2.2)];
    [self.calculator pushOperand:2.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonYPowerX]];
    [self.calculator pushOperand:M_E];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation e^(2.2)= (y^x) is incorrect");
}

#pragma mark - Trigonometric Functions Testing

- (void)testSinFunctionInDegreeMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test sin(3.7) */
    expectedResult = [[NSNumber alloc] initWithDouble:sin(3.7*M_PI/180)];
    [self.calculator pushOperand:3.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(3.7) in degree mode is incorrect");
    
    /* test sin(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(0) in degree mode is incorrect");
    
    /* test sin(90) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:90];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(90) in degree mode is incorrect");
    
    /* test sin(180) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:180];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(180) in degree mode is incorrect");
    
    /* test sin(270) */
    expectedResult = [[NSNumber alloc] initWithDouble:-1.0];
    [self.calculator pushOperand:270];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(270) in degree mode is incorrect");
    
    /* test sin(360) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:360];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(360) in degree mode is incorrect");

}

- (void)testCosFunctionInDegreeMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test cos(3.7) */
    expectedResult = [[NSNumber alloc] initWithDouble:cos(3.7*M_PI/180)];
    [self.calculator pushOperand:3.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(3.7) in degree mode is incorrect");
    
    /* test cos(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(0) in degree mode is incorrect");
    
    /* test cos(90) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:90];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(90) in degree mode is incorrect");
    
    /* test cos(180) */
    expectedResult = [[NSNumber alloc] initWithDouble:-1.0];
    [self.calculator pushOperand:180];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(180) in degree mode is incorrect");
    
    /* test cos(270) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:270];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(270) in degree mode is incorrect");
    
    /* test cos(360) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:360];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(360) in degree mode is incorrect");
}

- (void)testTanFuntionInDegreeMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test tan(3.7) */
    expectedResult = [[NSNumber alloc] initWithDouble:tan(3.7*M_PI/180)];
    [self.calculator pushOperand:3.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(3.7) in degree mode is incorrect");
    
    /* test tan(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(0) in degree mode is incorrect");
    
    /* test tan(90) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:90];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(90) in degree mode is incorrect");
    
    /* test tan(180) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:180];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(180) in degree mode is incorrect");
    
    /* test tan(270) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:270];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(270) in degree mode is incorrect");
    
    /* test tan(360) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:360];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(360) in degree mode is incorrect");
    
}

- (void)testSinFunctionInRadianMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    [self.calculator toggleRadianMode];
    
    /* test sin(π/2) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:1.5707963267948966];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(π/2) in radian mode is incorrect");
    
    /* test sin(π) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:3.1415926535897932];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(π) in radian mode is incorrect");
    
    /* test sin(3*π/2) */
    expectedResult = [[NSNumber alloc] initWithDouble:-1.0];
    [self.calculator pushOperand:3*M_PI_2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(3*π/2) in radian mode is incorrect");
    
    /* test sin(2*π) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:2*M_PI];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sin(2*π) in radian mode is incorrect");
    
}

- (void)testCosFunctionInRadianMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    [self.calculator toggleRadianMode];
    
    /* test cos(π/2) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:1.5707963267948966];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(π/2) in radian mode is incorrect");
    
    /* test cos(π) */
    expectedResult = [[NSNumber alloc] initWithDouble:-1.0];
    [self.calculator pushOperand:3.141592653589793];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(π) in radian mode is incorrect");
    
    /* test cos(3*π/2) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:4.71238898038469];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(3*π/2) in radian mode is incorrect");
    
    /* test cos(2*π) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:6.283185307179586];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cos(2*π) in radian mode is incorrect");
}

- (void)testTanFunctionInRadianMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    [self.calculator toggleRadianMode];
    
    /* test tan(π/2) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:1.5707963267948966];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(π/2) in radian mode is incorrect");
    
    /* test tan(π) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:3.1415926535897932];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(π) in radian mode is incorrect");
    
    /* test tan(3*π/2) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:4.71238898038469];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(3*π/2) in radian mode is incorrect");
    
    /* test tan(2*π) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:6.283185307179586];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tan(2*π) in radian mode is incorrect");
}

#pragma mark - Hyperbolic Functions Testing

- (void)testSinhFunction
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test sinh(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSinh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sinh(0) is incorrect");
    
    /* test sinh(3.3) */
    expectedResult = [[NSNumber alloc] initWithDouble:sinh(3.3)];
    [self.calculator pushOperand:3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSinh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation sinh(3.3) is incorrect");
}

- (void)testCoshFunction
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test cosh(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCosh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cosh(0) is incorrect");
    
    /* test cosh(3.3) */
    expectedResult = [[NSNumber alloc] initWithDouble:cosh(3.3)];
    [self.calculator pushOperand:3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCosh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation cosh(3.3) is incorrect");
}

- (void)testTanhFunction
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test tanh(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTanh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tanh(0) is incorrect");
    
    /* test tanh(3.3) */
    expectedResult = [[NSNumber alloc] initWithDouble:tanh(3.3)];
    [self.calculator pushOperand:3.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonTanh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation tanh(3.3) is incorrect");
}

#pragma mark - Inverse Trigonometric Functions Testing

- (void)testArcSinFunctionInDegreeMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test arcsin(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(0) in degree mode is incorrect");
    
    /* test arcsin(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:90.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(1) in degree mode is incorrect");
    
    /* test arcsin(-1) */
    expectedResult = [[NSNumber alloc] initWithDouble:-90.0];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(-1) in degree mode is incorrect");
    
    /* test arcsin(-1.1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(-1.1) in degree mode is incorrect");
    
    /* test arcsin(1.1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:1.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(1.1) in degree mode is incorrect");
}

- (void)testArcCosFunctionInDegreeMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test arccos(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:90.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(0) in degree mode is incorrect");
    
    /* test arccos(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(1) in degree mode is incorrect");
    
    /* test arccos(-1) */
    expectedResult = [[NSNumber alloc] initWithDouble:180.0];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(-1) in degree mode is incorrect");
    
    /* test arccos(-1.1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(-1.1) in degree mode is incorrect");
    
    /* test arccos(1.1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:1.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(1.1) in degree mode is incorrect");
}

- (void)testArcTanFunctionInDegreeMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test arctan(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arctan(0) in degree mode is incorrect");
    
    /* test arctan(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:45.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arctan(1) in degree mode is incorrect");
    
    /* test arctan(-1) */
    expectedResult = [[NSNumber alloc] initWithDouble:-45.0];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arctan(-1) in degree mode is incorrect");
}

- (void)testArcSinFunctionInRadianMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    [self.calculator toggleRadianMode];
    
    /* test arcsin(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(0) in radian is incorrect");
    
    /* test arcsin(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:M_PI/2];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(1) in radian mode is incorrect");
    
    /* test arcsin(-1) */
    expectedResult = [[NSNumber alloc] initWithDouble:-M_PI/2];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(-1) in radian mode is incorrect");
    
    /* test arcsin(-1.1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(-1.1) in radian mode is incorrect");
    
    /* test arcsin(1.1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:1.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSin]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsin(1.1) in radian mode is incorrect");
}

- (void)testArcCosFunctionInRadianMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    [self.calculator toggleRadianMode];
    
    /* test arccos(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:M_PI/2];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(0) in radian mode is incorrect");
    
    /* test arccos(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(1) in radian mode is incorrect");
    
    /* test arccos(-1) */
    expectedResult = [[NSNumber alloc] initWithDouble:M_PI];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(-1) in radian mode is incorrect");
    
    /* test arccos(-1.1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(-1.1) in radian mode is incorrect");
    
    /* test arccos(1.1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:1.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCos]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccos(1.1) in radian mode is incorrect");
}

- (void)testArcTanFunctionInRadianMode
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    [self.calculator toggleRadianMode];
    
    /* test arctan(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arctan(0) in radian mode is incorrect");
    
    /* test arctan(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:M_PI_4];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arctan(1) in radian mode is incorrect");
    
    /* test arctan(-1) */
    expectedResult = [[NSNumber alloc] initWithDouble:-M_PI_4];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcTan]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arctan(-1) in radian mode is incorrect");
}

#pragma mark - Inverse Hyperbolic Functions Testing

- (void)testArcSinhFunction
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test arcsinh(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSinh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsinh(0) is incorrect");
    
    /* test arcsinh((e - 1/e)/2) */
    expectedResult = [[NSNumber alloc] initWithDouble:1];
    [self.calculator pushOperand:(M_E - 1/M_E)/2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcSinh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcsinh((e - 1/e)/2) is incorrect");
}

- (void)testArcCoshFunction
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test arcosh((e + 1/2)/2) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:(M_E + 1/M_E)/2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCosh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arcosh((e + 1/2)/2) is incorrect");
    
    /* test arcosh(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcCosh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arccosh(1) is incorrect");
}

- (void)testArcTanhFunction
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;

    /* test arctanh(0) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcTanh]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arctanh(0) is incorrect");
    
    /* test arctanh((e^2-1)/(e^2+1)) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:(M_E*M_E - 1)/(M_E*M_E + 1)];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonArcTanh]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation arctanh((e^2-1)/(e^2+1)) is incorrect");
}

#pragma mark - Logarithm Functions Testing

- (void)testNaturalLogarithm
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test ln(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonNaturalLogarithm]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation ln(1) is incorrect");
    
    /* test ln(e) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:M_E];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonNaturalLogarithm]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation ln(e) is incorrect");
    
    /* test ln(-1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonNaturalLogarithm]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation ln(-1) is incorrect");
    
}

- (void)testCommonLogarithm
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test log10(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCommonLogarithm]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log10(1) is incorrect");
    
    /* test log10(10) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:10];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCommonLogarithm]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log10(10) is incorrect");
    
    /* test log10(-1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonCommonLogarithm]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log10(-1) is incorrect");
}

- (void)testLogarithmOfBase2
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test log2(1) */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseTwo]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log2(1) is incorrect");
    
    /* test log2(2) */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseTwo]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log2(2) is incorrect");
    
    /* test log2(-1) */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseTwo]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log2(-1) is incorrect");
}

- (void)testLogarithmOfBaseYOfX
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test log5(1)= */
    expectedResult = [[NSNumber alloc] initWithDouble:0.0];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log5(1)= is incorrect");
    
    /* test log7(7)= */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:7];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log7(7)= is incorrect");
    
    /* test log7(-1)= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log7(-1) is incorrect");
    
    /* test log1(2)= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log1(2) is incorrect");
    
    /* test log(-5)(1)= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:-5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log(-5)(-1) is incorrect");
    
    /* test log(-5)(-1)= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:-5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log(-5)(-1) is incorrect");
    
    /* test log5.7(-1)= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:5.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log5.7(-1) is incorrect");
    
    /* test log5.7(3)= */
    expectedResult = [[NSNumber alloc] initWithDouble:log(3)/log(5.7) ];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonLogarithmBaseYOfX]];
    [self.calculator pushOperand:5.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation log5.7(3) is incorrect");
}

#pragma mark - Memory Operation Testing

- (void)testMemoryOperation
{
    NSNumber *expectedResult = nil;
    NSNumber *memory = nil;
    
    /* test initial memory */
    expectedResult = nil;
    memory = self.calculator.memory;
    
    XCTAssertEqualObjects(memory, expectedResult, @"Initial memory is incorrect");
    
    /* test add 5.6 to the memory */
    expectedResult = [[NSNumber alloc] initWithDouble:5.6];
    [self.calculator addToMemory:5.6];
    memory = self.calculator.memory;
    
    XCTAssertEqualObjects(memory, expectedResult, @"Add 5.6 to memory is incorrect");
    
    /* test add 3.3 to the memory */
    expectedResult = [[NSNumber alloc] initWithDouble:5.6+3.3];
    [self.calculator addToMemory:3.3];
    memory = self.calculator.memory;
    
    XCTAssertEqualObjects(memory, expectedResult, @"Add 3.3 to memory is incorrect");
    
    /* test substract 0.1 from the memory */
    expectedResult = [[NSNumber alloc] initWithDouble:5.6+3.3-0.1];
    [self.calculator subtractFromMemory:0.1];
    memory = self.calculator.memory;
    
    XCTAssertEqualObjects(memory, expectedResult, @"Add 0.1 to memory is incorrect");
    
    /* test clear memory */
    expectedResult = nil;
    [self.calculator clearMemory];
    memory = self.calculator.memory;
    
    XCTAssertEqualObjects(memory, expectedResult, @"Clear memory incorrect");
}


#pragma mark - Miscellaneous Functions Testing

- (void)testReciprocalFunctionOfX
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 1/0 */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOneOverX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 1/0 is incorrect");
    
    /* test 1/3.7 */
    expectedResult = [[NSNumber alloc] initWithDouble:1/3.7];
    [self.calculator pushOperand:3.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOneOverX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 1/3.7 is incorrect");
    
    /* test 1/π */
    expectedResult = [[NSNumber alloc] initWithDouble:1/M_PI];
    [self.calculator pushOperand:[[self.calculator constantNumber:[NIBOperator operatorWithTag:NIBButtonPi]] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOneOverX]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 1/π is incorrect");
}

- (void)testFactorialFunction
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 0! */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXFactorial]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 0! is incorrect");
    
    /* test 1! */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXFactorial]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 1! is incorrect");
    
    /* test 2! */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0*2];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXFactorial]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 2! is incorrect");
    
    /* test 5! */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0*2*3*4*5];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXFactorial]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 5! is incorrect");
    
    /* test 170! */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:170];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXFactorial]];
    
    XCTAssertNotEqualObjects(calculatedResult, expectedResult, @"Calculation 170! is incorrect");
    
    /* test 171! */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:171];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXFactorial]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 171! is incorrect");
    
    /* test 3.14! */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:3.14];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXFactorial]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 3.14! is incorrect");
    
    /* test -3! */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:-3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXFactorial]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation -3! is incorrect");
}

- (void)testScientificNotation
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 5.3EE5= */
    expectedResult = [[NSNumber alloc] initWithDouble:5.3*pow(10, 5)];
    [self.calculator pushOperand:5.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEE]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 5.3EE5 is incorrect");
    
    /* test 5.3EE160= */
    expectedResult = [[NSNumber alloc] initWithDouble:5.3*pow(10, 160)];
    [self.calculator pushOperand:5.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEE]];
    [self.calculator pushOperand:160];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 5.3EE160= is incorrect");
    
    /* test 5.3EE30.8= */
    expectedResult = [[NSNumber alloc] initWithDouble:5.3*pow(10, 30.8)];
    [self.calculator pushOperand:5.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEE]];
    [self.calculator pushOperand:30.8];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 5.3EE30.8= is incorrect");
    
    /* test 3EE5.7 */
    expectedResult = [[NSNumber alloc] initWithDouble:3*pow(10, 5.7)];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEE]];
    [self.calculator pushOperand:5.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation 3EE5.7 is incorrect");
}

- (void)testGetAConstantNumber
{
    double expectedResult = 0;
    NSNumber *result = nil;
    
    /* test get π */
    expectedResult = M_PI;
    result = [self.calculator constantNumber:[NIBOperator operatorWithTag:NIBButtonPi]];
    
    XCTAssertTrue(result.doubleValue == expectedResult, @"π is returned incorrect");
    
    /* test get euler number */
    expectedResult = M_E;
    result = [self.calculator constantNumber:[NIBOperator operatorWithTag:NIBButtonEulerNumber]];
    
    XCTAssertTrue(result.doubleValue == expectedResult, @"e is returned incorrect");
    
    /* test get random number */
    result = [self.calculator constantNumber:[NIBOperator operatorWithTag:NIBButtonRand]];
    
    XCTAssertTrue(result.doubleValue >= 0 && result.doubleValue <= 1, @"Random numbe is generated incorrect");
}

- (void)testParenthesesOperation
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test (= */
    expectedResult = nil;
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation (= is incorrect");
    
    /* test () */
    expectedResult = nil;
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation () is incorrect");
    
    /* test ((() */
    expectedResult = nil;
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Calculation ((() is incorrect");
}

@end
