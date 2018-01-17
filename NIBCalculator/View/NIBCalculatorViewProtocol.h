//
//  NIBDisplayFontAdjustment.h
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

/**
 `NIBCalculatorViewProtocol` defines common properties and methods for both
 portrait and landscape calculator views. It is adopted by
 class `NIBCalculatorPortraitView` and class `NIBCalculatorLandscapeView`.
 */

@class NIBButton;

@protocol NIBCalculatorViewProtocol

/// ----------------
/// @name Properties
/// ----------------

/** Buttons of a calculator. */
@property (readonly, strong, nonatomic) NSArray<NIBButton *> *buttons;

/** Main display of a calculator. */
@property (readonly, strong, nonatomic) UILabel *mainDisplay;

/** Boolean value indicates whether the main display of the calculator needs adjustment. */
@property (readonly, assign, nonatomic) BOOL mainDisplayNeedsAdjustment;

/// --------------------
/// @name Common Methods
/// --------------------

/**
 Set the main display adjustment if it is adjusted.
 */
- (void)setMainDisplayAdjustment;

/**
 Toggle arithmetic clear button or clear button.
 */
- (void)toggleArithmeticClearButtonOrClearButton;

@end
