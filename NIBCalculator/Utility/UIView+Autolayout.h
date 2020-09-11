//
//  UIView+Autolayout.h
//  NIBCalculator
//
//  Created by Lieu Vu on 8/16/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 `UIView+Autolayout` is a category of class `UIView` to create autolayout of
 objects of type.
 
 Examples:
 
    UIButton *button = [UIButton autolayout];
    UIView *view = [UIView autolayout];
 
 */
@interface UIView (Autolayout)

/// --------------------
/// @name Initialization
/// --------------------

/**
 Create and return autolayout UIView.
 */
+ (id _Nullable)autolayoutView;

@end

NS_ASSUME_NONNULL_END
