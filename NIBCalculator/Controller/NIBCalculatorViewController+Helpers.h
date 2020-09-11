//
//  NIBCalculatorViewController+Helpers.h
//  NIBCalculator
//
//  Created by Lieu Vu on 11/10/17.
//  Copyright © 2017 LV. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NIBCalculatorViewController.h"

@class NIBButton;
@class NIBOperator;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Types, Enumeration and Options


/** An option to indicate which symbol(s) is/are removed from the number string */
typedef NS_OPTIONS(NSUInteger, NIBSymbolRemovalOptions) {
    /** Remove a grouping separator of current locale */
    NIBSymbolRemovalGroupingSeparator = 1 << 0,
    /** Remove a decimal separator of current locale */
    NIBSymbolRemovalDecimalSeparator = 1 << 1,
    /** Remove a negative prefix of current locale */
    NIBSymbolRemovalNegativePrefix = 1 << 2
};


/////////////////////////////////////////////////////////////////////////////
#pragma mark - 


NS_ASSUME_NONNULL_BEGIN

/**
 `NIBCalculatorViewController+Helper` is a category that defines helper methods
 for the main controller.
 */
@interface NIBCalculatorViewController (Helpers)

/// -------------
/// @name Helpers
/// -------------

/**
 Count the number of digits of a string including exponent symbol.
 
 @param numStr The number string to count the number of digits.
 
 @return Returns the number of digits in the string.
 */
- (NSUInteger)digitsOfString:(NSString *)numStr;

/**
 Form a string by removing a symbol or symbols according to bitmask of option
 NIBSymbolRemovalOptions
 
 @param numStr  The number string to manipulate.
 @param opts    The bitmask option of NIBSymbolRemovalOptions.
 
 @return Returns the string after removal.
 */
- (NSString *)stringFromString:(NSString *)numStr
           withRevmovalOptions:(NIBSymbolRemovalOptions)opts;

/**
 Switch between arithmetic clear button
 and clear button.
 */
- (void)toggleArithmeticClearButtonOrClearButton;

/**
 A utility function to help action to a group of buttons
 from a buttons collection using their tags as a reference.
 
 @param tags            The array of button tags.
 @param buttons         The buttons collection.
 @param action          The action to add.
 @param controlEvents   The bitmask of control events.
 */
- (void)addToButtonsWithTags:(NSArray<NSNumber *> *)tags
                 fromButtons:(NSArray<NIBButton *> *)buttons
                      action:(SEL)action
             forControlEvent:(UIControlEvents)controlEvents;
@end

NS_ASSUME_NONNULL_END
