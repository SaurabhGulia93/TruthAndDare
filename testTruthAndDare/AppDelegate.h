//
//  AppDelegate.h
//  testTruthAndDare
//
//  Created by unibera1 on 8/14/13.
//  Copyright (c) 2013 unibera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "Appirater.h"
#import "FlurryAds.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

+(NSManagedObjectContext *)getcontext;
+ (void) populateDrugsInManagedObjectContext:(NSManagedObjectContext *)context;

@end
