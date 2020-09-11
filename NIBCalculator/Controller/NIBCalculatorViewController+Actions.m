//
//  NIBCalculatorViewController+Actions.m
//  NIBCalculator
//
//  Created by Lieu Vu on 11/10/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorViewController+Actions.h"
#import "NIBCalculatorViewController+Helpers.h"
#import "NIBCalculatorViewController+UpdateDisplay.h"
#import "NIBOperator.h"
#import "NIBCalculatorBrain.h"
#import "NIBCalculatorPortraitView.h"
#import "NIBCalculatorLandscapeView.h"
#import "NIBSelectionLabel.h"
#import "NIBViewUtilities.h"
#import "NIBConstants.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Extension


NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorViewController ()

@property (readwrite, assign, nonatomic) BOOL resultDisplayed;
@property (readwrite, assign, nonatomic) BOOL mainDisplaySelected;
@property (readwrite, strong, nonatomic) NIBButton *_Nullable currentBinaryOperation;
@property (readwrite, assign, nonatomic) BOOL canBinaryOperatorPushOperand;

@end

NS_ASSUME_NONNULL_END

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Category


NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorViewController (Actions_Private)

/**
 Count the number of digits of a result after performing an operator
 
 @param operator The operator to perform.
 
 @return Returns the number of digits of the result if the result can be
 calculated. Otherwise, a number of maximum displayable digits of the current
 main display.
 */
- (NSUInteger)digitsOfResultAfterPerfomingOperator:(NIBOperator *)operator;

@end

NS_ASSUME_NONNULL_END


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Category Implementation


@implementation NIBCalculatorViewController (Actions_Private)

- (NSUInteger)digitsOfResultAfterPerfomingOperator:(NIBOperator *)operator
{
    /* determine the max digits to display */
    NSUInteger maxDigits;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.locale = [NSLocale currentLocale];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.maximumFractionDigits = NIBMaxDigitsInLandscape;
    
    maxDigits = [self digitsOfString:[numberFormatter stringFromNumber:[self.calculator performOperator:operator withExperimentalModeOn:YES]]];
    
    if (maxDigits == 0) {
        if ([self.currentCalculatorView isKindOfClass:[NIBCalculatorPortraitView class]]) {
            maxDigits = NIBMaxDigitsInPortrait;
        } else {
            maxDigits = NIBMaxDigitsInLandscape;
        }
    }
    
    return maxDigits;
}

@end


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Category Implementation


@implementation NIBCalculatorViewController (Actions)

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Common Actions In Portrait And Landscape

- (void)playButtonSound
{
    AudioServicesPlaySystemSound(self.btnSound);
}

- (void)swipeRightMainDisplay
{
    /* if the result is displayed, do nothing */
    if (self.isResultDisplayed) {
        return;
    }
    
    /* current number string in landscape */
    NSString *currentNumberStr = self.landscapeCalculatorView.mainDisplay.text;
    
    if ([currentNumberStr isEqualToString:NIBMainDisplayErrorText]) {
        return;
    }
    
    /* if a current number is one digit */
    if (currentNumberStr.length == 1) {
        [self updateMainDisplaysWithString:NIBMainDisplayDefaultText];
        return;
    }
    
    /* otherwise, the current number has more than one digit */
    NSString *numStr = [currentNumberStr substringToIndex:currentNumberStr.length-1];
    
    [self updateMainDisplaysWithString:numStr];
    
    /* if the main display is selected, deselect it */
    if (self.isMainDisplaySelected) [self deselectMainDisplay];
}

- (void)selectMainDisplay:(UIGestureRecognizer *)gestureRecognizer
{
    UILabel *currentDisplay = nil;
    
    if ([gestureRecognizer.view isKindOfClass:[UILabel class]]) {
        currentDisplay = (UILabel *)gestureRecognizer.view;
    }
    
    if (!currentDisplay) {
        NSLog(@"Undefined Main Display for Selection!");
        return;
    }
    
    /* if main display is not selected */
    if (!self.isMainDisplaySelected) {
        [self becomeFirstResponder];
        
        /* size of current number string */
        CGSize numStrSize = [currentDisplay.text sizeWithAttributes:@{NSFontAttributeName : currentDisplay.font}];
        
        /* font size of the number string */
        CGFloat fontSize;
        {
            NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
            context.minimumScaleFactor = currentDisplay.minimumScaleFactor;
            
            NSAttributedString *temp = [[NSAttributedString alloc] initWithString:currentDisplay.text attributes:@{NSFontAttributeName : currentDisplay.font}];
            [temp boundingRectWithSize:currentDisplay.frame.size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:context];
            
            fontSize = currentDisplay.font.pointSize * context.actualScaleFactor;
        }
        
        /* add selected label to view controller */
        [self.view addSubview:self.selectionLabel];
        
        /*----- layout selected label -----*/
        /* selected label trailing anchor */
        [[self.selectionLabel.trailingAnchor constraintEqualToAnchor:self.currentCalculatorView.trailingAnchor] setActive:YES];
        
        /* selected label width */
        /* if the width size plus margin is larger than the width of the current display */
        if (numStrSize.width+2*NIBMainDisplayMargin > currentDisplay.frame.size.width) {
            /* the label width equals the width of the calculator view */
            [[self.selectionLabel.widthAnchor constraintEqualToAnchor:self.currentCalculatorView.widthAnchor] setActive:YES];
        
        /* otherwise, the width size plus margin is less than the width of the current display */
        } else {
            /* the label width equals the number string width plus two times the margin */
            [[self.selectionLabel.widthAnchor constraintEqualToConstant:numStrSize.width+2*NIBMainDisplayMargin] setActive:YES];
        }
        
        /* if the view is portrait */
        if ([self.currentCalculatorView isKindOfClass:[NIBCalculatorPortraitView class]]) {
            /* selected label bottom equals the main display bottom minus the margin */
            [[self.selectionLabel.bottomAnchor constraintEqualToAnchor:currentDisplay.bottomAnchor constant:-NIBMainDisplayMargin] setActive:YES];
            /* selected label height equals the font size plus two times the margin */
            [[self.selectionLabel.heightAnchor constraintEqualToConstant:fontSize+2*NIBMainDisplayMargin] setActive:YES];
        
        /* otherwise, the view is landcape */
        } else {
            /* selected label bottom equals the main display bottom */
            [[self.selectionLabel.bottomAnchor constraintEqualToAnchor:currentDisplay.bottomAnchor] setActive:YES];
            /* selected label height equals the font size plus the margin */
            [[self.selectionLabel.heightAnchor constraintEqualToConstant:fontSize+NIBMainDisplayMargin] setActive:YES];
        }
        
        [self.selectionLabel layoutIfNeeded];
        
        /* set flag to YES to indicate the display is selected */
        self.mainDisplaySelected = YES;
    }
}

- (void)deselectMainDisplay
{
    /* if the main display is selected */
    if (self.isMainDisplaySelected) {
        /* resign first responder */
        [self resignFirstResponder];
        
        /* hide menu controller */
        [UIMenuController sharedMenuController].menuVisible = NO;
        
        /* remove selected label */
        [self.selectionLabel removeConstraints:self.selectionLabel.constraints];
        [self.selectionLabel removeFromSuperview];
        
        /* set flag to NO to indicate the display is not selected */
        self.mainDisplaySelected = NO;
    }
}

- (void)clearArithmeticOperations
{
    [self.calculator clearArithmetic];
    [self updateMainDisplaysWithString:NIBMainDisplayDefaultText];
    
    /* if main display is selected, deselect it */
    if (self.isMainDisplaySelected) [self deselectMainDisplay];
    
    /* handle effect of current binary operation */
    if (self.currentBinaryOperation.selected) [self.currentBinaryOperation toggleEffect];
    
    /* remove cached binary operation */
    if (self.currentBinaryOperation) self.currentBinaryOperation = nil;
}

- (void)clearMainDisplays
{
    [self updateMainDisplaysWithString:NIBMainDisplayDefaultText];
    
    /* show arithmetic clear button */
    [self toggleArithmeticClearButtonOrClearButton];
    
    /* if main display is selected, deselect it */
    if (self.isMainDisplaySelected) [self deselectMainDisplay];
    
    /* revert the current binary operation if there is one */
    if (self.currentBinaryOperation && self.currentBinaryOperation.selected == NO) {
        [self.currentBinaryOperation toggleEffect];
        self.canBinaryOperatorPushOperand = NO;
    }
}

- (void)toggleNegativePrefix
{
    /* if the current number string is error text, do nothing */
    if ([self.currentCalculatorView.mainDisplay.text containsString:NIBMainDisplayErrorText]) {
        return;
    }
    
    NSArray<UILabel *> *mainDisplays = @[self.portraitCalculatorView.mainDisplay, self.landscapeCalculatorView.mainDisplay];
    
    for (UILabel *display in mainDisplays) {
        NSMutableString *temp = [[NSMutableString alloc] initWithString:display.text];
        if ([temp containsString:NIBNegativePrefix]) {
            [temp setString:[temp substringFromIndex:1]];
        } else {
            [temp insertString:NIBNegativePrefix atIndex:0];
        }
        display.text = temp;
    }
}

- (void)pressDigitAndDecimalSeparator:(NIBButton *)button
{
    UIView<NIBCalculatorViewProtocol> *currentCalView = self.currentCalculatorView;
    NSString *currentNumberStr = currentCalView.mainDisplay.text;
    NSMutableString *numStr = nil;
    
    /* if result is displayed */
    if (self.isResultDisplayed) {
        /* reset string */
        numStr = [[NSMutableString alloc] init];
        self.resultDisplayed = NO;
        
        /* otherwise, the result is not displayed */
    } else {
        /* get the number string */
        numStr = [[NSMutableString alloc] initWithString:currentNumberStr];
    }
    
    /* digits of number string */
    NSUInteger digitsOfNumber = [self digitsOfString:numStr];
    
    /* if the number string displayed in scientific notation, do nothing */
    if ([numStr containsString:NIBExponentSymbol]) {
        return;
    }
    
    /* if the current view is portrait and the number string reach limit of characters in portrait */
    if ([currentCalView isKindOfClass:[NIBCalculatorPortraitView class]] &&
        digitsOfNumber >= NIBMaxDigitsInPortrait) {
        return;
    }
    
    /* if the current view is landscape and the number string reach limit of characters in landscape */
    if ([currentCalView isKindOfClass:[NIBCalculatorLandscapeView class]] &&
        digitsOfNumber >= NIBMaxDigitsInLandscape) {
        return;
    }
    
    NSString *decimalSeparator = [[NSLocale currentLocale] decimalSeparator];
    
    switch (button.tag) {
            /* enter zero */
        case NIBButtonZero:
            /* if enter the number beginning with zero, do nothing */
            if ([numStr isEqualToString:NIBMainDisplayDefaultText]) {
                return;
            }
            
            /* otherwise, append zero */
            [numStr appendString:button.titleLabel.text];
            break;
            
            /* enter decimal separator */
        case NIBButtonDecimalSeparator:
            /* if enter two decimal separator, do nothing */
            if ([numStr containsString:decimalSeparator]) {
                return;
            }
            
            /* otherwise, enter first decimal separator */
            /* if enter decimal separator when result is displayed */
            if (numStr.length == 0) {
                /* add default string */
                [numStr appendString:NIBMainDisplayDefaultText];
                
            }
            
            /* otherwise, enter decimal separtor as continuation of input */
            [numStr appendString:decimalSeparator];
            break;
            
            /* enter other numbers */
        default:
            /* if the number string is default text */
            if ([numStr isEqualToString:NIBMainDisplayDefaultText]) {
                /* replace default string with a new digit */
                numStr = [[NSMutableString alloc] initWithString:button.titleLabel.text];
                
                /* otherwise, the number string is not default text */
            } else {
                /* append a new digit */
                [numStr appendString:button.titleLabel.text];
            }
            break;
    }
    
    /* update main displays with number string */
    [self updateMainDisplaysWithString:numStr];
    
    /* allow binary operator to push number */
    self.canBinaryOperatorPushOperand = YES;
    
    /* if main display is selected, deselect it */
    if (self.isMainDisplaySelected) [self deselectMainDisplay];
    
    /* toggle effect of current binary operator is selected */
    if (self.currentBinaryOperation.selected) [self.currentBinaryOperation toggleEffect];
    
    NIBButton *arithmeticClearBtn = [NIBViewUtilities buttonWithTag:NIBButtonArithmeticClear fromButtons:currentCalView.buttons];
    
    /* switch to clear button if needed */
    if (arithmeticClearBtn.hidden == NO) [self toggleArithmeticClearButtonOrClearButton];
    
}

- (void)performUnaryOperation:(NIBButton *)button
{
    NSString *numStr = [self stringFromString:self.currentCalculatorView.mainDisplay.text withRevmovalOptions:NIBSymbolRemovalGroupingSeparator];
    
    /* if number string is not a number */
    if ([numStr isEqualToString:NIBMainDisplayErrorText]) {
        [self.calculator pushOperand:NAN];
    } else {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.locale = [NSLocale currentLocale];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.lenient = YES;
        
        [self.calculator pushOperand:[[numberFormatter numberFromString:numStr] doubleValue]];
    }
    
    /* update main displays with number from calculation */
    [self updateMainDisplaysWithNumber:[self.calculator performOperator:[NIBOperator operatorWithTag:button.tag]] maxDisplayableDigits:NIBMaxDigitsInLandscape];
    
    /* result is displayed */
    self.resultDisplayed = YES;
}

- (void)performBinaryOperation:(NIBButton *)button
{
    /* determine the current digits of expression */
    NSUInteger currentResultDigits = 0;
    
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.locale = [NSLocale currentLocale];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = NIBMaxDigitsInLandscape;
        
        currentResultDigits = [self digitsOfString:[numberFormatter stringFromNumber:[self.calculator performOperator:[NIBOperator operatorWithTag:button.tag] withExperimentalModeOn:YES]]];
    }
    
    /* find max digits from binary operation to display on screen */
    NSString *numStr = [self stringFromString:self.currentCalculatorView.mainDisplay.text withRevmovalOptions:NIBSymbolRemovalGroupingSeparator];
    NSUInteger maxDigits;
    
    switch (button.tag) {
        case NIBButtonMultiplication:
            if (currentResultDigits && [self digitsOfString:numStr] <= currentResultDigits) {
                maxDigits = currentResultDigits * 2;
            } else {
                maxDigits = [self digitsOfString:numStr] * 2;
            }
            break;
            
        case NIBButtonSubstraction:
            if (currentResultDigits && [self digitsOfString:numStr] <= currentResultDigits) {
                maxDigits = currentResultDigits;
            } else {
                maxDigits = [self digitsOfString:numStr];
            }
            break;
            
        case NIBButtonAddition:
            if (currentResultDigits && [self digitsOfString:numStr] <= currentResultDigits) {
                maxDigits = currentResultDigits + 1;
            } else {
                maxDigits = [self digitsOfString:numStr] + 1;
            }
            break;
            
        default:
            if ([self.currentCalculatorView isKindOfClass:[NIBCalculatorPortraitView class]]) {
                maxDigits =  NIBMaxDigitsInPortrait;
            } else {
                maxDigits = NIBMaxDigitsInLandscape;
            }
            break;
    }
    
    /* if binary operator can push number  */
    if (self.canBinaryOperatorPushOperand) {
        /* if number string is not a number */
        if ([numStr isEqualToString:NIBMainDisplayErrorText]) {
            [self.calculator pushOperand:NAN];
        } else {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.locale = [NSLocale currentLocale];
            numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            numberFormatter.lenient = YES;
            [self.calculator pushOperand:[[numberFormatter numberFromString:numStr] doubleValue]];
        }
        
        /* not allow binary operator to push number */
        self.canBinaryOperatorPushOperand = NO;
    }
    
    /* if there is current binary operation */
    if (self.currentBinaryOperation) {
        /* toggle effect of executed binary operation */
        if (self.currentBinaryOperation.selected) [self.currentBinaryOperation toggleEffect];
        
        /* cache next binary operation */
        self.currentBinaryOperation = button;
        [self.currentBinaryOperation toggleEffect];
        
        /* otherwise, there is no current binary operation */
    } else {
        self.currentBinaryOperation = button;
        [self.currentBinaryOperation toggleEffect];
    }
    
    /* update main displays with number from calculation */
    [self updateMainDisplaysWithNumber:[self.calculator performOperator:[NIBOperator operatorWithTag:self.currentBinaryOperation.tag]] maxDisplayableDigits:maxDigits];
    
    /* result is displayed */
    self.resultDisplayed = YES;
}

- (void)performEqualityOperation:(NIBButton *)button
{
    NSString *numStr = [self stringFromString:self.currentCalculatorView.mainDisplay.text withRevmovalOptions:NIBSymbolRemovalGroupingSeparator];
    
    /* if number string is not a number */
    if ([numStr isEqualToString:NIBMainDisplayErrorText]) {
        [self.calculator pushOperand:NAN];
        
        /* otherwise number string is a number */
    } else {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.locale = [NSLocale currentLocale];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.lenient = YES;
        [self.calculator pushOperand:[[numberFormatter numberFromString:numStr] doubleValue]];
    }
    
    /* handle effect of current binary operation */
    if (self.currentBinaryOperation.selected) [self.currentBinaryOperation toggleEffect];
    
    /* remove cached binary operation */
    if (self.currentBinaryOperation) self.currentBinaryOperation = nil;
    
    /* determine max digits to display */
    NSUInteger maxDigits = [self digitsOfResultAfterPerfomingOperator:[NIBOperator operatorWithTag:button.tag]];
    
    /* update main displays with number from calculation */
    [self updateMainDisplaysWithNumber:[self.calculator performOperator:[NIBOperator operatorWithTag:button.tag]] maxDisplayableDigits:maxDigits];
    
    /* result is displayed */
    self.resultDisplayed = YES;
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions Only In Landscape


- (void)performParenthesisOperationCalculation:(NIBButton *)button
{
    
    NSString *numStr = [self stringFromString:self.currentCalculatorView.mainDisplay.text withRevmovalOptions:NIBSymbolRemovalGroupingSeparator];
    
    /* if button is closing parenthesis */
    if (button.tag == NIBButtonClosingParenthesis) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.locale = [NSLocale currentLocale];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.lenient = YES;
        
        [self.calculator pushOperand:[[numberFormatter numberFromString:numStr] doubleValue]];
        if (self.currentBinaryOperation.selected) [self.currentBinaryOperation toggleEffect];
        if (self.currentBinaryOperation) self.currentBinaryOperation = nil;
        self.resultDisplayed = YES;
    }
    
    /* determine max digits to display */
    NSUInteger maxDigits = [self digitsOfResultAfterPerfomingOperator:[NIBOperator operatorWithTag:button.tag]];
    
    /* update main display with number from calculation */
    [self updateMainDisplaysWithNumber:[self.calculator performOperator:[NIBOperator operatorWithTag:button.tag]] maxDisplayableDigits:maxDigits];
}

- (void)performMemoryOperation:(NIBButton *)button
{
    NSString *numStr = [self stringFromString:self.currentCalculatorView.mainDisplay.text withRevmovalOptions:NIBSymbolRemovalGroupingSeparator];
    NIBButton *memoryReadBtn = [NIBViewUtilities buttonWithTag:NIBButtonMemoryRead fromButtons:self.landscapeCalculatorView.buttons];
    
    /* if number string is not a number, do nothing */
    if ([numStr isEqualToString:NIBMainDisplayErrorText]) {
        return;
    }
    
    /* process memory operation */
    switch (button.tag) {
        case NIBButtonMemoryClear:
            /* if memory is nil, do nothing */
            if (!self.calculator.memory) {
                return;
            }
            /* otherwise, clear memory and turn off visual apperance of the clear button */
            [self.calculator clearMemory];
            [memoryReadBtn toggleEffect];
            break;
            
        case NIBButtonMemoryPlus:
        {
            /* if memory is nil */
            if (!self.calculator.memory) {
                /* turn on visual appearance of the clear button */
                [memoryReadBtn toggleEffect];
            }
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.locale = [NSLocale currentLocale];
            [self.calculator addToMemory:[[numberFormatter numberFromString:numStr] doubleValue]];
            break;
        }
            
        case NIBButtonMemoryMinus:
        {
            /* if memory is nil */
            if (!self.calculator.memory) {
                /* turn on visual appearance of the clear button */
                [memoryReadBtn toggleEffect];
            }
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.locale = [NSLocale currentLocale];
            [self.calculator subtractFromMemory:[[numberFormatter numberFromString:numStr] doubleValue]];
            break;
        }
            
        case NIBButtonMemoryRead:
        {
            NSUInteger maxDigits;
            if ([self.currentCalculatorView isKindOfClass:[NIBCalculatorPortraitView class]]) {
                maxDigits = NIBMaxDigitsInPortrait;
            } else {
                maxDigits = NIBMaxDigitsInLandscape;
            }
            [self updateMainDisplaysWithNumber:self.calculator.memory maxDisplayableDigits:maxDigits];
            
            /* allow binary operator to push operand */
            self.canBinaryOperatorPushOperand = YES;
            
            /* result is displayed */
            self.resultDisplayed = YES;
            break;
        }
            
        default:
            break;
    }
}

- (void)getConstantNumber:(NIBButton *)button
{
    NSNumber *constNum = [self.calculator constantNumber:[NIBOperator operatorWithTag:button.tag]];
    
    [self updateMainDisplaysWithNumber:constNum maxDisplayableDigits:NIBMaxDigitsInLandscape];
    self.canBinaryOperatorPushOperand = YES;
}

- (void)toggleSecondaryFunctionalOperations:(NIBButton *)button
{
    NIBCalculatorLandscapeView *currentCalView = nil;
    
    if ([self.currentCalculatorView isKindOfClass:[NIBCalculatorLandscapeView class]]) {
        currentCalView = (NIBCalculatorLandscapeView *)self.currentCalculatorView;
    }
    
    /* toggle secondary functional operations */
    [button toggleEffect];
    [currentCalView toggleSecondaryFunctionalButtons];
}

- (void)toggleAngleMode:(NIBButton *)button
{
    NIBCalculatorLandscapeView *currentCalView = nil;
    
    if ([self.currentCalculatorView isKindOfClass:[NIBCalculatorLandscapeView class]]) {
        currentCalView = (NIBCalculatorLandscapeView *)self.currentCalculatorView;
    }
    
    if (button.tag == NIBButtonRad) {
        currentCalView.secondaryDisplay.text = button.titleLabel.text;
    } else {
        currentCalView.secondaryDisplay.text = NIBSecondaryDisplayDefaultText;
    }
    [self.calculator toggleRadianMode];
    [currentCalView toggleAngleMode];
}

@end
