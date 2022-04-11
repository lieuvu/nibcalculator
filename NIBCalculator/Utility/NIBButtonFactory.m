//
//  NIBButtonFactory.m
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBButtonFactory.h"
#import "NIBButton.h"

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Constants


/** Grayscale value for other buttons. */
static const CGFloat NIBButtonOthersWhite = 0.70f;

/** Grayscale value for digits and decimal buttons. */
static const CGFloat NIBButtonDigitsAndDecimalWhite = 0.75f;

/** Grayscale value for digits and decimal buttons. */
static const CGFloat NIBButtonWhiteHighlighted = 0.65f;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation


@implementation NIBButtonFactory

+ (void)addDigitAndDecimalSeparatorButtonsWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons
{
    NSString *decimalSeparator = [[NSLocale currentLocale] decimalSeparator];
    
    NSDictionary *digitAndDecmialButtons = @{ @"0" : @(NIBButtonZero),
                                              @"1" : @(NIBButtonOne),
                                              @"2" : @(NIBButtonTwo),
                                              @"3" : @(NIBButtonThree),
                                              @"4" : @(NIBButtonFour),
                                              @"5" : @(NIBButtonFive),
                                              @"6" : @(NIBButtonSix),
                                              @"7" : @(NIBButtonSeven),
                                              @"8" : @(NIBButtonEight),
                                              @"9" : @(NIBButtonNine),
                                              decimalSeparator : @(NIBButtonDecimalSeparator) };
    
    /* digit and decimal buttons */
    for (NSString *buttonTitle in digitAndDecmialButtons) {
        NIBButton *btn = [[NIBButton alloc] initWithLabelTitle:buttonTitle
                                                          font:font
                                                           tag:[digitAndDecmialButtons[buttonTitle] integerValue]];
        [btn setBackground:[UIColor colorWithWhite:NIBButtonDigitsAndDecimalWhite alpha:1.0]
                highlightedBackground:[UIColor colorWithWhite:NIBButtonWhiteHighlighted alpha:1.0]];
        [buttons addObject:btn];
    }
}

+(void)addArithmeticOperationButtonsWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons 
{
    NSDictionary *mainOperatorButtons = @{ @"÷" : @(NIBButtonDivision),
                                           @"×" : @(NIBButtonMultiplication),
                                           @"−" : @(NIBButtonSubstraction),
                                           @"+" : @(NIBButtonAddition),
                                           @"=" : @(NIBButtonEquality) };
    
    /* main operator buttons */
    for (NSString *buttonTitle in mainOperatorButtons) {
        NIBButton *btn = [[NIBButton alloc] initWithLabelTitle:buttonTitle
                                                          font:font
                                                           tag:[mainOperatorButtons[buttonTitle] integerValue] ];
        [btn setBackground:[UIColor orangeColor]
                highlightedBackground:[UIColor colorWithRed:(CGFloat)214.0/255
                                                      green:(CGFloat)106.0/255
                                                       blue:0 alpha:1.0]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttons addObject:btn];
    }
}

+ (void) addOtherCommonButtonsWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons
{
    NSDictionary *mainButtons =
        @{ @"AC"    : @(NIBButtonArithmeticClear),
           @"C"     : @(NIBButtonClear),
           @"+/-"   : @(NIBButtonSignToggle),
           @"%"     : @(NIBButtonPercentage) };
    
    /* main buttons */
    for (NSString *buttonTitle in mainButtons) {
        NIBButton *btn = [[NIBButton alloc] initWithLabelTitle:buttonTitle font:font tag:[mainButtons[buttonTitle]  integerValue]];
        [btn setBackground:[UIColor colorWithWhite:NIBButtonOthersWhite alpha:1.0]
                highlightedBackground:[UIColor colorWithWhite:NIBButtonWhiteHighlighted alpha:1.0]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttons addObject:btn];
    }
}

+ (void)addTextRepresentableFunctionalButtonsInLandscapeWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons
{
    NSDictionary *textRepresentableFunctionalButtons =
        @{ @"("     : @(NIBButtonOpenningParenthesis),
           @")"     : @(NIBButtonClosingParenthesis),
           @"mc"    : @(NIBButtonMemoryClear),
           @"m+"    : @(NIBButtonMemoryPlus),
           @"m-"    : @(NIBButtonMemoryMinus),
           @"mr"    : @(NIBButtonMemoryRead),
           @"ln"    : @(NIBButtonNaturalLogarithm),
           @"x!"    : @(NIBButtonXFactorial),
           @"sin"   : @(NIBButtonSin),
           @"cos"   : @(NIBButtonCos),
           @"tan"   : @(NIBButtonTan),
           @"e"     : @(NIBButtonEulerNumber),
           @"EE"    : @(NIBButtonEE),
           @"Rad"   : @(NIBButtonRad),
           @"Deg"   : @(NIBButtonDeg),
           @"sinh"  : @(NIBButtonSinh),
           @"cosh"  : @(NIBButtonCosh),
           @"tanh"  : @(NIBButtonTanh),
           @"π"     : @(NIBButtonPi),
           @"Rand"  : @(NIBButtonRand) };
    
    /* text representable buttons in landscape */
    for (NSString *buttonTitle in textRepresentableFunctionalButtons) {
        NIBButton *btn = [[NIBButton alloc] initWithLabelTitle:buttonTitle
                                                          font:font
                                                           tag:[textRepresentableFunctionalButtons[buttonTitle] integerValue]];
        [btn setBackground:[UIColor colorWithWhite:NIBButtonOthersWhite alpha:1.0]
                highlightedBackground:[UIColor colorWithWhite:NIBButtonWhiteHighlighted alpha:1.0]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttons addObject:btn];
    }
}

+ (void)addSpecialTextRepresentableFuncionalButtonsInLandscapeWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons 
{
    NSMutableArray *tempButtons = [[NSMutableArray alloc] init];
    
    /* 2nd (secondary functional) button */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"2"
                                                            font:font
                                                       extraPart:@"nd"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonSecondaryFunctionalToggleSwitch]];
    
    /* x squared */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"x"
                                                            font:font
                                                       extraPart:@"2"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonXSquared]];
    
    /* x cubed */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"x"
                                                            font:font
                                                       extraPart:@"3"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonXCubed]];
    
    /* x power y */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"x"
                                                            font:font
                                                       extraPart:@"y"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonXPowerY]];
    
    /* e power x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"e"
                                                            font:font
                                                       extraPart:@"x"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonEulerNumberPowerX]];
    
    /* y power x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"y"
                                                            font:font
                                                       extraPart:@"x"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonYPowerX]];
    
    /* 10 power x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"10"
                                                            font:font
                                                       extraPart:@"x"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonTenPowerX]];
    
    /* 2 power x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"2"
                                                            font:font
                                                       extraPart:@"x"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonTwoPowerX]];
    
    /* logarithm base y of x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"log"
                                                            font:font
                                                       extraPart:@"y"
                                                            type:NIBButtonTypeSubscript
                                                             tag:NIBButtonLogarithmBaseYOfX]];
    
    /* common logarithm */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"log"
                                                            font:font
                                                       extraPart:@"10"
                                                            type:NIBButtonTypeSubscript
                                                             tag:NIBButtonCommonLogarithm]];
    
    /* logarithm of base 2 */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"log"
                                                            font:font
                                                       extraPart:@"2"
                                                            type:NIBButtonTypeSubscript
                                                             tag:NIBButtonLogarithmBaseTwo]];
    
    /* square root of x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"x"
                                                            font:font
                                                            root:@"2"
                                                             tag:NIBButtonSquareRootOfX]];
    
    /* cubic root of x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"x"
                                                            font:font
                                                            root:@"3"
                                                             tag:NIBButtonCubicRootOfX]];
    
    /* yth root of x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"x"
                                                            font:font
                                                            root:@"y"
                                                             tag:NIBButtonYthRootOfX]];
    
    /* 1 over x */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitleAsDenominator:@"x"
                                                                         font:font
                                                                    numerator:@"1"
                                                                          tag:NIBButtonOneOverX]];
    
    /* arcsin */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"sin"
                                                            font:font
                                                       extraPart:@"-1"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonArcSin]];
    
    /* arccos */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"cos"
                                                            font:font
                                                       extraPart:@"-1"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonArcCos]];
    
    /* arcsin */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"tan"
                                                            font:font extraPart:@"-1"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonArcTan]];
    
    /* arcsinh */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"sinh"
                                                            font:font
                                                       extraPart:@"-1"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonArcSinh]];
    
    /* arccosh */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"cosh"
                                                            font:font
                                                       extraPart:@"-1"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonArcCosh]];
    
    /* arctanh */
    [tempButtons addObject:[[NIBButton alloc] initWithLabelTitle:@"tanh"
                                                            font:font
                                                       extraPart:@"-1"
                                                            type:NIBButtonTypeSuperscript
                                                             tag:NIBButtonArcTanh]];
    
    /* background color of functional buttons */
    for (NIBButton *btn in tempButtons) {
        [btn setBackground:[UIColor colorWithWhite:NIBButtonOthersWhite alpha:1.0]
                highlightedBackground:[UIColor colorWithWhite:NIBButtonWhiteHighlighted alpha:1.0]];
    }
    
    [buttons addObjectsFromArray:tempButtons];
}

@end
