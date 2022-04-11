//
//  NIBCalculatorViewController+Store.m
//  NIBCalculator
//
//  Created by Lieu Vu on 11/16/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "NIBCalculatorViewController+Store.h"
#import "NIBCalculatorViewController+UpdateDisplay.h"
#import "NIBCalculatorBrain.h"
#import "NIBButton.h"
#import "NIBCalculatorLandscapeView.h"
#import "NIBViewUtilities.h"


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Keys Used in Archiving/Unarchiving


/** The last used data file */
static NSString * const NIBLastUsedDataFile = @"LastUsedData.plist";

/** The current number string on the main display. */
static NSString * const NIBLastUsedMainDisplayNumberString = @"NIB Main Display Current Number String";

/** The current memory of the calculator. */
static NSString * const NIBLastUsedCalculatorMemory = @"NIB Calculator Memory";

/** The state to indicate if the functional buttons are toggled. */
static NSString * const NIBLastUsedSecondaryFunctionalButtonsIsToogled = @"NIB Secondary Functional Buttons Toggled";

/** The state to indicate if the angle mode is radian. */
static NSString * const NIBLastUsedAngleModeIsRadian = @"NIB Angle Mode Is Radian";


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Category Implementation


@implementation NIBCalculatorViewController (Store)


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Data Archiving


- (void)archiveData
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [path firstObject];
    NSString *dataPath = [documentsDir stringByAppendingPathComponent:NIBLastUsedDataFile];
    NSMutableDictionary *dictOfData = [[NSMutableDictionary alloc] init];
    
    /* if the main display has result that is not default text */
    if (![self.currentCalculatorView.mainDisplay.text isEqualToString:NIBMainDisplayDefaultText]) {
        [dictOfData setObject:self.currentCalculatorView.mainDisplay.text forKey:NIBLastUsedMainDisplayNumberString];
    } else {
        [dictOfData setObject:[NSNull null] forKey:NIBLastUsedMainDisplayNumberString];
    }
    
    /* if the calculator has memory */
    if (self.calculator.memory) {
        [dictOfData setObject:self.calculator.memory forKey:NIBLastUsedCalculatorMemory];
    } else {
        [dictOfData setObject:[NSNull null] forKey:NIBLastUsedCalculatorMemory];
    }
    
    NIBButton *secondaryFunctionalOperationToggleSwitchBtn = [NIBViewUtilities buttonWithTag:NIBButtonSecondaryFunctionalToggleSwitch fromButtons:self.landscapeCalculatorView.buttons];
    
    /* if secondary functional button toggled */
    if (secondaryFunctionalOperationToggleSwitchBtn.selected) {
        [dictOfData setObject:[NSNumber numberWithBool:YES] forKey:NIBLastUsedSecondaryFunctionalButtonsIsToogled];
    } else {
        [dictOfData setObject:[NSNumber numberWithBool:NO] forKey:NIBLastUsedSecondaryFunctionalButtonsIsToogled];
    }
    
    /* if angle mode is degree mode */
    if ([self.landscapeCalculatorView.secondaryDisplay.text isEqualToString:NIBSecondaryDisplayDefaultText]) {
        [dictOfData setObject:[NSNumber numberWithBool:NO] forKey:NIBLastUsedAngleModeIsRadian];
    } else {
        [dictOfData setObject:[NSNumber numberWithBool:YES] forKey:NIBLastUsedAngleModeIsRadian];
    }

    [[NSKeyedArchiver archivedDataWithRootObject:dictOfData
                           requiringSecureCoding:NO error:nil]
     writeToFile:dataPath
     atomically:YES];
}


/////////////////////////////////////////////////////////////////////////////
#pragma mark - Data Unarchiving


- (void)readArchive
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dataPath = [[path firstObject] stringByAppendingPathComponent:NIBLastUsedDataFile];
    NSData *data =  [NSData  dataWithContentsOfFile:dataPath];
    data = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSMutableDictionary class] fromData:data error:nil];
    
    id obj;
    
    /* restore last used main display number string */
    obj = [data valueForKey:NIBLastUsedMainDisplayNumberString];
    if (obj != [NSNull null] && [obj isKindOfClass:[NSString class]]) {
        [self updateMainDisplaysWithString:(NSString *)obj];
    }
    
    /* restore last used calculator memory */
    obj = [data valueForKey:NIBLastUsedCalculatorMemory];
    if (obj != [NSNull null] && [obj isKindOfClass:[NSNumber class]]) {
        
        NIBButton *memoryReadBtn = [NIBViewUtilities buttonWithTag:NIBButtonMemoryRead
                                                       fromButtons:self.landscapeCalculatorView.buttons];
        
        [self.calculator addToMemory:[(NSNumber *)obj doubleValue]];
        [memoryReadBtn toggleEffect];
    }
    
    /* restore secondary functional operation toggle switch state */
    obj = [data valueForKey:NIBLastUsedSecondaryFunctionalButtonsIsToogled];
    if ([obj isKindOfClass:[NSNumber class]] && [(NSNumber *)obj boolValue]) {
        NIBButton *secondaryFunctionalOperationToggleSwitchBtn = [NIBViewUtilities buttonWithTag:NIBButtonSecondaryFunctionalToggleSwitch
                                                                                     fromButtons:self.landscapeCalculatorView.buttons];
        
        [secondaryFunctionalOperationToggleSwitchBtn toggleEffect];
        [self.landscapeCalculatorView toggleSecondaryFunctionalButtons];
    }
    
    /* restore last used angle mode */
    obj = [data valueForKey:NIBLastUsedAngleModeIsRadian];
    if ([obj isKindOfClass:[NSNumber class]] && [(NSNumber *)obj boolValue] ) {
        NIBButton *radianBtn = [NIBViewUtilities buttonWithTag:NIBButtonRad
                                                   fromButtons:self.landscapeCalculatorView.buttons];
        
        /* toggle radian mode */
        [self.landscapeCalculatorView toggleAngleMode];
        self.landscapeCalculatorView.secondaryDisplay.text = radianBtn.titleLabel.text;
    }
}

@end
