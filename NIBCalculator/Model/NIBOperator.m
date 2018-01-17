//
//  NIBOperation.m
//  NIBCalculator
//
//  Created by Lieu Vu on 10/21/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBOperator.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Variables


/** Class variable  binary operators. */
static NSSet<NSNumber *> *binaryOperators;

/** Class variable parenthesis operators. */
static NSSet<NSNumber *> *parenthesisOperators;

/** Class variable operator description. */
static NSDictionary<NSNumber *, NSString *> *operatorDescriptions;

/** The precedence of operator precedence. */
static NSDictionary<NSNumber *, NSNumber *> *operatorPrecedence;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Extension


NS_ASSUME_NONNULL_BEGIN

@interface NIBOperator ()

@property (readwrite, assign, nonatomic) NSInteger idx;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation


@implementation NIBOperator

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods

#pragma mark Initialize

+ (void)initialize
{
    if (self == [NIBOperator class]) {
        binaryOperators = [[NSSet alloc] initWithArray:@[@(NIBButtonDivision),
                                                         @(NIBButtonMultiplication),
                                                         @(NIBButtonSubstraction),
                                                         @(NIBButtonAddition),
                                                         @(NIBButtonYthRootOfX),
                                                         @(NIBButtonXPowerY),
                                                         @(NIBButtonYPowerX),
                                                         @(NIBButtonLogarithmBaseYOfX),
                                                         @(NIBButtonEE)]];
        
        parenthesisOperators = [[NSSet alloc] initWithArray:@[@(NIBButtonOpenningParenthesis),
                                                              @(NIBButtonClosingParenthesis)]];
        
        operatorDescriptions = @{ @(NIBButtonDivision) : @"/",
                                  @(NIBButtonMultiplication) : @"x",
                                  @(NIBButtonSubstraction) : @"-",
                                  @(NIBButtonAddition) : @"+",
                                  @(NIBButtonEquality) : @"=",
                                  @(NIBButtonPercentage) : @"%",
                                  @(NIBButtonOpenningParenthesis) : @"(",
                                  @(NIBButtonClosingParenthesis) : @")",
                                  @(NIBButtonXSquared) : @"^2",
                                  @(NIBButtonXCubed) : @"^3",
                                  @(NIBButtonXPowerY) : @"^",
                                  @(NIBButtonYPowerX) : @"^",
                                  @(NIBButtonTwoPowerX) : @"2^",
                                  @(NIBButtonEulerNumberPowerX) : @"e^",
                                  @(NIBButtonTenPowerX) : @"10^",
                                  @(NIBButtonOneOverX) : @"1/",
                                  @(NIBButtonSquareRootOfX) : @"sqrt",
                                  @(NIBButtonCubicRootOfX) : @"cbrt",
                                  @(NIBButtonYthRootOfX) : @"root",
                                  @(NIBButtonNaturalLogarithm) : @"ln",
                                  @(NIBButtonCommonLogarithm) : @"log10",
                                  @(NIBButtonLogarithmBaseYOfX) : @"log",
                                  @(NIBButtonLogarithmBaseTwo) : @"log2",
                                  @(NIBButtonXFactorial) : @"!",
                                  @(NIBButtonSin) : @"sin",
                                  @(NIBButtonCos) : @"cos",
                                  @(NIBButtonTan) : @"tan",
                                  @(NIBButtonArcSin) : @"arcsin",
                                  @(NIBButtonArcCos) : @"arccos",
                                  @(NIBButtonArcTan) : @"arctan",
                                  @(NIBButtonEE) : @"x10^",
                                  @(NIBButtonSinh) : @"sinh",
                                  @(NIBButtonCosh) : @"cosh",
                                  @(NIBButtonTanh) : @"tanh",
                                  @(NIBButtonArcSinh) : @"arcsinh",
                                  @(NIBButtonArcCosh) : @"arccosh",
                                  @(NIBButtonArcTanh) : @"arctanh" };
        
        operatorPrecedence = @{ @(NIBButtonAddition) : @(1),
                                @(NIBButtonSubstraction) : @(1),
                                @(NIBButtonDivision) : @(2),
                                @(NIBButtonMultiplication) : @(2),
                                @(NIBButtonXPowerY) : @(3),
                                @(NIBButtonYPowerX) : @(3),
                                @(NIBButtonYthRootOfX) : @(3),
                                @(NIBButtonLogarithmBaseYOfX) : @(3),
                                @(NIBButtonEE) : @(3) };
    }
}

#pragma mark Create An Operator

+ (instancetype)operatorWithTag:(NSInteger)tag
{
    NIBOperator *operation = [[self alloc] init];
    
    if (operation) {
        operation.idx = tag;
    }
    
    return operation;
}

#pragma mark Utilities

- (BOOL)isOpeningParanthesis
{
    return self.idx == NIBButtonOpenningParenthesis;
}

- (BOOL)isClosingParanthesis
{
    return self.idx == NIBButtonClosingParenthesis;
}

- (BOOL)isParanthesis
{
    return [self isOpeningParanthesis] || [self isClosingParanthesis];
}

- (BOOL)isUnaryOperator
{
    return [binaryOperators containsObject:@(self.idx)] || [parenthesisOperators containsObject:@(self.idx)] ? NO : YES;
}

- (BOOL)isBinaryOperator
{
    return [binaryOperators containsObject:@(self.idx)] ? YES : NO;
}

- (NSComparisonResult)comparePriorityWithOperator:(NIBOperator *)aOperator
{
    NSComparisonResult result;
    
    if (operatorPrecedence[@(self.idx)].integerValue < operatorPrecedence[@(aOperator.idx)].integerValue) {
        result = NSOrderedAscending;
    } else if (operatorPrecedence[@(self.idx)].integerValue > operatorPrecedence[@(aOperator.idx)].integerValue) {
        result = NSOrderedDescending;
    } else {
        result = NSOrderedSame;
    }
    
    return result;
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject


- (NSString *)description
{
    return operatorDescriptions[@(self.idx)];
}

//- (BOOL)isEqual:(id)object
//{
//    if (self == object) {
//        return YES;
//    }
//
//    if (![object isKindOfClass:[NIBOperator class]]) {
//        return NO;
//    }
//
//    return [(NIBOperator *)object idx] == self.idx;
//}
//
//- (NSUInteger)hash
//{
//    return (NSUInteger)self.idx;
//}

@end
