//
//  AppDelegate.m
//  NIBCalculator
//
//  Created by Lieu Vu on 9/24/17.
//  Copyright © 2017 LV. All rights reserved.
//

#import "AppDelegate.h"
#import "NIBCalculatorViewController+Store.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication * __unused)application didFinishLaunchingWithOptions:(NSDictionary * __unused)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [[NIBCalculatorViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication * __unused)application
{
    NIBCalculatorViewController *viewController = nil;
    
    if ([self.window.rootViewController isKindOfClass:[NIBCalculatorViewController class]]) {
        viewController = (NIBCalculatorViewController *)self.window.rootViewController;
    }
    
    [viewController archiveData];
}

@end
