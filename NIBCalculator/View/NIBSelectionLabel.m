//
//  NIBSelectedLabel.m
//  NIBCalculator
//
//  Created by Lieu Vu on 10/19/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBSelectionLabel.h"
#import "UIView+Autolayout.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Constants


/** Corner radius of the selected label. */
static const CGFloat NIBCornerRadius = 10.0f;

/** Background white of the selected label. */
static const CGFloat NIBBackgroundWhite = 0.85f;

/** Background alpha of the selected label. */
static const CGFloat NIBBackgroundAlpha = 0.25f;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation


@implementation NIBSelectionLabel

+ (instancetype)label
{
    NIBSelectionLabel *selectedLabel = [self autolayoutView];
    
    selectedLabel.layer.cornerRadius = NIBCornerRadius;
    selectedLabel.layer.masksToBounds = YES;
    selectedLabel.backgroundColor = [UIColor colorWithWhite:NIBBackgroundWhite alpha:NIBBackgroundAlpha];
    
    return selectedLabel;
}

@end
