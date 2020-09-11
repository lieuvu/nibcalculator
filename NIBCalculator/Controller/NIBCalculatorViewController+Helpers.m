//
//  NIBCalculatorViewController+Helpers.m
//  NIBCalculator
//
//  Created by Lieu Vu on 11/10/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorViewController+Helpers.h"
#import "NIBCalculatorPortraitView.h"
#import "NIBCalculatorLandscapeView.h"
#import "NIBViewUtilities.h"

@implementation NIBCalculatorViewController (Helpers)

- (NSUInteger)digitsOfString:(NSString *)numStr
{
    NSUInteger digitsCount = 0;
    unichar exponentSymbol = [NIBExponentSymbol characterAtIndex:0];
    
    for (NSUInteger i = 0; i < numStr.length; i++) {
        if (isdigit([numStr characterAtIndex:i]) || [numStr characterAtIndex:i] == exponentSymbol) {
            digitsCount++;
        }
    }
    
    return digitsCount;
}

- (NSString *)stringFromString:(NSString *)numStr
           withRevmovalOptions:(NIBSymbolRemovalOptions)opts
{
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    NSString *decimalSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    
    if ((opts & NIBSymbolRemovalGroupingSeparator) == NIBSymbolRemovalGroupingSeparator) {
        numStr = [numStr stringByReplacingOccurrencesOfString:groupingSeparator withString:@""];
    }
    
    if ((opts & NIBSymbolRemovalDecimalSeparator) == NIBSymbolRemovalDecimalSeparator) {
        numStr = [numStr stringByReplacingOccurrencesOfString:decimalSeparator withString:@""];
    }
    
    if ((opts & NIBSymbolRemovalNegativePrefix) == NIBSymbolRemovalNegativePrefix) {
        numStr = [numStr stringByReplacingOccurrencesOfString:NIBNegativePrefix withString:@""];
    }
    
    return numStr;
}

- (void)toggleArithmeticClearButtonOrClearButton
{
    [self.portraitCalculatorView toggleArithmeticClearButtonOrClearButton];
    [self.landscapeCalculatorView toggleArithmeticClearButtonOrClearButton];
}

- (void)addToButtonsWithTags:(NSArray<NSNumber *> *)tags
                 fromButtons:(NSArray<NIBButton *> *)buttons
                      action:(SEL)action
             forControlEvent:(UIControlEvents)controlEvents
{
    for (NSNumber *tag in tags) {
        NIBButton *btn = [NIBViewUtilities buttonWithTag:tag.integerValue fromButtons:buttons];
        [btn addTarget:self action:action forControlEvents:controlEvents];
    }
}

@end
