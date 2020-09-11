//
//  NIBCalculatorLocalizationTests.m
//  NIBCalculatorTests
//
//  Created by Lieu Vu on 9/29/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NIBOperator.h"
#import "NIBCalculatorBrain.h"
#import "NIBConstants.h"

#pragma mark - Testing Class Category To Expose Private Methods

@interface NIBCalculatorBrain (Testing)

@property (readwrite, strong, nonatomic) NSLocale *locale;

@end

#pragma mark -

@interface NIBCalculatorLocalizationTests : XCTestCase

@property (readwrite, strong, nonatomic) NIBCalculatorBrain *calculator;

@end

#pragma mark -

@implementation NIBCalculatorLocalizationTests

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

- (void)testLocalization
{
    NSNumber *expectedResult = nil;
    NSNumber *calculatedResult = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fi_FI"];
    
    /* test division -4,6/2.2= */
    expectedResult = [[NSNumber alloc] initWithDouble:-4.6/2.2];
    [self.calculator pushOperand:[[formatter numberFromString:@"-4,6"] doubleValue]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonDivision]];
    [self.calculator pushOperand:[[formatter numberFromString:@"2,2"] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The division ”-4,6/2.2=” is incorrect!");
    
    /* test multiplication 4,3*5.3= */
    expectedResult = [[NSNumber alloc] initWithDouble:4.3*5.3];
    [self.calculator pushOperand:[[formatter numberFromString:@"4,3"] doubleValue]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonMultiplication]];
    [self.calculator pushOperand:[[formatter numberFromString:@"5,3"] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The multiplication ”4,3*5=” is incorrect!");
    
    /* test subtraction 3,4-2,1= */
    expectedResult = [[NSNumber alloc] initWithDouble:3.4-2.1];
    [self.calculator pushOperand:[[formatter numberFromString:@"3,4"] doubleValue]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonSubstraction]];
    [self.calculator pushOperand:[[formatter numberFromString:@"2,1"] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The substraction ”3,4-2,1=” is incorrect!");
    
    /* test addition -3,3+2,5= */
    expectedResult = [[NSNumber alloc] initWithDouble:-3.3+2.5];
    [self.calculator pushOperand:[[formatter numberFromString:@"-3,3"] doubleValue]];
    [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonAddition]];
    [self.calculator pushOperand:[[formatter numberFromString:@"2,5"] doubleValue]];
    calculatedResult = [self.calculator performOperator:[NIBOperator operatorWithTag:NIBButtonEquality]];
    
    XCTAssertEqualObjects(calculatedResult, expectedResult, @"The addition ”-3,3+2,5=” is incorrect!");
}

@end
