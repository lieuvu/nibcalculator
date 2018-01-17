//
//  NIBCalculatorViewController+UpdateDisplay.h
//  NIBCalculator
//
//  Created by Lieu Vu on 11/15/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIBCalculatorViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `NIBCalculatorViewController+UpdateDisplay` is a category that updates the
 results on the main display.
 */
@interface NIBCalculatorViewController (UpdateDisplay)

/// --------------------
/// @name Update Display
/// --------------------

/**
 Update main displays in both views with a number object
 limited to maximum displayable digits.
 
 @param number      The number object to display.
 @param maxDigits   The maximum digits of a number to display.
 */
- (void)updateMainDisplaysWithNumber:(NSNumber *)number
                maxDisplayableDigits:(NSUInteger)maxDigits;

/**
 Update main displays in both views with a number string.
 
 @param numStr  The number string to display.
 */
- (void)updateMainDisplaysWithString:(NSString *)numStr;

/**
 Update main displays in portrait with a number object
 limited to maximum displayable digits.
 
 @param number      The number object to display.
 @param maxDigits   The maximum digits of a number to display.
 */
- (void)updateMainDisplayOfPortraitCalculatorViewWithNumber:(NSNumber *)number
                                       maxDisplayableDigits:(NSUInteger)maxDigits;

/**
 Update main displays in landscape with a number object
 limited to maximum displayable digits.
 
 @param number      The number object to display.
 @param maxDigits   The maximum digits of a number to display.
 */
- (void)updateMainDisplayOfLandscapeCalculatorViewWithNumber:(NSNumber *)number
                                        maxDisplayableDigits:(NSUInteger)maxDigits;

@end

NS_ASSUME_NONNULL_END
