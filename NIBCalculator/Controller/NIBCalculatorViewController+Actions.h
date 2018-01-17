//
//  NIBCalculatorViewController+Actions.h
//  NIBCalculator
//
//  Created by Lieu Vu on 11/10/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIBCalculatorViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `NIBCalculatorViewController+Actions` is a category that groups all actions
 that can be performed on the calculator.
 */
@interface NIBCalculatorViewController (Actions)

/// ----------------------------------------------
/// @name Common Actions In Portrait and Landscape
/// ----------------------------------------------

/**
 To play sound when button is touched up inside.
 */
- (void)playButtonSound;

/**
 To erase right most digits on the screen of the main display
 when swiping right on main display.
 */
- (void)swipeRightMainDisplay;

/**
 To select the main display result when trigger a gesture.
 
 @param gestureRecognizer The gesture recognizer.
 */
- (void)selectMainDisplay:(UIGestureRecognizer *)gestureRecognizer;

/**
 To deselect the main display result when trigger a gesture.
 */
- (void)deselectMainDisplay;

/**
 To clear the arithmetic operations of the calculator brain.
 */
- (void)clearArithmeticOperations;

/**
 Clear content of main displays of portrait calculator view
 and landscape calculator view.
 */
- (void)clearMainDisplays;

/**
 Toggle sign of the input number string.
 */
- (void)toggleNegativePrefix;

/**
 Handle input of digit and decimal separator buttons.
 
 @param button The button that input a digit or decimal separator.
 */
- (void)pressDigitAndDecimalSeparator:(NIBButton *)button;

/**
 Perform common unary operation in both views.
 
 @param button The button that trigger common unary operation.
 */
- (void)performUnaryOperation:(NIBButton *)button;

/**
 Perform binary operation in both views.
 
 @param button The button that trigger common unary operation.
 */
- (void)performBinaryOperation:(NIBButton *)button;

/**
 Perform equality operation in both views.
 
 @param button The button that trigger equality operation.
 */
- (void)performEqualityOperation:(NIBButton *)button;


/// -------------------------------
/// @name Actions Only In Landscape
/// -------------------------------

/**
 Perform parenthesis operation in landscape.
 
 @param button The button that trigger parenthesis operation.
 */
- (void)performParenthesisOperationCalculation:(NIBButton *)button;

/**
 Perform memory operation in landscape.
 
 @param button The button that trigger memory operation.
 */
- (void)performMemoryOperation:(NIBButton *)button;

/**
 Get a constant number (PI, Euler Number or Random number)
 in landscape.
 
 @param button The button that trigger a constant number.
 */
- (void)getConstantNumber:(NIBButton *)button;

/**
 Toogle secondary functional operation in landscape when a
 secondary functional operation toogle switch is touched up
 inside.
 
 @param button The toggle switch button.
 */
- (void)toggleSecondaryFunctionalOperations:(NIBButton *)button;

/**
 Toogle angle mode Rad <-> Deg
 
 @param button The button that trigger angle mode.
 */
- (void)toggleAngleMode:(NIBButton *)button;

@end

NS_ASSUME_NONNULL_END
