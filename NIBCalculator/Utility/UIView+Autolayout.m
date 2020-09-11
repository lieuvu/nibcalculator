//
//  UIView+Autolayout.m
//  NIBCalculator
//
//  Created by Lieu Vu on 8/16/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "UIView+Autolayout.h"

@implementation UIView (Autolayout)


+ (id)autolayoutView
{
    UIView *view = [[[self class] alloc] init];
    
    if (view) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return view;
}

@end
