//
//  PeakDelegate.h
//  Peak Mediation Demo
//
//  Created by Alex Nadein on 11/11/16.
//  Copyright © 2016 Peak Mediation. All rights reserved.
//

#import <PeakSDK/PeakSDK.h>

@interface PeakDelegate : NSObject <PeakSDKDelegate>

- (instancetype)initWithPresenterViewController:(UIViewController *)viewController;

@end
