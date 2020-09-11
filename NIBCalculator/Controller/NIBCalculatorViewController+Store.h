//
//  NIBCalculatorViewController+Store.h
//  NIBCalculator
//
//  Created by Lieu Vu on 11/16/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIBCalculatorViewController.h"

/**
 `NIBCalculatorViewController+Store` is a category that handles the
 archiving/unarchiving of the data of the calcualtor.
 */
@interface NIBCalculatorViewController (Store)

/// --------------------
/// @name Data Archiving
/// --------------------

/**
 Archive current data of view controller to file. The data includes state of
 the view such as current display of result on screen and the model data.
 */
- (void)archiveData;

/// ----------------------
/// @name Data Unarchiving
/// ----------------------

/**
 Read data from the last used data file. The file includes data of states of
 the view such as current display of result on screen and the model data.
 The key used to access the data object is
 */
- (void)readArchive;

@end
