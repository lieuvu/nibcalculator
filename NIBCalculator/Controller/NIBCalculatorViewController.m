//
//  CalculatorViewController.m
//  NIBCalculator
//
//  Created by Lieu Vu on 8/16/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorViewController.h"
#import "NIBCalculatorViewController+Helpers.h"
#import "NIBCalculatorViewController+Actions.h"
#import "NIBCalculatorViewController+UpdateDisplay.h"
#import "NIBCalculatorViewController+Store.h"
#import "NIBOperator.h"
#import "NIBCalculatorBrain.h"
#import "NIBCalculatorPortraitView.h"
#import "NIBCalculatorLandscapeView.h"
#import "NIBSelectionLabel.h"
#import "NIBViewUtilities.h"
#import "NIBConstants.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Constants


const NSUInteger NIBMaxDigitsInPortrait = 9;
const NSUInteger NIBMaxDigitsInLandscape = 16;
const double NIBMinFullDisplayableNegativeIntegerInPortrait = -999999999;
const double NIBMaxFullDisplayablePositiveIntegerInPortrait = 1000000000-1;
const double NIBMinFullDisplayableNegativeIntegerInLandscape = -9999999999999999;
const double NIBMaxFullDisplayablePositiveIntegerInLandscape = 9999999999999999;
NSString * const NIBExponentSymbol = @"e";
NSString * const NIBNegativePrefix = @"-";


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Constants


/** Button border width when selected for portrait. */
static const CGFloat NIBButtonBorderWidthWhenSelectedInPortrait = 4.5f;

/** Button border width when selected for landscape. */
static const CGFloat NIBButtonBorderWidthWhenSelectedInLandscape = 3.5f;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Extension


NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorViewController ()

@property (readwrite, strong, nonatomic) NIBCalculatorPortraitView *portraitCalculatorView;
@property (readwrite, strong, nonatomic) NIBCalculatorLandscapeView *landscapeCalculatorView;
@property (readwrite, strong, nonatomic) UIView<NIBCalculatorViewProtocol> *currentCalculatorView;
@property (readwrite, strong, nonatomic) NIBCalculatorBrain *calculator;
@property (readwrite, assign, nonatomic) SystemSoundID btnSound;
@property (readwrite, assign, nonatomic) BOOL resultDisplayed;
@property (readwrite, assign, nonatomic) BOOL mainDisplaySelected;
@property (readwrite, strong, nonatomic) NIBSelectionLabel *selectionLabel;
@property (readwrite, strong, nonatomic) NIBButton *_Nullable currentBinaryOperation;
@property (readwrite, assign, nonatomic) BOOL canBinaryOperatorPushOperand;

/// -----------------------------------------------
/// @name Layout Calculator View On View Controller
/// -----------------------------------------------

/**
 Layout a calculator view on the view controller.

 @param calculatorView The calculator view to layout.
 */
- (void)layoutCalculatorView:(UIView<NIBCalculatorViewProtocol> *)calculatorView;

/// -----------------
/// @name Add Actions
/// -----------------

/**
 Add playButtonSound action to buttons.
 */
- (void)addActionPlayButtonSound;

/**
 Add actions to main display of both view.
 */
- (void)addActionToMainDisplaysOfBothView;

/**
 Add common actions to buttons of both portrait
 and landscape calculator view
 */
- (void)addCommonActionsToButtonsOfBothViews;

/**
 Add actions to buttons of portrait calculator view.
 */
- (void)addActionsToButtonsOfLandscapeCalculatorView;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation


@implementation NIBCalculatorViewController


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Synthesize


@synthesize btnSound = _btnSound;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - View Controller LifeCycle


- (void)loadView
{
    /* view initialization */
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /* create portrait, landscape calculator view and selected label */
    self.portraitCalculatorView = [NIBCalculatorPortraitView calculatorView];
    self.landscapeCalculatorView = [NIBCalculatorLandscapeView calculatorView];
    self.selectionLabel = [NIBSelectionLabel label];

    /* add portrait, landscape calculator view to view controller */
    [self.view addSubview:self.portraitCalculatorView];
    [self.view addSubview:self.landscapeCalculatorView];

    /* layout portrait and landscape calcualtors on view controller */
    [self layoutCalculatorView:self.portraitCalculatorView];
    [self layoutCalculatorView:self.landscapeCalculatorView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* initialize property */
    self.calculator = [[NIBCalculatorBrain alloc] init];
    NSURL *btnSoundURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Tock" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)btnSoundURL, &self->_btnSound);
    self.currentBinaryOperation = nil;
    self.resultDisplayed = NO;
    self.canBinaryOperatorPushOperand = NO;
    self.mainDisplaySelected = NO;

    /* add action play button sound */
    [self addActionPlayButtonSound];

    /* add actions on main displays for both views */
    [self addActionToMainDisplaysOfBothView];

    /* add common actions to buttons both views */
    [self addCommonActionsToButtonsOfBothViews];

    /* add actions to buttons of landscape calculator view */
    [self addActionsToButtonsOfLandscapeCalculatorView];

    /* set border width and color for common binary buttons selected in both views */
    NSArray *commonBinaryOperationButtonTags = @[ @(NIBButtonDivision),
                                                  @(NIBButtonMultiplication),
                                                  @(NIBButtonSubstraction),
                                                  @(NIBButtonAddition) ];
    NSArray *buttonsGroup = @[self.portraitCalculatorView.buttons, self.landscapeCalculatorView.buttons];

    for (NSArray<NIBButton *> *buttons in buttonsGroup) {
        for (NSNumber *btnTag in commonBinaryOperationButtonTags) {
            NIBButton *btn = [NIBViewUtilities buttonWithTag:btnTag.integerValue fromButtons:buttons];
            if ([btn isDescendantOfView:self.portraitCalculatorView]) {
                [btn setSelectedEffectBorderWidth:NIBButtonBorderWidthWhenSelectedInPortrait borderColor:[UIColor blackColor]];
            }

            if ([btn isDescendantOfView:self.landscapeCalculatorView]) {
                [btn setSelectedEffectBorderWidth:NIBButtonBorderWidthWhenSelectedInLandscape borderColor:[UIColor blackColor]];
            }
        }
    }

    /* set border width and color for binary buttons selected in landscape */
    NSArray *landscapeBinaryOperationButtonTags = @[ @(NIBButtonXPowerY),
                                                     @(NIBButtonYPowerX),
                                                     @(NIBButtonYthRootOfX),
                                                     @(NIBButtonLogarithmBaseYOfX),
                                                     @(NIBButtonEE) ];

    for (NSNumber *btnTag in landscapeBinaryOperationButtonTags) {
        NIBButton *btn = [NIBViewUtilities buttonWithTag:btnTag.integerValue fromButtons:self.landscapeCalculatorView.buttons];
        [btn setSelectedEffectBorderWidth:NIBButtonBorderWidthWhenSelectedInLandscape borderColor:[UIColor blackColor]];
    }

    /* set border width and color for other buttons selected in landscape */
    NSArray *landscapeOtherSelectedOperationButtonTags = @[ @(NIBButtonSecondaryFunctionalToggleSwitch), @(NIBButtonMemoryRead) ];

    for (NSNumber *btnTag in landscapeOtherSelectedOperationButtonTags) {
        NIBButton *btn = [NIBViewUtilities buttonWithTag:btnTag.integerValue fromButtons:self.landscapeCalculatorView.buttons];
        [btn setSelectedEffectBorderWidth:NIBButtonBorderWidthWhenSelectedInLandscape borderColor:[UIColor blackColor]];
    }

    /* unarchive data */
    [self readArchive];

    /* present calculator view according to correct orientation */
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        [self.landscapeCalculatorView removeFromSuperview];
    } else {
        [self.portraitCalculatorView removeFromSuperview];
    }

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    UIView<NIBCalculatorViewProtocol> *currentView = self.currentCalculatorView;

    if (currentView.mainDisplayNeedsAdjustment) {
        [currentView.mainDisplay layoutIfNeeded];
        [NIBViewUtilities adjustFontSizeOfMainDisplay:currentView.mainDisplay];
        [currentView setMainDisplayAdjustment];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    /* layout the UIMenuController on the main display if it is selected */
    if (self.isMainDisplaySelected) {
        CGRect selectionLabelFrame = self.selectionLabel.frame;
        CGFloat x = CGRectGetMinX(selectionLabelFrame) + CGRectGetWidth(selectionLabelFrame)/2;
        CGFloat y = CGRectGetMinY(selectionLabelFrame);
        
        [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(x, y, 2, 2) inView:self.view];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Layout Calculator View On View Controller


- (void)layoutCalculatorView:(UIView<NIBCalculatorViewProtocol> *)calculatorView
{
    /* iOS 11 and later */
    if (@available(iOS 11, *)) {
        [[self.view.safeAreaLayoutGuide.leadingAnchor constraintEqualToAnchor:calculatorView.leadingAnchor] setActive:YES];
        [[self.view.safeAreaLayoutGuide.bottomAnchor constraintEqualToAnchor:calculatorView.bottomAnchor] setActive:YES];
        [[self.view.safeAreaLayoutGuide.trailingAnchor constraintEqualToAnchor:calculatorView.trailingAnchor] setActive:YES];
        [[self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:calculatorView.topAnchor] setActive:YES];
        
    /* iOS ealier than 11 */
    } else {
        [[self.view.leadingAnchor constraintEqualToAnchor:calculatorView.leadingAnchor] setActive:YES];
        [[self.topLayoutGuide.bottomAnchor constraintEqualToAnchor:calculatorView.topAnchor] setActive:YES];
        [[self.view.bottomAnchor constraintEqualToAnchor:calculatorView.bottomAnchor] setActive:YES];
        [[self.view.trailingAnchor constraintEqualToAnchor:calculatorView.trailingAnchor] setActive:YES];
    }
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Add Actions


- (void)addActionPlayButtonSound
{
    NSArray<UIView<NIBCalculatorViewProtocol> *> *calculatorViews = @[self.portraitCalculatorView, self.landscapeCalculatorView];

    for (UIView<NIBCalculatorViewProtocol> *calculatorView in calculatorViews) {
        for (NIBButton *btn in calculatorView.buttons) {
            [btn addTarget:self action:@selector(playButtonSound) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)addActionToMainDisplaysOfBothView
{
    NSArray<UIView<NIBCalculatorViewProtocol> *> *calculatorViews = @[self.portraitCalculatorView, self.landscapeCalculatorView];

    /* add actions to main displays */
    for (UIView<NIBCalculatorViewProtocol> *calculatorView in calculatorViews) {
        [calculatorView.mainDisplay setUserInteractionEnabled:YES];

        /* add swipe right action - swipeRightMainDisplay */
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightMainDisplay)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        swipeRight.numberOfTouchesRequired = 1;
        [calculatorView.mainDisplay addGestureRecognizer:swipeRight];

        /* add long press action - selectMainDisplay */
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(selectMainDisplay:)];
        [calculatorView.mainDisplay addGestureRecognizer:longPress];

        /* add double tap action - selectMainDisplay */
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMainDisplay:)];
        doubleTap.numberOfTapsRequired = 2;
        [calculatorView.mainDisplay addGestureRecognizer:doubleTap];

        /* add tap action - deselectMainDisplay */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deselectMainDisplay)];
        [tap requireGestureRecognizerToFail:doubleTap];
        [calculatorView.mainDisplay addGestureRecognizer:tap];
    }
}

- (void)addCommonActionsToButtonsOfBothViews
{
    NSArray *buttonsGroup = @[self.portraitCalculatorView.buttons, self.landscapeCalculatorView.buttons];

    /* add action for arithmetic clear button */
    for (NSArray *buttons in buttonsGroup) {
        NIBButton *arithmeticClearBtn = [NIBViewUtilities buttonWithTag:NIBButtonArithmeticClear fromButtons:buttons];
        [arithmeticClearBtn addTarget:self action:@selector(clearArithmeticOperations) forControlEvents:UIControlEventTouchUpInside];
    }

    /* add action to clear button */
    for (NSArray *buttons in buttonsGroup) {
        NIBButton *clearBtn = [NIBViewUtilities buttonWithTag:NIBButtonClear fromButtons:buttons];
        [clearBtn addTarget:self action:@selector(clearMainDisplays) forControlEvents:UIControlEventTouchUpInside];
    }

    /* add action to sign toggle operation */
    for (NSArray *buttons in buttonsGroup) {
        NIBButton *signToggleBtn = [NIBViewUtilities buttonWithTag:NIBButtonSignToggle fromButtons:buttons];
        [signToggleBtn addTarget:self action:@selector(toggleNegativePrefix) forControlEvents:UIControlEventTouchUpInside];
    }

    /* add action to digits and decimal separator buttons */
    NSArray *digitsAndDecimalButtonTags = @[ @(NIBButtonZero),
                                             @(NIBButtonOne),
                                             @(NIBButtonTwo),
                                             @(NIBButtonThree),
                                             @(NIBButtonFour),
                                             @(NIBButtonFive),
                                             @(NIBButtonSix),
                                             @(NIBButtonSeven),
                                             @(NIBButtonEight),
                                             @(NIBButtonNine),
                                             @(NIBButtonDecimalSeparator) ];

    for (NSArray *buttons in buttonsGroup) {
        [self addToButtonsWithTags:digitsAndDecimalButtonTags fromButtons:buttons action:@selector(pressDigitAndDecimalSeparator:) forControlEvent:UIControlEventTouchUpInside];
    }

    /* add action to common unary operation */
    for (NSArray *buttons in buttonsGroup) {
        NIBButton *percentageBtn = [NIBViewUtilities buttonWithTag:NIBButtonPercentage fromButtons:buttons];
        [percentageBtn addTarget:self action:@selector(performUnaryOperation:) forControlEvents:UIControlEventTouchUpInside];
    }

    /* add action to common binary operation */
    NSArray *commonBinaryOperationButtonTags = @[ @(NIBButtonDivision),
                                                  @(NIBButtonMultiplication),
                                                  @(NIBButtonSubstraction),
                                                  @(NIBButtonAddition) ];

    for (NSArray *buttons in buttonsGroup) {
        [self addToButtonsWithTags:commonBinaryOperationButtonTags fromButtons:buttons action:@selector(performBinaryOperation:) forControlEvent:UIControlEventTouchUpInside];
    }

    /* add action to equality operation */
    for (NSArray *buttons in buttonsGroup) {
        NIBButton *equalityOperationBtn = [NIBViewUtilities buttonWithTag:NIBButtonEquality fromButtons:buttons];
        [equalityOperationBtn addTarget:self action:@selector(performEqualityOperation:) forControlEvents:UIControlEventTouchUpInside];
    }

}

- (void)addActionsToButtonsOfLandscapeCalculatorView
{
    NSArray *buttons = self.landscapeCalculatorView.buttons;

    /* add action to binary operations */
    NSArray *binaryOpeartionButtonTags = @[ @(NIBButtonXPowerY),
                                            @(NIBButtonYPowerX),
                                            @(NIBButtonYthRootOfX),
                                            @(NIBButtonLogarithmBaseYOfX),
                                            @(NIBButtonEE) ];

    [self addToButtonsWithTags:binaryOpeartionButtonTags fromButtons:buttons action:@selector(performBinaryOperation:) forControlEvent:UIControlEventTouchUpInside];

    /* add action to unary operations */
    NSArray *unaryOpeartionButtonTags = @[ @(NIBButtonXSquared),
                                           @(NIBButtonXCubed),
                                           @(NIBButtonEulerNumberPowerX),
                                           @(NIBButtonTenPowerX),
                                           @(NIBButtonTwoPowerX),
                                           @(NIBButtonSquareRootOfX),
                                           @(NIBButtonCubicRootOfX),
                                           @(NIBButtonOneOverX),
                                           @(NIBButtonNaturalLogarithm),
                                           @(NIBButtonCommonLogarithm),
                                           @(NIBButtonLogarithmBaseTwo),
                                           @(NIBButtonXFactorial),
                                           @(NIBButtonSin),
                                           @(NIBButtonCos),
                                           @(NIBButtonTan),
                                           @(NIBButtonArcSin),
                                           @(NIBButtonArcCos),
                                           @(NIBButtonArcTan),
                                           @(NIBButtonSinh),
                                           @(NIBButtonCosh),
                                           @(NIBButtonTanh),
                                           @(NIBButtonArcSinh),
                                           @(NIBButtonArcCosh),
                                           @(NIBButtonArcTanh) ];

    [self addToButtonsWithTags:unaryOpeartionButtonTags fromButtons:buttons action:@selector(performUnaryOperation:) forControlEvent:UIControlEventTouchUpInside];

    /* add action to parentheses operation buttons */
    NSArray *parenthesesOperationButtonTags = @[ @(NIBButtonOpenningParenthesis),
                                                 @(NIBButtonClosingParenthesis) ];

    [self addToButtonsWithTags:parenthesesOperationButtonTags fromButtons:buttons action:@selector(performParenthesisOperationCalculation:) forControlEvent:UIControlEventTouchUpInside];

    /* add action to pi, euler and rand buttons */
    NSArray *constantButtonTags = @[ @(NIBButtonPi),
                                     @(NIBButtonEulerNumber),
                                     @(NIBButtonRand) ];

    [self addToButtonsWithTags:constantButtonTags fromButtons:buttons action:@selector(getConstantNumber:) forControlEvent:UIControlEventTouchUpInside];

    /* add action to memory operation buttons */
    NSArray *memoryOperationButtonTags = @[ @(NIBButtonMemoryClear),
                                            @(NIBButtonMemoryPlus),
                                            @(NIBButtonMemoryMinus),
                                            @(NIBButtonMemoryRead) ];

    [self addToButtonsWithTags:memoryOperationButtonTags fromButtons:buttons action:@selector(performMemoryOperation:) forControlEvent:UIControlEventTouchUpInside];

    /* add action to secondary functional operation toggle switch buton */
    NIBButton *secondaryFunctionalOperationToggleSwitchBtn = [NIBViewUtilities buttonWithTag:NIBButtonSecondaryFunctionalToggleSwitch fromButtons:buttons];
    [secondaryFunctionalOperationToggleSwitchBtn addTarget:self action:@selector(toggleSecondaryFunctionalOperations:) forControlEvents:UIControlEventTouchUpInside];

    /* add action to rad and deg buttons */
    NSArray *angleModeButtonTags = @[ @(NIBButtonRad),
                                      @(NIBButtonDeg) ];

    [self addToButtonsWithTags:angleModeButtonTags fromButtons:buttons action:@selector(toggleAngleMode:) forControlEvent:UIControlEventTouchUpInside];
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - View Rotation


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    /* orientation changes to landscape */
    if (size.width > size.height) {

        [UIView animateWithDuration:0.3 animations:^{
            /* remove portrait calculator view if in main view*/
            if ([self.view.subviews containsObject:self.portraitCalculatorView]) {
                [self.portraitCalculatorView removeFromSuperview];
            }

        } completion:^(BOOL finished) {
            if (finished) {
                /* add landscape calculator view */
                [self.view addSubview:self.landscapeCalculatorView];
                [self layoutCalculatorView:self.landscapeCalculatorView];
            }
        }];

    /* orientation changes to portrait */
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            /* remove landscape calculator view if in main view */
            if ([self.view.subviews containsObject:self.landscapeCalculatorView]) {
                [self.landscapeCalculatorView removeFromSuperview];
            }

        } completion:^(BOOL finished) {
            if (finished) {
                /* add portrait calculator view */
                [self.view addSubview:self.portraitCalculatorView];
                [self layoutCalculatorView:self.portraitCalculatorView];
            }
        }];
    }
    
    /* if the main display is selected, deselect it */
    if (self.isMainDisplaySelected) [self deselectMainDisplay];
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - UIResponder


- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id __unused)sender
{
    BOOL result = NO;

    if (action == @selector(copy:)) {
        result = YES;
    } else if (action == @selector(paste:)) {
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];

        /* if the paste board contains string that is a number */
        if ([pasteBoard.string rangeOfCharacterFromSet:notDigits].location == NSNotFound) {
            result = YES;
        }
    }

    return result;
}

- (void)copy:(id __unused)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.currentCalculatorView.mainDisplay.text;

    /* if the main display is selected, deselect it */
    if (self.isMainDisplaySelected) [self deselectMainDisplay];
}

- (void)paste:(id __unused)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    self.currentCalculatorView.mainDisplay.text = pasteBoard.string;

    /* if the main display is selected, deselect it */
    if (self.isMainDisplaySelected) [self deselectMainDisplay];
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Others


- (UIView<NIBCalculatorViewProtocol> *)currentCalculatorView
{
    for (UIView *view in self.view.subviews) {
        if ([view conformsToProtocol:@protocol(NIBCalculatorViewProtocol)]) {
            if (_currentCalculatorView != view) {
                _currentCalculatorView = (UIView<NIBCalculatorViewProtocol> *)view;
            }
            break;
        }
    }

    return _currentCalculatorView;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
