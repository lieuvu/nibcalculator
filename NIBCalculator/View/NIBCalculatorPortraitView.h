//
//  NIBPortraitCalculatorView.h
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

/**
 `NIBCalculatorPortraitView` is a class that create a portrait view of the
 calculator.
 */

#import <UIKit/UIKit.h>
#import "NIBCalculatorViewProtocol.h"

@class NIBButton;

NS_ASSUME_NONNULL_BEGIN

@interface NIBCalculatorPortraitView : UIView <NIBCalculatorViewProtocol>

/// --------------------
/// @name Initialization
/// --------------------

/**
 Create an instance of portrait calculator view.
 */
+ (instancetype)calculatorView;

@end

NS_ASSUME_NONNULL_END
