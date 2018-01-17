//
//  NIBCalculatorCacheOperationTests.m
//  NIBCalculatorTests
//
//  Created by Lieu Vu on 10/6/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NIBOperator.h"
#import "NIBCalculatorBrain.h"
#import "NIBConstants.h"

@interface NIBCalculatorCachedOperationTests : XCTestCase

@property (readwrite, strong, nonatomic) NIBCalculatorBrain *calculator;

@end

@implementation NIBCalculatorCachedOperationTests

- (void)setUp {
    [super setUp];
    self.calculator = [[NIBCalculatorBrain alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCachedUnaryOperationCache {
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    
    /* test 4(sqrt)9= */
    expectedResult = [[NSNumber alloc] initWithDouble:3.0];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSquareRootOfX]];
    [self.calculator pushOperand:9];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Cached operation square root 4(sqrt)9= is incorrect");
    
    /* test -2.5(sqrt)9= */
    expectedResult = [[NSNumber alloc] initWithDouble:3.0];
    [self.calculator pushOperand:-2.5];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSquareRootOfX]];
    [self.calculator pushOperand:9];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Cached operation square root -2.5(sqrt)9= is incorrect");
    
    /* test 3^2->9 */
    expectedResult = [[NSNumber alloc] initWithDouble:81.0];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonXSquared]];
    [self.calculator pushOperand:9];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Cached operation x squared 3^2->9= is incorrect");
}

- (void)testCachedBinaryOperationCache {
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;

    /* test 4*9+3=0= */
    expectedResult = [[NSNumber alloc] initWithDouble:3.0];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:9];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator pushOperand:0];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Cached 4*9+3=0= is incorrect");
    
    /* test 4*9/0=5= */
    expectedResult = [NSDecimalNumber notANumber];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:9];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:0];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator pushOperand:5];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Cached 4*9/0=5= is incorrect");

    /* test 4+3*2=1= */
    expectedResult = [[NSNumber alloc] initWithDouble:2.0];
    [self.calculator pushOperand:4];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:3];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:2];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    [self.calculator pushOperand:1];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];

    XCTAssertEqualObjects(calculatedResult, expectedResult, @"Cached 4+3*2=1= is incorrect");
}

@end
