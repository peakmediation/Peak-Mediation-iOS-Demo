//
//  ViewController.m
//  Peak Mediation Demo
//
//  Created by Alex Nadein on 8/15/16.
//  Copyright © 2016 Peak Mediation. All rights reserved.
//

#import "ViewController.h"
#import <PeakSDK/PeakSDK.h>
#import <PeakSDK/PeakNativeAd.h>
#import "RenderView.h"

@interface ViewController () <PeakSDKDelegate>

@property (nonatomic, weak) IBOutlet UIView *adSpaceView;
@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) RenderView *renderView;

@end

static NSString * const BannerZoneID = @"78082";
static NSString * const InterstitialZoneID = @"78059";
static NSString * const NativeZoneID = @"78093";

@implementation ViewController

#pragma mark - Actions

- (IBAction)showBannerAction:(id)sender
{
    UIView *banner = [[PeakSDK sharedInstance] showBannerForZone:BannerZoneID];
    
    if (banner != nil)
    {
        [self displayBanner:banner];
    }
}

- (IBAction)showInterstitialAction:(id)sender
{
    [[PeakSDK sharedInstance] showInterstitialForZone:InterstitialZoneID];
}

- (IBAction)showNativeAction:(id)sender
{
    PeakNativeAd *native = [[PeakSDK sharedInstance] showNativeAdForZone:NativeZoneID];
    
    if (native != nil)
    {
        [self displayNative:native];
    }
}

#pragma mark - UIView methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[PeakSDK sharedInstance] setDelegate:self];
}

#pragma mark - Private methods

- (void)displayBanner:(UIView *)banner
{
    [_bannerView removeFromSuperview];
    [[self view] addSubview:banner];
    [self setBannerView:banner];
    
    [banner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:banner
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:[self view]
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.f constant:0.f];
    
    NSLayoutConstraint *horizontalCenter = [NSLayoutConstraint constraintWithItem:banner
                                                                        attribute:NSLayoutAttributeCenterX
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:[self view]
                                                                        attribute:NSLayoutAttributeCenterX
                                                                       multiplier:1.f constant:0.f];
    
    [[self view] addConstraints:@[bottom, horizontalCenter]];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:banner
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.f constant:CGRectGetWidth([banner frame])];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:banner
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.f constant:CGRectGetHeight([banner frame])];
    
    [banner addConstraints:@[width, height]];
}

- (void)displayNative:(PeakNativeAd *)native
{
    RenderView *renderView = [RenderView new];
    
    [renderView setDidShowHandler:^
     {
         [[PeakSDK sharedInstance] trackNativeAdShownForZone:NativeZoneID];
     }];
    
    [renderView setPrivacyActionHandler:^
     {
          [[PeakSDK sharedInstance] handlePrivacyIconClickForZone:NativeZoneID];
     }];
    
    [renderView setActionHandler:^
     {
         [[PeakSDK sharedInstance] handleNativeAdClickForZone:NativeZoneID];
     }];
    
    [self setRenderView:renderView];
    
    [[self adSpaceView] addSubview:renderView];
    
    [renderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [[self adSpaceView] addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:|-[renderView]-|"
                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                 metrics:nil
                                 views:NSDictionaryOfVariableBindings(renderView)]];
    
    [[self adSpaceView] addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|-[renderView]-|"
                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                 metrics:nil
                                 views:NSDictionaryOfVariableBindings(renderView)]];
    
    [renderView renderAd:native];
}

@end