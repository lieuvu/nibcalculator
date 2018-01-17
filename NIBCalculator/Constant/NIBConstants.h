//
//  NIBConstants.h
//  NIBCalculator
//
//  Created by Lieu Vu on 8/17/17.
//  Copyright © 2017 LV. All rights reserved.
//

/**
 `NIBContants` contain global constants of the application.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

/** Button tags of the calculator */
typedef NS_ENUM(NSInteger, NIBButtonTag) {
    /** Button number zero. */
    NIBButtonZero,
    /** Button number one. */
    NIBButtonOne,
    /** Button number two. */
    NIBButtonTwo,
    /** Button number three. */
    NIBButtonThree,
    /** Button number four. */
    NIBButtonFour,
    /** Button number five. */
    NIBButtonFive,
    /** Button number six. */
    NIBButtonSix,
    /** Button number seven. */
    NIBButtonSeven,
    /** Button number eight. */
    NIBButtonEight,
    /** Button number nine. */
    NIBButtonNine,
    /** Button decimal separator. */
    NIBButtonDecimalSeparator,
    /** Button addition */
    NIBButtonAddition,
    /** Button substraction. */
    NIBButtonSubstraction,
    /** Button mulitplication. */
    NIBButtonMultiplication,
    /** Button division. */
    NIBButtonDivision,
    /** Button equality. */
    NIBButtonEquality,
    /** Button arithmetic clear. */
    NIBButtonArithmeticClear,
    /** Button clear. */
    NIBButtonClear,
    /** Button sign toggle. */
    NIBButtonSignToggle,
    /** Button percentage. */
    NIBButtonPercentage,
    /** Button openning parenthesis. */
    NIBButtonOpenningParenthesis,
    /** Button closing parenthesis. */
    NIBButtonClosingParenthesis,
    /** Button memory clear. */
    NIBButtonMemoryClear,
    /** Button memory plus. */
    NIBButtonMemoryPlus,
    /** Button memory minus. */
    NIBButtonMemoryMinus,
    /** Button memory read. */
    NIBButtonMemoryRead,
    /** Button secondary functional toogle. */
    NIBButtonSecondaryFunctionalToggleSwitch,
    /** Button x^2. */
    NIBButtonXSquared,
    /** Button x^3. */
    NIBButtonXCubed,
    /** Button x^y. */
    NIBButtonXPowerY,
    /** Button e^x. */
    NIBButtonEulerNumberPowerX,
    /** Button y^x. */
    NIBButtonYPowerX,
    /** Button 10^x. */
    NIBButtonTenPowerX,
    /** Button 2^x. */
    NIBButtonTwoPowerX,
    /** Button 1/x. */
    NIBButtonOneOverX,
    /** Button sqrt(x). */
    NIBButtonSquareRootOfX,
    /** Button cbrt(x). */
    NIBButtonCubicRootOfX,
    /** Button yth root of x. */
    NIBButtonYthRootOfX,
    /** Button ln. */
    NIBButtonNaturalLogarithm,
    /** Button logy(x). */
    NIBButtonLogarithmBaseYOfX,
    /** Button log10. */
    NIBButtonCommonLogarithm,
    /** Button log2. */
    NIBButtonLogarithmBaseTwo,
    /** Button x!. */
    NIBButtonXFactorial,
    /** Button trignometric function sine. */
    NIBButtonSin,
    /** Button trignometric function cosine. */
    NIBButtonCos,
    /** Button trignometric function tangent. */
    NIBButtonTan,
    /** Button inverse trigonometric functions arcsine. */
    NIBButtonArcSin,
    /** Button inverse trigonometric functions arccosine. */
    NIBButtonArcCos,
    /** Button inverse trigonometric functions arctangent. */
    NIBButtonArcTan,
    /** Button hyperbolic functions sine. */
    NIBButtonSinh,
    /** Button hyperbolic functions cosine. */
    NIBButtonCosh,
    /** Button hyperbolic functions tangent. */
    NIBButtonTanh,
    /** Button inverse hyperbolic functions sine. */
    NIBButtonArcSinh,
    /** Button inverse hyperbolic functions cosine. */
    NIBButtonArcCosh,
    /** Button inverse hyperbolic functions tangent. */
    NIBButtonArcTanh,
    /** Button pi constant. */
    NIBButtonPi,
    /** Button e constant. */
    NIBButtonEulerNumber,
    /** Button random number constant. */
    NIBButtonRand,
    /** Button to enter exponent of scientifc notation. */
    NIBButtonEE,
    /** Button to turn on radian mode. */
    NIBButtonRad,
    /** Button to turn on degree mode. */
    NIBButtonDeg
};

/// ----------------------
/// @name Common Constants
/// ----------------------

/** Margin of main display. */
FOUNDATION_EXPORT const CGFloat NIBMainDisplayMargin;

/** Default string on main display. */
FOUNDATION_EXPORT NSString *_Nonnull const NIBMainDisplayDefaultText;

/** Default string on main display. */
FOUNDATION_EXPORT NSString *_Nonnull const NIBMainDisplayErrorText;

/** The font thin for button. */
FOUNDATION_EXPORT NSString *_Nonnull const NIBFontThin;

/** The font light for button. */
FOUNDATION_EXPORT NSString *_Nonnull const NIBFontLight;


