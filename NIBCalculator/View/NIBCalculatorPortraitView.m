//
//  NIBPortraitCalculatorView.m
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorPortraitView.h"
#import "UIView+Autolayout.h"
#import "NIBButtonFactory.h"
#import "NIBButton.h"
#import "NIBViewUtilities.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Constants


/** Minimum scale factor of main display text in portrait. */
static const CGFloat NIBLabelTextMinScaleFactor = 0.5f;

/** Default font size of main display in portrait. */
static const CGFloat NIBMainDisplayDefaultFontSize = 50.0f;

/** Button large font size in portrait. */
static const CGFloat NIBButtonLargeFontSize = 50.0f;

/** Button small font size in portrait. */
static const CGFloat NIBButtonMediumFontSize = 40.0f;

/** Button small font size in portrait. */
static const CGFloat NIBButtonSmallFontSize = 35.0f;

/** Button border width in portrait */
static const CGFloat NIBButtonBorderWidth = 2.0f;

/** Button border white in portrait */
static const CGFloat NIBButtonBorderWhite = 0.4f;

/** Button border alpha in portrait */
static const CGFloat NIBButtonBorderAlpha = 0.5f;

/** Height multiplier of main display in portrait. */
static const CGFloat NIBMainDisplayHeightMultiplier = 0.2f;

/* Ratio of height/width multiplier of zero button in portrait. */
static const CGFloat NIBButtonBoardZeroButtonHeightOverWidthRatioMultiplier = 0.5f;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Extension


NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorPortraitView ()

/** Protocol proprety - NIBCalculatorViewProtocol */
@property (readwrite, strong, nonatomic) UILabel *mainDisplay;

/** Protocol proprety - NIBCalculatorViewProtocol */
@property (readwrite, assign, nonatomic) BOOL mainDisplayNeedsAdjustment;

/// ------------------------
/// @name Private Properties
/// ------------------------

/** A collection of buttons in portrait. */
@property (readwrite, strong, nonatomic) NSMutableArray<NIBButton *> *btns;

/** Button board in portrait. */
@property (readwrite, strong, nonatomic) UIStackView *buttonBoard;

/// ---------------------
/// @name Create Subviews
/// ---------------------

/**
 Create main display.
 */
- (void)createMainDisplay;

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
 Layout button board.
 */
- (void)layoutButtonBoard;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation


@implementation NIBCalculatorPortraitView


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Protocol Properties Conformance


#pragma mark NIBCalculatorViewPrococol

//@synthesize mainDisplay;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods


#pragma mark Creating Portrait Calculator View

+ (instancetype)calculatorView
{
    NIBCalculatorPortraitView *portraitCalculatorView = [self autolayoutView];
    
    /* properties initialization */
    portraitCalculatorView.mainDisplay = [UILabel autolayoutView];
    portraitCalculatorView.btns = [[NSMutableArray alloc] init];
    portraitCalculatorView.buttonBoard = [UIStackView autolayoutView];
    portraitCalculatorView.mainDisplayNeedsAdjustment = YES;
    
    /* create main display */
    [portraitCalculatorView createMainDisplay];
    
    /* create button board */
    [portraitCalculatorView createButtonBoard];
    
    /* add display and button board to the portrait calculator */
    [portraitCalculatorView addSubview:portraitCalculatorView.mainDisplay];
    [portraitCalculatorView addSubview:portraitCalculatorView.buttonBoard];
    
    /* layout main display */
    [portraitCalculatorView layoutMainDisplay];
    
    /* layout display view */
    [portraitCalculatorView layoutButtonBoard];
    
    return portraitCalculatorView;
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods


#pragma mark Create Subviews

- (void)createMainDisplay
{
    self.mainDisplay.minimumScaleFactor = NIBLabelTextMinScaleFactor;
    self.mainDisplay.adjustsFontSizeToFitWidth = YES;
    self.mainDisplay.lineBreakMode = NSLineBreakByClipping;
    self.mainDisplay.textAlignment = NSTextAlignmentRight;
    self.mainDisplay.textColor = [UIColor whiteColor];
    self.mainDisplay.font = [UIFont fontWithName:NIBFontLight size:NIBMainDisplayDefaultFontSize];
    self.mainDisplay.text = NIBMainDisplayDefaultText;
}

- (void)createButtonBoard
{
    /* create buttons in portrait */
    [NIBButtonFactory addDigitAndDecimalSeparatorButtonsWithFont:[UIFont fontWithName:NIBFontThin size:NIBButtonMediumFontSize]
                                                       toButtons:self.btns ];
    [NIBButtonFactory addArithmeticOperationButtonsWithFont:[UIFont fontWithName:NIBFontLight size:NIBButtonLargeFontSize]
                                                  toButtons:self.btns];
    [NIBButtonFactory addOtherCommonButtonsWithFont:[UIFont fontWithName:NIBFontThin size:NIBButtonSmallFontSize]
                                          toButtons:self.btns ];
    
    /* set border width in portrait */
    for (NIBButton *btn in self.btns) {
        [btn setBorderWidth:NIBButtonBorderWidth borderColor:[UIColor colorWithWhite:NIBButtonBorderWhite alpha:NIBButtonBorderAlpha]];
    }
    
    /* button tags in portrait */
    NSArray *firstButtonRowTagsInPortrait = @[ @(NIBButtonArithmeticClear),
                                               @(NIBButtonClear),
                                               @(NIBButtonSignToggle),
                                               @(NIBButtonPercentage),
                                               @(NIBButtonDivision) ];
    NSArray *secondButtonRowTagsInPortrait = @[ @(NIBButtonSeven),
                                                @(NIBButtonEight),
                                                @(NIBButtonNine),
                                                @(NIBButtonMultiplication) ];
    NSArray *thirdButtonRowTagsInPortrait = @[ @(NIBButtonFour),
                                               @(NIBButtonFive),
                                               @(NIBButtonSix),
                                               @(NIBButtonSubstraction) ];
    NSArray *fourthButtonRowTagsInPortrait = @[ @(NIBButtonOne),
                                                @(NIBButtonTwo),
                                                @(NIBButtonThree),
                                                @(NIBButtonAddition) ];
    NSArray *fifthButtonRowTagsInPortrait = @[ @(NIBButtonZero),
                                               @(NIBButtonDecimalSeparator),
                                               @(NIBButtonEquality) ];
    
    NSArray *buttonRowsTagsInLandscape = @[ firstButtonRowTagsInPortrait,
                                            secondButtonRowTagsInPortrait,
                                            thirdButtonRowTagsInPortrait,
                                            fourthButtonRowTagsInPortrait,
                                            fifthButtonRowTagsInPortrait ];
    
    for (NSUInteger i = 0; i < buttonRowsTagsInLandscape.count; i++) {
        UIStackView *row = [UIStackView autolayoutView];
        
        for (NSNumber *tag in buttonRowsTagsInLandscape[i]) {
            NIBButton *btn = [NIBViewUtilities buttonWithTag:tag.integerValue fromButtons:self.btns];
            
            if (btn) {
                [row addArrangedSubview:btn];
            }
        }
        
        /* if last row */
        if (i == buttonRowsTagsInLandscape.count-1) {
            /* layout last row */
            row.distribution = UIStackViewDistributionFillProportionally;
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
    /* layout main display on the portrait calculator */
    [[self.mainDisplay.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                    constant:NIBMainDisplayMargin] setActive:YES];
    [[self.mainDisplay.bottomAnchor constraintEqualToAnchor:self.buttonBoard.topAnchor] setActive:YES];
    [[self.mainDisplay.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                     constant:-NIBMainDisplayMargin] setActive:YES];
    [[self.mainDisplay.heightAnchor constraintEqualToAnchor:self.heightAnchor
                                                 multiplier:NIBMainDisplayHeightMultiplier] setActive:YES];
}

- (void)layoutButtonBoard
{
    /* general layout of button rows in button board */
    self.buttonBoard.axis = UILayoutConstraintAxisVertical;
    self.buttonBoard.alignment = UIStackViewAlignmentFill;
    self.buttonBoard.distribution = UIStackViewDistributionFillEqually;
    
    /* layout the first buttons of each row with height==width, zeroBtn with height==0.5width*/
    NSArray *firstButtonTagsInEachRow = @[ @(NIBButtonArithmeticClear),
                                           @(NIBButtonClear),
                                           @(NIBButtonSeven),
                                           @(NIBButtonOne),
                                           @(NIBButtonZero)];
    
    NSArray *conflictConstraintsButtonTags = @[ @(NIBButtonArithmeticClear),
                                                @(NIBButtonClear) ];
    
    
    for (NSNumber *tag in firstButtonTagsInEachRow) {
        NIBButton *btn = [NIBViewUtilities buttonWithTag:tag.integerValue fromButtons:self.btns];
        if (tag.integerValue == NIBButtonZero) {
            [[btn.heightAnchor constraintEqualToAnchor:btn.widthAnchor
                                            multiplier:NIBButtonBoardZeroButtonHeightOverWidthRatioMultiplier] setActive:YES];
        } else if ([conflictConstraintsButtonTags containsObject:tag]) {
             /* lower priority of clear button constraint when hiding */
            NSLayoutConstraint *constraint = [btn.heightAnchor constraintEqualToAnchor:btn.widthAnchor];
            constraint.priority = 999;
            constraint.active = YES;
        } else {
            [[btn.heightAnchor constraintEqualToAnchor:btn.widthAnchor] setActive:YES];
        }
    }

    /* layout the buttons of last row with width==height except zeroBtn */
    NSArray *buttonTagsInLastRow = @[ @(NIBButtonDecimalSeparator),
                                      @(NIBButtonEquality) ];
    
    for (NSNumber *tag in buttonTagsInLastRow) {
        NIBButton *btn = [NIBViewUtilities buttonWithTag:tag.integerValue fromButtons:self.btns];
        [[btn.widthAnchor constraintEqualToAnchor:btn.heightAnchor] setActive:YES];
    }
    
    /* hide button clear when initialization */
    NIBButton *clearBtn = [NIBViewUtilities buttonWithTag:NIBButtonClear fromButtons:self.buttons];
    clearBtn.hidden = YES;
    
    /* layout of button board on the portrait calculator */
    [[self.buttonBoard.leadingAnchor constraintEqualToAnchor:self.leadingAnchor] setActive:YES];
    [[self.buttonBoard.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
    [[self.buttonBoard.trailingAnchor constraintEqualToAnchor:self.trailingAnchor] setActive:YES];
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Protocols


#pragma mark - NIBCalculatorViewProtocol

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
