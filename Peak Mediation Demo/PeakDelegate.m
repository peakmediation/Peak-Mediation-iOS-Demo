//
//  PeakDelegate.m
//  Peak Mediation Demo
//
//  Created by Alex Nadein on 11/11/16.
//  Copyright © 2016 Peak Mediation. All rights reserved.
//

#import "PeakDelegate.h"

@interface PeakDelegate ()

@property(nonatomic, weak) UIViewController *presenter;

@end

@implementation PeakDelegate

- (instancetype)initWithPresenterViewController:(UIViewController *)viewController
{
    self = [super init];
    
    if (self != nil)
    {
        [self setPresenter:viewController];
    }
    
    return self;
}

#pragma mark - PeakSDKDelegate

- (void)didCompleteInitialization
{
    // SDK initialized successfully
}

- (void)didFailInitializationWithError:(NSError *)error
{
    // Something went wrong during initializing. Check the error object for details.
}

- (void)didShowBannerInZone:(NSString *)zoneID
{
    // Banner successfully shown
}

- (void)didFailToShowBannerInZone:(NSString *)zoneID withError:(NSError *)error
{
    // Something went wrong. Check the error object for details
}

- (void)didShowInterstitialInZone:(NSString *)zoneID
{
    // Interstitilal successfully shown
}

- (void)didFailToShowInterstitialInZone:(NSString *)zoneID withError:(NSError *)error
{
    // Something went wrong. Check the error object for details
}

- (void)didCloseInterstitialInZone:(NSString *)zoneID
{
    // Interstitilal was closed
}

- (void)didCompleteRewardExperienceInZone:(NSString *)zoneID
{
    // User can obtain his reward
}

- (void)didShowNativeInZone:(NSString *)zoneID
{
    // Native ad successfully shown
}

- (void)didFailToShowNativeInZone:(NSString *)zoneID withError:(NSError *)error
{
    // Something went wrong. Check the error object for details
}

@end
