//
//  NIBCalculatorBrain.h
//  NIBCalculator
//
//  Created by Lieu Vu on 8/17/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIBConstants.h"

@class NIBOperator;

NS_ASSUME_NONNULL_BEGIN

/// ----------------
/// @name Properties
/// ----------------

/**
 `NIBCalculatorBrain` process calculations of the calculator.
 */
@interface NIBCalculatorBrain : NSObject

/** The memory. */
@property (readonly, strong, nonatomic) NSNumber *memory;

/** The trigonometric mode for angle. */
@property (readonly, assign, nonatomic) BOOL isRadianMode;

/// ----------------------------
/// @name Interactive Operations
/// ----------------------------

/**
 Push an operand to the calculator.
 
 @param operand The operand as double number.
 */
- (void)pushOperand:(double	)operand;

/**
 Perform calculation of the operation. This method will call the method
 performOperator:withExpreimentalModeOn: with the experimental mode is NO.
 
 @param operator                The operator to calculate.
 
 @return Returns the number object if the operation can be executed sucessfully,
 otherwise `[NSDecimalNumber notANumber]`.
 */
- (NSNumber *_Nullable)performOperator:(NIBOperator *)operator;

/**
 Perform calculation of the operation.
 
 @param operator                The operator to calculate.
 @param isExperimentalModeOn    The boolean value to indicate
                                if the experimental mode is on. If the value is
                                YES, the calculation does not modify the infix
                                expression of the calculator. Otherwise, the
                                calculation modifies the infix expression.
 
 @return Returns the number object if the operation can be executed sucessfully,
 otherwise `[NSDecimalNumber notANumber]`.
 */
- (NSNumber *_Nullable)performOperator:(NIBOperator *)operator withExperimentalModeOn:(BOOL)isExperimentalModeOn;

/**
 Add a value to the memory of the calculator.
 
 @param value The value to add to the memory.
 */
- (void)addToMemory:(double)value;

/**
 Subtract a value from the memory of the calculator.
 
 @param value The value to subtract from the memory.
 */
- (void)subtractFromMemory:(double)value;

/**
 Clear the memory.
 */
- (void)clearMemory;

/**
 Clear arithmetic operations of the calculator.
 */
- (void)clearArithmetic;

/**
 Toggle radian mode of calculator. The default mode is degree.
 */
- (void)toggleRadianMode;

/**
 Get a constant number.
 
 @param operator The operation to trigger a constant.
 
 @return Returns the number object of the constant number.
 */
- (NSNumber *_Nullable)constantNumber:(NIBOperator *)operator;

/// ---------------
/// @name Utilities
/// ---------------

/**
 Check if the calculator brain is waiting for an operand in binary operation.
 */
- (BOOL)isWaitingForOperandInInfixExpression;

/**
 Check if a decimal number is an integer.
 
 @param decimalNumber The decimal nunmber to check.
 
 @return Returns YES if a decimal number is an integer, otherswise NO.
 */
+ (BOOL)isInterger:(NSNumber *)decimalNumber;

@end

NS_ASSUME_NONNULL_END
