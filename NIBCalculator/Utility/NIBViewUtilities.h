//
//  NIBButtonUtilities.h
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIBButton.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `NIBViewUtilities` provides utilities methods to deal with views of the
 application.
 
 @note The class can not be instantiated and will generate an __error__ if doing
 so. The class includes only class methods.
 */
@interface NIBViewUtilities : NSObject

/// -------------------------
/// @name Unavailable Methods
/// -------------------------

/**
 The init method is unavailable.
 */
- (instancetype) init __attribute__((unavailable("utility class")));

/// ---------------------
/// @name Utility Methods
/// ---------------------

/**
 Get a button with a tag from a collection of buttons.
 
 @param tag     The button tag.
 @param buttons The collection of buttons.
 */
+ (NIBButton *_Nullable)buttonWithTag:(NIBButtonTag)tag fromButtons:(NSArray<NIBButton *> *)buttons;

/**
 Adjust font size of main display of a calcualtor view. The adjustment is
 made according to a height of the main display.
 
 @param mainDisplay     The main display of the calculator view.
 */
+ (void)adjustFontSizeOfMainDisplay:(UILabel *)mainDisplay;

/**
 Toggle hidden buttons of a row based on a reference dictionary.
 It will show the first group buttons and hide the second group
 buttons if they are hidden and shown respectively. Otherwise,
 it will hide the first group buttons and show the second group
 buttons if they are shown and hidden respectively.
 
 @param row         The row to toggle hidden buttons.
 @param reference   The reference dictionary of <firstGroupBtnTag, secondGroupBtnTag>.
 */
+ (void)toggleHiddenButtonsOfRow:(UIStackView *)row
                basedOnReference:(NSDictionary<NSNumber *,NSNumber *> *)reference;

@end

NS_ASSUME_NONNULL_END
