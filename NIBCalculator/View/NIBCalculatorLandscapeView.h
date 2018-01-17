//
//  NIBLandscapeCalculatorView.h
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIBCalculatorViewProtocol.h"

@class NIBButton;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Constants

/** Default string on secondary display. */
FOUNDATION_EXPORT NSString *_Nonnull const NIBSecondaryDisplayDefaultText;


/////////////////////////////////////////////////////////////////////////////
#pragma mark -


NS_ASSUME_NONNULL_BEGIN

/**
 `NIBCalculatorLandscapeView` is a class that create a landscape view of the
 calculator.
 */
@interface NIBCalculatorLandscapeView : UIView <NIBCalculatorViewProtocol>

/// ----------------
/// @name Properties
/// ----------------

/** Secondary display to show Deg or Rad mode in landscape. */
@property (readonly, strong, nonatomic) UILabel *secondaryDisplay;

/// --------------------
/// @name Initialization
/// --------------------

/**
 Create an instance of landscape calculator view.
 */
+ (instancetype)calculatorView;

/// ---------------
/// @name Utilities
/// ---------------

/**
 Toggle secondary functional buttons on the button board
 of landscape calculator.
 */
- (void)toggleSecondaryFunctionalButtons;

/**
 Toggle angle mode Rad <-> Deg.
 */
- (void)toggleAngleMode;

@end

NS_ASSUME_NONNULL_END
