//
//  AppDelegate.m
//  Peak Mediation Demo
//
//  Created by Alex Nadein on 8/15/16.
//  Copyright © 2016 Peak Mediation. All rights reserved.
//

#import "AppDelegate.h"
#import <PeakSDK/PeakSDK.h>

@interface AppDelegate ()

@end

static NSString * const PeakAppID = @"e2768f95b86df8bd";
static NSUInteger const UserAge = 21;
static PKTargetGender const UserGender = PKTargetGenderMale;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[PeakSDK sharedInstance] setTargetingAge:UserAge];
    [[PeakSDK sharedInstance] setTargetingGender:UserGender];
    [[PeakSDK sharedInstance] configureWithAppId:PeakAppID];
    return YES;
}

@end
