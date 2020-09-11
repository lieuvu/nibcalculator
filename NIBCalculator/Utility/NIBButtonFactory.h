//
//  NIBButtonFactory.h
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIFont;

NS_ASSUME_NONNULL_BEGIN

/**
 `NIBButtonFactory` is a class to create buttons of type `NIBButton`.
 
 @note The class can not be instantiated and will generate an __error__ if doing
 so. The class includes only class methods.
 */
@interface NIBButtonFactory : NSObject

/// -------------------------
/// @name Unavailable Methods
/// -------------------------

/**
 The init method is not available.
 */
- (instancetype) init __attribute__((unavailable("utility class")));

/// ---------------------
/// @name Factory Methods
/// ---------------------

/**
 Add digit and decimal separator buttons (0-9, decimal separator "." or ","
 based on current locale) with a font to a collection of buttons .
 
 @param font    The font of digit and decimal buttons.
 @param buttons The collection of buttons.
 */
+ (void)addDigitAndDecimalSeparatorButtonsWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons;

/**
 Add  arithmetic operation buttons (÷, ×, -, +, =) with a font to a collection
 of buttons.
 
 @param font    The font of arithmetic operation buttons.
 @param buttons The collection of buttons.
 */
+ (void)addArithmeticOperationButtonsWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons;

/**
 Add other common buttons (AC, C, +/-, %) with a font to a collection of
 buttons.
 
 @param font    The font of main buttons.
 @param buttons The collection of buttons.
 */
+ (void)addOtherCommonButtonsWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons;

/**
 Add  text representable functional buttons in landscape with a font to a
 collection of buttons.
 
 @param font    The font of text representable functional buttons in landscape.
 @param buttons The collection of buttons.
 */
+ (void)addTextRepresentableFunctionalButtonsInLandscapeWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons ;

/**
 Add  special functional buttons in landscape with a font to a collection of
 buttons.
 
 @param font    The font of special text representable functional buttons in
                landscape.
 @param buttons The collection of buttons.
 */
+ (void)addSpecialTextRepresentableFuncionalButtonsInLandscapeWithFont:(UIFont *)font toButtons:(NSMutableArray *)buttons ;

@end

NS_ASSUME_NONNULL_END
