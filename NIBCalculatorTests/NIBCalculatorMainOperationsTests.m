//
//  Created by Lieu Vu on 9/28/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NIBCalculatorBrain.h"
#import "NIBOperator.h"
#import "NIBConstants.h"

#pragma mark -

@interface NIBCalculatorMainOperationsTests : XCTestCase

/** Calculator */
@property (readwrite, strong, nonatomic) NIBCalculatorBrain *calculator;

@end

#pragma mark -

@implementation NIBCalculatorMainOperationsTests

- (void)setUp
{
    [super setUp];
    self.calculator = [[NIBCalculatorBrain alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDivision
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test division 15/3= */
    expectedResult = [[NSNumber alloc] initWithDouble:15.0/3];
    [self.calculator pushOperand:15];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:3];
     calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The division ”15/3=” is incorrect!");
    
    /* test division -4.6/2= */
    expectedResult = [[NSNumber alloc] initWithDouble:-4.6/2];
    [self.calculator pushOperand:-4.6];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The division ”-4.6/2=” is incorrect!");
    
    /* test division 4.6/-2.3= */
    expectedResult = [[NSNumber alloc] initWithDouble:4.6/(-2.3)];
    [self.calculator pushOperand:4.6];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:-2.3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The division ”4.6/-2.3=” is incorrect!");
    
    /* test division 1/3= */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0/3];
    [self.calculator pushOperand:1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The division ”1/3=” is incorrect!");
    
    /* test division 10/0= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:10];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The division ”10/0” is incorrect!");
    
    /* test division 0/0= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:0];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The division ”10/0” is incorrect!");
}

- (void)testMultiplication
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test multiplication 4.3*5= */
    expectedResult = [[NSNumber alloc] initWithDouble:4.3*5];
    [self.calculator pushOperand:4.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The multiplication ”4.3*5=” is incorrect!");
    
    /* test multiplication -4.3*-5= */
    expectedResult = [[NSNumber alloc] initWithDouble:-4.3*(-5)];
    [self.calculator pushOperand:-4.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:-5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The multiplication ”-4.3*-5=” is incorrect!");
    
    /* test multiplication -4.3*5= */
    expectedResult = [[NSNumber alloc] initWithDouble:-4.3*5];
    [self.calculator pushOperand:-4.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The multiplication ”-4.3*5=” is incorrect!");
    
    /* test multiplication 4.3*-5= */
    expectedResult = [[NSNumber alloc] initWithDouble:-4.3*5];
    [self.calculator pushOperand:4.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:-5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The multiplication ”4.3*-5=” is incorrect!");
    
    /* test multiplication 1/3*3= */
    expectedResult = [[NSNumber alloc] initWithDouble:1.0];
    [self.calculator pushOperand:1.0/3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:3];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The multiplication ”1/3*3” is incorrect!");
}

- (void)testSubstraction
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test subtraction 3.4-2.1= */
    expectedResult = [[NSNumber alloc] initWithDouble:3.4-2.1];
    [self.calculator pushOperand:3.4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:2.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The substraction ”3.4-2.1=” is incorrect!");
    
    /* test subtraction 3.2--2.1= */
    expectedResult = [[NSNumber alloc] initWithDouble:3.2-(-2.1)];
    [self.calculator pushOperand:3.2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:-2.1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The substraction ”3.2--2.1=” is incorrect!");
    
    /* test subtraction -2.5--3.7= */
    expectedResult = [[NSNumber alloc] initWithDouble:-2.5-(-3.7)];
    [self.calculator pushOperand:-2.5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:-3.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The substraction ”-2.5--3.7=” is incorrect!");
    
    /* test subtraction 2.5-3.7= */
    expectedResult = [[NSNumber alloc] initWithDouble:2.5-3.7];
    [self.calculator pushOperand:2.5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:3.7];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The substraction ”2.5-3.7=” is incorrect!");
}

- (void)testAddition
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test addition 3.1+2.2= */
    expectedResult = [[NSNumber alloc] initWithDouble:(3.1+2.2)];
    [self.calculator pushOperand:3.1];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:2.2];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The addition ”3.1+2.2=” is incorrect!");
    
    /* test addition -3.3+2.5= */
    expectedResult = [[NSNumber alloc] initWithDouble:-3.3+2.5];
    [self.calculator pushOperand:-3.3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:2.5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The addition ”-3.3+2.5=” is incorrect!");
}

@end
