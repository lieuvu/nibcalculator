//
//  NIBButton.h
//  NIBCalculator
//
//  Created by Lieu Vu on 9/8/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIBConstants.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Types, Enumeration and Options

/** The enumeration to indicate if the button's type is superscript or subscript. */
typedef NS_ENUM(NSUInteger, NIBButtonSubcriptSuperscriptType) {
    /** The superscript button type. */
    NIBButtonTypeSuperscript,
    /** The subscript button type. */
    NIBButtonTypeSubscript
};


/////////////////////////////////////////////////////////////////////////////
#pragma mark -


NS_ASSUME_NONNULL_BEGIN

/**
 `NIBButton` is a class that initializes a button of the calculator and assigns
 a tag of `NIBButtonTag` for the button as well as set some custom effects of
 the button. Based on the type of the button, the class may draw extra parts
 for the buttons when necessary.
 */
@interface NIBButton : UIButton

/// --------------------
/// @name Initialization
/// --------------------

/**
 Create a button with a label title and tag.
 
 @param title   The button title.
 @param font    The title font.
 @param tag     The button tag defined in NIBButtonTag enumeration.
 
 @return Returns a NIBButton instance.
 */
- (instancetype)initWithLabelTitle:(NSString *)title
                              font:(UIFont *)font
                               tag:(NIBButtonTag)tag;

/**
 Create a special button with a label title, extra part, type and a tag.
 
 @param title       The button title.
 @param font        The title font.
 @param extraPart   The extra part.
 @param type        The button type defined in NIBButtonSubcriptSuperscriptType.
 @param tag         The button tag defined in NIBButtonTag enumeration.
 
 @return Returns a NIBButton instance with extra part as superscript or subscript.
 */
- (instancetype)initWithLabelTitle:(NSString *)title
                              font:(UIFont *)font
                         extraPart:(NSString *)extraPart
                              type:(NIBButtonSubcriptSuperscriptType)type
                               tag:(NIBButtonTag)tag;

/**
 Create a special button with a label title, root and a tag.
 
 @param title   The button title.
 @param font    The title font.
 @param root    The root.
 @param tag     The button tag defined in NIBButtonTag enumeration.
 
 @return Returns a NIBButton instance with square sign root and root number.
 */
- (instancetype)initWithLabelTitle:(NSString *)title
                              font:(UIFont *) font
                              root:(NSString *)root
                               tag:(NIBButtonTag)tag;

/**
 Create a special button with a label title as denominator, numerator
 and a tag.
 
 @param denominator The denominator of the fraction.
 @param font        The title font.
 @param numerator   The numerator of the fraction.
 @param tag         The button tag defined in NIBButtonTag enumeration.
 
 @return Returns a NIBButton instance displayed as fraction with label title
 as denominator.
 */
- (instancetype)initWithLabelTitleAsDenominator:(NSString *)denominator
                                           font:(UIFont *)font
                                      numerator:(NSString *)numerator
                                            tag:(NIBButtonTag)tag;

/// --------------------------
/// @name Custom Button Effect
/// --------------------------

/**
 To set background and highlighted background of a button.
 
 @param background              The normal background of a button.
 @param highlightedBackground   The highlighted background of a button.
 */
- (void)setBackground:(UIColor *)background highlightedBackground:(UIColor *)highlightedBackground;

/**
To set the border width and border color of a button.

@param width    The border width of the button.
@param color    The border color of the button.
*/
- (void)setBorderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 To set the border width and border color of a button to have effect
 when a button is selected.
 
 @param width    The border width of the button.
 @param color    The border color of the button.
 */
- (void)setSelectedEffectBorderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 Toggle effect when a button is selected by changing to selected
 effect border width and color.
 */
- (void)toggleEffect;

@end

NS_ASSUME_NONNULL_END
