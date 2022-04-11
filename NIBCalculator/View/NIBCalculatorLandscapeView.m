//
//  NIBLandscapeCalculatorView.m
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorLandscapeView.h"
#import "UIView+Autolayout.h"
#import "NIBButtonFactory.h"
#import "NIBButton.h"
#import "NIBViewUtilities.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Constants


NSString * const NIBSecondaryDisplayDefaultText = @"";


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Constants


/** Minimum scale factor of main display text in landscape. */
static const CGFloat NIBTextMinScaleFactor = 0.5f;

/** Default font size of main display in landscape calculator view. */
static const CGFloat NIBMainDisplayDefaultFontSize = 30.0f;

/** Font size of secondary display in landscape calculator view. */
static const CGFloat NIBSecondaryDisplayFontSize = 18.0f;

/** Button large font size in landscape. */
static const CGFloat NIBButtonLargeFontSize = 35.0f;

/** Button small font size in landscape. */
static const CGFloat NIBButtonSmallFontSize = 20.0f;

/** Height multiplier of main display in landscape. */
static const CGFloat NIBMainDisplayHeightMultiplier = 0.15f;

/** Height multiplier of secondary display in landscape. */
static const CGFloat NIBSecondaryDisplayHeightMultiplier = 0.05f;

/** Width multiplier of secondary display in landscape. */
static const CGFloat NIBSecondaryDisplayWidthMultiplier = 0.1f;

/** Button border width in landscape. */
static const CGFloat NIBButtonBorderWidth = 1.5f;

/** Button border white in landscape. */
static const CGFloat NIBButtonBorderWhite = 0.4f;

/** Button border alpha in landscape. */
static const CGFloat NIBButtonBorderAlpha = 0.5f;

/** Height multiplier of button board in landscape. */
static const CGFloat NIBButtonBoardHeightMultiplier = 0.8f;

/** Multiplier of other last rows button width against the width of zero button. */
static const CGFloat NIBLastRowButtonWidthAgainstZeroButtonWidthMultipler = 0.5f;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Extension


NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorLandscapeView ()

/** Protocol proprety - NIBCalculatorViewProtocol */
@property (readwrite, strong, nonatomic) UILabel *mainDisplay;

/** Protocol proprety - NIBCalculatorViewProtocol */
@property (readwrite, assign, nonatomic) BOOL mainDisplayNeedsAdjustment;

/// -----------------------
/// @name Public Properties
/// -----------------------

@property (readwrite, strong, nonatomic) UILabel *secondaryDisplay;

/// ------------------------
/// @name Private Properties
/// ------------------------

/** A collection of buttons in landscape. */
@property (readwrite, strong, nonatomic) NSMutableArray<NIBButton *> *btns;

/** Button board in landscape. */
@property (readwrite, strong, nonatomic) UIStackView *buttonBoard;

/// ---------------------
/// @name Create Subviews
/// ---------------------

/**
 Create main display.
 */
- (void)createMainDisplay;

/**
 Create secondary display.
 */
- (void)createSecondaryDisplay;

/**
 Create button boards.
 */
- (void)createButtonBoard;

/// ---------------------
/// @name Layout Subviews
/// ---------------------

/**
 Layout main display.
 */
- (void)layoutMainDisplay;

/**
 Layout secondary display.
 */
- (void)layoutSecondaryDisplay;

/**
 Layout button board.
 */
- (void)layoutButtonBoard;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation


@implementation NIBCalculatorLandscapeView


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Protocol Properties Conformance


#pragma mark NIBCalculatorViewProtocol

//@synthesize mainDisplay = _mainDisplay;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods


#pragma mark Creating Landscape Calculator View

+ (instancetype)calculatorView
{
    NIBCalculatorLandscapeView *landscapeCalculatorView = [self autolayoutView];
    
    /* properties initialization */
    landscapeCalculatorView.mainDisplay = [UILabel autolayoutView];
    landscapeCalculatorView.secondaryDisplay = [UILabel autolayoutView];
    landscapeCalculatorView.btns = [[NSMutableArray alloc] init];
    landscapeCalculatorView.buttonBoard = [UIStackView autolayoutView];
    landscapeCalculatorView.mainDisplayNeedsAdjustment = YES;
    
    /* create main display */
    [landscapeCalculatorView createMainDisplay];
    
    /* create secondary display */
    [landscapeCalculatorView createSecondaryDisplay];
    
    /* create button board in landscape */
    [landscapeCalculatorView createButtonBoard];
    
    /* add main display, secondary display and button board to the landscape calculator */
    [landscapeCalculatorView addSubview:landscapeCalculatorView.mainDisplay];
    [landscapeCalculatorView addSubview:landscapeCalculatorView.secondaryDisplay];
    [landscapeCalculatorView addSubview:landscapeCalculatorView.buttonBoard];
    
    /* layout main display */
    [landscapeCalculatorView layoutMainDisplay];
    
    /* layout secondary display */
    [landscapeCalculatorView layoutSecondaryDisplay];
    
    /* layout button board */
    [landscapeCalculatorView layoutButtonBoard];
    
    return landscapeCalculatorView;
}

#pragma mark Toogle Switch Buttons

- (void)toggleSecondaryFunctionalButtons
{
    NSDictionary<NSNumber *, NSNumber *> *hiddenRefOfSecondRow = @{ @(NIBButtonEulerNumberPowerX) : @(NIBButtonYPowerX),
                                                                    @(NIBButtonTenPowerX) : @(NIBButtonTwoPowerX) };
    UIStackView *secondRow = self.buttonBoard.arrangedSubviews[1];
    
    NSDictionary<NSNumber *, NSNumber *> *hiddenRefOfThirdRow = @{ @(NIBButtonNaturalLogarithm) : @(NIBButtonLogarithmBaseYOfX),
                                                                   @(NIBButtonCommonLogarithm) : @(NIBButtonLogarithmBaseTwo) };
    UIStackView *thirdRow = self.buttonBoard.arrangedSubviews[2];
    
    NSDictionary<NSNumber *, NSNumber *> *hiddenRefOfFourthRow = @{ @(NIBButtonSin) : @(NIBButtonArcSin),
                                                                    @(NIBButtonCos) : @(NIBButtonArcCos),
                                                                    @(NIBButtonTan) : @(NIBButtonArcTan) };
    UIStackView *fourthRow = self.buttonBoard.arrangedSubviews[3];
    
    NSDictionary<NSNumber *, NSNumber *> *hiddenRefOfFifthRow = @{ @(NIBButtonSinh) : @(NIBButtonArcSinh),
                                                                   @(NIBButtonCosh) : @(NIBButtonArcCosh),
                                                                   @(NIBButtonTanh) : @(NIBButtonArcTanh) };
    UIStackView *fifthRow = self.buttonBoard.arrangedSubviews[4];
    
    [NIBViewUtilities toggleHiddenButtonsOfRow:secondRow basedOnReference:hiddenRefOfSecondRow];
    [NIBViewUtilities toggleHiddenButtonsOfRow:thirdRow basedOnReference:hiddenRefOfThirdRow];
    [NIBViewUtilities toggleHiddenButtonsOfRow:fourthRow basedOnReference:hiddenRefOfFourthRow];
    [NIBViewUtilities toggleHiddenButtonsOfRow:fifthRow basedOnReference:hiddenRefOfFifthRow];
}

- (void)toggleAngleMode
{
    NSDictionary<NSNumber *, NSNumber *> *hiddenRefOfFifthRow = @{ @(NIBButtonRad) : @(NIBButtonDeg) };
    UIStackView *fifthRow = self.buttonBoard.arrangedSubviews[4];
    
    [NIBViewUtilities toggleHiddenButtonsOfRow:fifthRow basedOnReference:hiddenRefOfFifthRow];
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Methods


#pragma mark Create Subviews

- (void)createMainDisplay
{
    self.mainDisplay.minimumScaleFactor = NIBTextMinScaleFactor;
    self.mainDisplay.adjustsFontSizeToFitWidth = YES;
    self.mainDisplay.textAlignment = NSTextAlignmentRight;
    self.mainDisplay.textColor = [UIColor whiteColor];
    self.mainDisplay.font = [UIFont fontWithName:NIBFontLight size:NIBMainDisplayDefaultFontSize];
    self.mainDisplay.text = NIBMainDisplayDefaultText;
}

- (void)createSecondaryDisplay
{
    self.secondaryDisplay = [UILabel autolayoutView];
    self.secondaryDisplay.minimumScaleFactor = NIBTextMinScaleFactor;
    self.secondaryDisplay.adjustsFontSizeToFitWidth = YES;
    self.secondaryDisplay.textAlignment = NSTextAlignmentCenter;
    self.secondaryDisplay.textColor = [UIColor whiteColor];
    self.secondaryDisplay.font = [UIFont fontWithName:NIBFontLight size:NIBSecondaryDisplayFontSize];
    self.secondaryDisplay.text = NIBSecondaryDisplayDefaultText;
}

- (void)createButtonBoard
{
    /* create buttons in landscape */
    [NIBButtonFactory addDigitAndDecimalSeparatorButtonsWithFont:[UIFont fontWithName:NIBFontThin size:NIBButtonLargeFontSize]
                                                       toButtons:self.btns];
    [NIBButtonFactory addArithmeticOperationButtonsWithFont:[UIFont fontWithName:NIBFontLight size:NIBButtonLargeFontSize]
                                                  toButtons:self.btns];
    [NIBButtonFactory addOtherCommonButtonsWithFont:[UIFont fontWithName:NIBFontLight size:NIBButtonSmallFontSize]
                                          toButtons:self.btns];
    [NIBButtonFactory addTextRepresentableFunctionalButtonsInLandscapeWithFont:[UIFont fontWithName:NIBFontLight size:NIBButtonSmallFontSize]
                                                                     toButtons:self.btns];
    [NIBButtonFactory addSpecialTextRepresentableFuncionalButtonsInLandscapeWithFont:[UIFont fontWithName:NIBFontLight size:NIBButtonSmallFontSize]
                                                                           toButtons:self.btns];
    
    /* set border width in landscape */
    for (NIBButton *btn in self.btns) {
        [btn setBorderWidth:NIBButtonBorderWidth borderColor:[UIColor colorWithWhite:NIBButtonBorderWhite alpha:NIBButtonBorderAlpha]];
    }
    
    /* button tags in landscape */
    NSArray *firstButtonRowTagsInLandscape = @[ @(NIBButtonOpenningParenthesis),
                                                @(NIBButtonClosingParenthesis),
                                                @(NIBButtonMemoryClear),
                                                @(NIBButtonMemoryPlus),
                                                @(NIBButtonMemoryMinus),
                                                @(NIBButtonMemoryRead),
                                                @(NIBButtonArithmeticClear),
                                                @(NIBButtonClear),
                                                @(NIBButtonSignToggle),
                                                @(NIBButtonPercentage),
                                                @(NIBButtonDivision) ];
    NSArray *secondButtonRowTagsInLandscape = @[ @(NIBButtonSecondaryFunctionalToggleSwitch),
                                                 @(NIBButtonXSquared),
                                                 @(NIBButtonXCubed),
                                                 @(NIBButtonXPowerY),
                                                 @(NIBButtonEulerNumberPowerX),
                                                 @(NIBButtonTenPowerX),
                                                 @(NIBButtonYPowerX),
                                                 @(NIBButtonTwoPowerX),
                                                 @(NIBButtonSeven),
                                                 @(NIBButtonEight),
                                                 @(NIBButtonNine),
                                                 @(NIBButtonMultiplication) ];
    NSArray *thirdButtonRowTagsInLandscape = @[ @(NIBButtonOneOverX),
                                                @(NIBButtonSquareRootOfX),
                                                @(NIBButtonCubicRootOfX),
                                                @(NIBButtonYthRootOfX),
                                                @(NIBButtonNaturalLogarithm),
                                                @(NIBButtonLogarithmBaseYOfX),
                                                @(NIBButtonCommonLogarithm),
                                                @(NIBButtonLogarithmBaseTwo),
                                                @(NIBButtonFour),
                                                @(NIBButtonFive),
                                                @(NIBButtonSix),
                                                @(NIBButtonSubstraction) ];
    NSArray *fourthButtonRowTagsInLandscape = @[ @(NIBButtonXFactorial),
                                                 @(NIBButtonSin),
                                                 @(NIBButtonCos),
                                                 @(NIBButtonTan),
                                                 @(NIBButtonArcSin),
                                                 @(NIBButtonArcCos),
                                                 @(NIBButtonArcTan),
                                                 @(NIBButtonEulerNumber),
                                                 @(NIBButtonEE),
                                                 @(NIBButtonOne),
                                                 @(NIBButtonTwo),
                                                 @(NIBButtonThree),
                                                 @(NIBButtonAddition) ];
    NSArray *fifthButtonRowTagsInLandscape = @[ @(NIBButtonRad),
                                                @(NIBButtonDeg),
                                                @(NIBButtonSinh),
                                                @(NIBButtonCosh),
                                                @(NIBButtonTanh),
                                                @(NIBButtonArcSinh),
                                                @(NIBButtonArcCosh),
                                                @(NIBButtonArcTanh),
                                                @(NIBButtonPi),
                                                @(NIBButtonRand),
                                                @(NIBButtonZero),
                                                @(NIBButtonDecimalSeparator),
                                                @(NIBButtonEquality) ];
    
    NSArray *buttonRowsTagsInLandscape = @[ firstButtonRowTagsInLandscape,
                                            secondButtonRowTagsInLandscape,
                                            thirdButtonRowTagsInLandscape,
                                            fourthButtonRowTagsInLandscape,
                                            fifthButtonRowTagsInLandscape ];
    
    for (NSUInteger i = 0; i < buttonRowsTagsInLandscape.count; i++) {
        UIStackView *row = [UIStackView autolayoutView];
        
        for (NSNumber *buttonTag in buttonRowsTagsInLandscape[i]) {
            NIBButton *btn = [NIBViewUtilities buttonWithTag:buttonTag.integerValue fromButtons:self.btns];
            
            if (btn) {
                [row addArrangedSubview:btn];
            }
        }
        
        /* if last row */
        if (i == buttonRowsTagsInLandscape.count-1) {
            /* layout last row */
            row.distribution = UIStackViewDistributionFill;
            row.alignment = UIStackViewAlignmentFill;
        } else {
            /* lay out other rows */
            row.distribution = UIStackViewDistributionFillEqually;
            row.alignment = UIStackViewAlignmentFill;
        }
        
        [self.buttonBoard addArrangedSubview:row];
    }
    
}

#pragma mark Layout Subviews

- (void)layoutMainDisplay
{
    [[self.mainDisplay.leadingAnchor constraintEqualToAnchor:self.secondaryDisplay.trailingAnchor] setActive:YES];
    [[self.mainDisplay.bottomAnchor constraintEqualToAnchor:self.buttonBoard.topAnchor] setActive:YES];
    [[self.mainDisplay.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-NIBMainDisplayMargin] setActive:YES];
    [[self.mainDisplay.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:NIBMainDisplayHeightMultiplier] setActive:YES];
}

- (void)layoutSecondaryDisplay
{
    [[self.secondaryDisplay.leadingAnchor constraintEqualToAnchor:self.leadingAnchor] setActive:YES];
    [[self.secondaryDisplay.bottomAnchor constraintEqualToAnchor:self.mainDisplay.bottomAnchor] setActive:YES];
    [[self.secondaryDisplay.heightAnchor constraintEqualToAnchor:self.heightAnchor
                                                      multiplier:NIBSecondaryDisplayHeightMultiplier] setActive:YES];
    [[self.secondaryDisplay.widthAnchor constraintEqualToAnchor:self.widthAnchor
                                                     multiplier:NIBSecondaryDisplayWidthMultiplier] setActive:YES];
}

- (void)layoutButtonBoard
{
    /* general layout of button rows in button board */
    self.buttonBoard.axis = UILayoutConstraintAxisVertical;
    self.buttonBoard.alignment = UIStackViewAlignmentFill;
    self.buttonBoard.distribution = UIStackViewDistributionFillEqually;
    
    /* layout of other buttons on last row with width=zeroButton.width*0.5 */
    NIBButton *zeroBtn = [NIBViewUtilities buttonWithTag:NIBButtonZero fromButtons:self.btns];
    NSArray *buttonTagsInLastRow = @[ @(NIBButtonRad),
                                      @(NIBButtonDeg),
                                      @(NIBButtonSinh),
                                      @(NIBButtonCosh),
                                      @(NIBButtonTanh),
                                      @(NIBButtonPi),
                                      @(NIBButtonRand),
                                      @(NIBButtonDecimalSeparator),
                                      @(NIBButtonEquality),
                                      @(NIBButtonArcSinh),
                                      @(NIBButtonArcCosh),
                                      @(NIBButtonArcTanh) ];
    
    NSArray *conflictConstraintsButtonTags = @[ @(NIBButtonRad),
                                                @(NIBButtonDeg),
                                                @(NIBButtonSinh),
                                                @(NIBButtonCosh),
                                                @(NIBButtonTanh),
                                                @(NIBButtonArcSinh),
                                                @(NIBButtonArcCosh),
                                                @(NIBButtonArcTanh) ];
    
    /* layout of other buttons in the last row */
    for (NSNumber *tag in buttonTagsInLastRow) {
        NIBButton *btn = [NIBViewUtilities buttonWithTag:tag.integerValue fromButtons:self.btns];
        if ([conflictConstraintsButtonTags containsObject:tag]) {
            NSLayoutConstraint *constraint = [btn.widthAnchor constraintEqualToAnchor:zeroBtn.widthAnchor
                                                                           multiplier:NIBLastRowButtonWidthAgainstZeroButtonWidthMultipler];
            constraint.priority = 999;
            constraint.active = YES;
        } else {
            [[btn.widthAnchor constraintEqualToAnchor:zeroBtn.widthAnchor
                                           multiplier:NIBLastRowButtonWidthAgainstZeroButtonWidthMultipler] setActive:YES];
        }
    }
    
    /* hide secondary functional buttons and clear buttons when initialization */
    NSArray *hiddenButtonTagsWhenInitialization = @[ @(NIBButtonClear),
                                                     @(NIBButtonYPowerX),
                                                     @(NIBButtonTwoPowerX),
                                                     @(NIBButtonLogarithmBaseYOfX),
                                                     @(NIBButtonLogarithmBaseTwo),
                                                     @(NIBButtonArcSin),
                                                     @(NIBButtonArcCos),
                                                     @(NIBButtonArcTan),
                                                     @(NIBButtonArcSinh),
                                                     @(NIBButtonArcCosh),
                                                     @(NIBButtonArcTanh),
                                                     @(NIBButtonDeg)];
    
    for (NSNumber *buttonTag in hiddenButtonTagsWhenInitialization) {
        NIBButton *btn = [NIBViewUtilities buttonWithTag:buttonTag.integerValue fromButtons:self.btns];
        btn.hidden = YES;
    }
    
    /* layout of button board on the landscape calculator */
    [[self.buttonBoard.leadingAnchor constraintEqualToAnchor:self.leadingAnchor] setActive:YES];
    [[self.buttonBoard.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
    [[self.buttonBoard.trailingAnchor constraintEqualToAnchor:self.trailingAnchor] setActive:YES];
    [[self.buttonBoard.heightAnchor constraintEqualToAnchor:self.heightAnchor
                                                 multiplier:NIBButtonBoardHeightMultiplier] setActive:YES];
    
    
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Protocols


#pragma mark NIBCalculatorViewProtocol

- (void)setMainDisplayAdjustment
{
    self.mainDisplayNeedsAdjustment = NO;
}

- (void)toggleArithmeticClearButtonOrClearButton
{
    NSDictionary<NSNumber *, NSNumber *> *hiddenRefOfFirstRow = @{ @(NIBButtonArithmeticClear) : @(NIBButtonClear) };
    UIStackView *firstRow = self.buttonBoard.arrangedSubviews[0];
    
    [NIBViewUtilities toggleHiddenButtonsOfRow:firstRow basedOnReference:hiddenRefOfFirstRow];
}

- (NSArray<NIBButton *> *)buttons
{
    return [self.btns copy];
}

@end
