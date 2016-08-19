//
//  RenderView.h
//  Peak Mediation Demo
//
//  Created by Alex Nadein on 8/15/16.
//  Copyright © 2016 Peak Mediation. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PeakNativeAd;

typedef void (^DMPKRenderViewActionHandler)();
typedef void (^DMPKRenderViewPrivacyActionHandler)();
typedef void (^DMPKRenderViewDidShowHandler)();

@interface RenderView : UIView

@property(strong, nonatomic) DMPKRenderViewActionHandler actionHandler;
@property(strong, nonatomic) DMPKRenderViewPrivacyActionHandler privacyActionHandler;
@property(strong, nonatomic) DMPKRenderViewDidShowHandler didShowHandler;

- (void)renderAd:(PeakNativeAd *)ad;

@end
