//
//  NIBButtonUtilities.m
//  NIBCalculator
//
//  Created by Lieu Vu on 9/25/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBViewUtilities.h"
#import "NIBButton.h"

/////////////////////////////////////////////////////////////////////////////
#pragma mark - Private Constants


/** Mininmum font size of main label of display. */
const CGFloat NIBDisplayMainLabelMinFontSize = 1.0f;

/** Maximum font size of main label of display */
const CGFloat NIBDisplayMainLabelMaxFontSize = 100.0f;


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Class Implementation


@implementation NIBViewUtilities

+ (NIBButton *)buttonWithTag:(NIBButtonTag)tag fromButtons:(NSArray<NIBButton *> *)buttons
{
    /* if button tag is found in the buttons, return the button */
    for (NIBButton *btn in buttons) {
        if (btn.tag == tag) {
            return btn;
        }
    }
    
    /* otherwise, return nil */
    NSLog(@"Button with tag number:%ld nof found!", (long)tag);
    return nil;
}

+ (void)adjustFontSizeOfMainDisplay:(UILabel *)mainDisplay
{
    UIFont *adaptiveFont = nil;
    CGFloat minFontSize = NIBDisplayMainLabelMinFontSize;
    CGFloat maxFontSize = NIBDisplayMainLabelMaxFontSize;
    CGFloat midFontSize = 0.0f;
    CGFloat mainDisplayHeight = mainDisplay.frame.size.height;
    CGFloat heightDifference = 0.0f;
    
    while (minFontSize <= maxFontSize) {
        @autoreleasepool {
            midFontSize = minFontSize + (maxFontSize - minFontSize)/2;
            adaptiveFont = [mainDisplay.font fontWithSize:midFontSize];
            heightDifference = mainDisplayHeight - [mainDisplay.text sizeWithAttributes:@{NSFontAttributeName : adaptiveFont}].height;
            
            if (midFontSize == minFontSize || midFontSize == maxFontSize) {
                break;
            }
            
            if (heightDifference < 0) {
                maxFontSize = midFontSize - 1;
            } else if (heightDifference > 0) {
                minFontSize = midFontSize + 1;
            } else {
                break;
            }
        }
    }
    
    mainDisplay.font = [mainDisplay.font fontWithSize:midFontSize];
}

+ (void)toggleHiddenButtonsOfRow:(UIStackView *)row
                basedOnReference:(NSDictionary<NSNumber *,NSNumber *> *)reference
{
    
    /* hide shown button and show hidden buttons */
    for (NSUInteger i = 0; i < row.arrangedSubviews.count; i++) {
        [reference enumerateKeysAndObjectsUsingBlock:^(NSNumber *firstGroupBtnTag, NSNumber *secondGroupBtnTag, BOOL *stop) {
            if (row.arrangedSubviews[i].tag == firstGroupBtnTag.integerValue) {
                NIBButton *firstGroupBtn = [self buttonWithTag:firstGroupBtnTag.integerValue
                                                   fromButtons:row.arrangedSubviews];
                NIBButton *secondGroupBtn = [self buttonWithTag:secondGroupBtnTag.integerValue
                                                    fromButtons:row.arrangedSubviews];
                firstGroupBtn.hidden = !firstGroupBtn.hidden;
                secondGroupBtn.hidden = !secondGroupBtn.hidden;
                *stop = YES;
            }
        }];
    }
}

@end
