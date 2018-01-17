//
//  NIBCalculatorOperationsSwitchingTests.m
//  NIBCalculatorTests
//
//  Created by Lieu Vu on 10/21/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NIBOperator.h"
#import "NIBCalculatorBrain.h"

@interface NIBCalculatorOperationsSwitchingTests : XCTestCase

@property (readwrite, strong, nonatomic) NIBCalculatorBrain *calculator;

@end

@implementation NIBCalculatorOperationsSwitchingTests

- (void)setUp {
    [super setUp];
    self.calculator = [[NIBCalculatorBrain alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOperationsSwitching
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test operation switching 2+-* */
    expectedResult = nil;
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”2+-*” is incorrect!");
    
    /* test operation switching 3+4* */
    expectedResult = [[NSNumber alloc] initWithDouble:4];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”3+4-*” is incorrect!");
    
    /* test operation switching 3+4- */
    expectedResult = [[NSNumber alloc] initWithDouble:7];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”3+4-” is incorrect!");
    
    /* test operation switching 3+4-/ */
    expectedResult = [[NSNumber alloc] initWithDouble:4];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”3+4-/” is incorrect!");
    
    /* test operation switching 3+4-* */
    expectedResult = [[NSNumber alloc] initWithDouble:4];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”3+4-/” is incorrect!");
    
    /* test operation switching 3+4*5- */
    expectedResult = [[NSNumber alloc] initWithDouble:23];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”3+4*5-” is incorrect!");
    
    /* test operation switching 3+4*5* */
    expectedResult = [[NSNumber alloc] initWithDouble:20];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”3+4*5*” is incorrect!");
    
    /* test operation switching 3+4*5^ */
    expectedResult = [[NSNumber alloc] initWithDouble:5];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”3+4*5^” is incorrect!");
    
    /* test operation switching 2+(3+4*5)+ */
    expectedResult = [[NSNumber alloc] initWithDouble:25];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:5];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”2+(3+4*5)+” is incorrect!");
    
    /* test operation switching 2+(3+4*5)/ */
    expectedResult = [[NSNumber alloc] initWithDouble:23];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:5];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]] doubleValue]] ;
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”2+(3+4*5)/” is incorrect!");
    
    /* test operation switching 2+(3+4*5)^ */
    expectedResult = [[NSNumber alloc] initWithDouble:23];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:5];
    [self.calculator pushOperand:[[self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonClosingParenthesis]] doubleValue]] ;
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXPowerY]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”2+(3+4*5)/” is incorrect!");
    
    /* test operation switching 2*(3+ */
    expectedResult = [[NSNumber alloc] initWithDouble:3];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator clearArithmetic];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”2*(3+” is incorrect!");
    
    /* test operation switching 2/(2*3* */
    expectedResult = [[NSNumber alloc] initWithDouble:6];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonOpenningParenthesis]];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The operation switching ”2/(2*3*” is incorrect!");
}


@end
