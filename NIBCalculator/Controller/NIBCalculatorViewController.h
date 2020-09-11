//
//  CalculatorViewController.h
//  NIBCalculator
//
//  Created by Lieu Vu on 8/16/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "NIBCalculatorViewProtocol.h"

@class NIBCalculatorPortraitView;
@class NIBCalculatorLandscapeView;
@class NIBCalculatorBrain;
@class NIBSelectionLabel;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Constants


/** Max characters of number string in portrait. */
FOUNDATION_EXPORT const NSUInteger NIBMaxDigitsInPortrait;

/** Max characters of number string in landscape. */
FOUNDATION_EXPORT const NSUInteger NIBMaxDigitsInLandscape;

/** Minimum negative number can be displayed fully in portrait. */
FOUNDATION_EXPORT const double NIBMinFullDisplayableNegativeIntegerInPortrait;

/** Maximum positive number can be displayed fully in portrait. */
FOUNDATION_EXPORT const double NIBMaxFullDisplayablePositiveIntegerInPortrait;

/** Minimum negative number can be displayed in landscape. */
FOUNDATION_EXPORT const double NIBMinFullDisplayableNegativeIntegerInLandscape;

/** Maximum positive number can be displayed in landscape. */
FOUNDATION_EXPORT const double NIBMaxFullDisplayablePositiveIntegerInLandscape;

/** Exponent symbol used in the calculator. */
FOUNDATION_EXPORT NSString *_Nonnull const NIBExponentSymbol;

/** Negative prefix used in the calculator. */
FOUNDATION_EXPORT NSString *_Nonnull const NIBNegativePrefix;


/////////////////////////////////////////////////////////////////////////////
#pragma mark -


NS_ASSUME_NONNULL_BEGIN

/**
 `NIBCalculatorViewController` is a main controller of the application. It has
 the following categories:
 
 - `NIBCalculatorViewController(Helpers)`
 - `NIBCalculatorViewController(Actions)`
 - `NIBCalculatorViewController(UpdateDisplay)`
 - `NIBCalculatorViewController(Store)`
 */
@interface NIBCalculatorViewController : UIViewController

/// ----------------
/// @name Properties
/// ----------------

/** Portrait calculator view. */
@property (readonly, strong, nonatomic) NIBCalculatorPortraitView *portraitCalculatorView;

/** Landscape calculator view. */
@property (readonly, strong, nonatomic) NIBCalculatorLandscapeView *landscapeCalculatorView;

/** Current calculator view - either portrait view or landscape view. */
@property (readonly, strong, nonatomic) UIView<NIBCalculatorViewProtocol> *currentCalculatorView;

/** The calculator brain. */
@property (readonly, strong, nonatomic) NIBCalculatorBrain *calculator;

/** Button sound. */
@property (readonly, assign, nonatomic) SystemSoundID btnSound;

/** Boolean value indicating if the main display shows result from operation. */
@property (readonly, getter=isResultDisplayed, assign, nonatomic) BOOL resultDisplayed;

/** Boolean value indicating if the main display is selected. */
@property (readonly, getter=isMainDisplaySelected, assign, nonatomic) BOOL mainDisplaySelected;

/** Label used to indicate the selected views. */
@property (readonly, strong, nonatomic) NIBSelectionLabel *selectionLabel;

/** Current binary operation. */
@property (readonly, strong, nonatomic) NIBButton *_Nullable currentBinaryOperation;

/** Boolean value indicating if a binary operator can push and operand. */
@property (readonly, assign, nonatomic) BOOL canBinaryOperatorPushOperand;

@end

NS_ASSUME_NONNULL_END
