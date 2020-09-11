//
//  NIBSelectionLabel.h
//  NIBCalculator
//
//  Created by Lieu Vu on 10/19/17.
//  Copyright © 2017 LV. All rights reserved.
//

/**
 `NIBSelectionLabel` is a class that create a selection label when the main
 display of the calculator is selected.
 
 @note The class can not be instantiated and will generate an __error__ if doing
 so. The class includes only class methods.
 */

#import <UIKit/UIKit.h>

@interface NIBSelectionLabel : UILabel

/// -------------------------
/// @name Unavailable Methods
/// -------------------------

/**
 The init method is not available.
 */
- (instancetype) init __attribute__((unavailable("utility class")));

/// --------------------
/// @name Initialization
/// --------------------

/**
 Create a selected label.
 */
+ (instancetype)label;

@end
