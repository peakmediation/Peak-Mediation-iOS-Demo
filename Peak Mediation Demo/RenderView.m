//
//  RenderView.m
//  Peak Mediation Demo
//
//  Created by Alex Nadein on 8/15/16.
//  Copyright © 2016 Peak Mediation. All rights reserved.
//

#import "RenderView.h"
#import <PeakSDK/PeakNativeAd.h>

@interface RenderView ()

@property(strong, nonatomic) UILabel *title;
@property(strong, nonatomic) UILabel *text;
@property(strong, nonatomic) UILabel *sponsored;
@property(strong, nonatomic) UIImageView *icon;
@property(strong, nonatomic) UIImageView *mainImage;
@property(strong, nonatomic) UIButton *privacyAction;
@property(strong, nonatomic) UIButton *action;
@property(strong, nonatomic) UIButton *close;

@end

@implementation RenderView

- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        [self setupViews];
        [self setupLayout];
    }
    
    return self;
}

- (void)renderAd:(PeakNativeAd *)ad
{
    [_title setText:[ad title]];
    [_text setText:[ad text]];
    [_icon setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[ad icon]]]];
    [_mainImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[ad mainImage]]]];
    [_privacyAction setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[ad privacyIcon]]] forState:UIControlStateNormal];
    [_action setTitle:[ad callToActionText] forState:UIControlStateNormal];
    
    if (_didShowHandler != nil)
    {
        _didShowHandler();
    }
    
    [self setNeedsLayout];
}

#pragma mark - Private

- (void)setupViews
{
    [self setBackgroundColor:[UIColor lightGrayColor]];
    
    
    _close = [UIButton buttonWithType:UIButtonTypeSystem];
    [_close setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_close setTitle:@"Close ╳" forState:UIControlStateNormal];
    [_close setTintColor:[UIColor redColor]];
    [_close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_close];
    
    _title = [UILabel new];
    [_title setFont:[UIFont boldSystemFontOfSize:14.f]];
    [_title setNumberOfLines:0];
    [_title setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_title];
    
    _sponsored = [UILabel new];
    [_sponsored setFont:[UIFont systemFontOfSize:12.f]];
    [_sponsored setNumberOfLines:0];
    [_sponsored setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sponsored setText:@"Sponsored"];
    [_sponsored setTextColor:[UIColor darkGrayColor]];
    [self addSubview:_sponsored];
    
    _icon = [UIImageView new];
    [_icon setBackgroundColor:[UIColor grayColor]];
    [_icon setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_icon];
    
    _text = [UILabel new];
    [_text setFont:[UIFont systemFontOfSize:14.f]];
    [_text setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_text setNumberOfLines:0];
    [self addSubview:_text];
    
    _mainImage = [UIImageView new];
    [_mainImage setBackgroundColor:[UIColor grayColor]];
    [_mainImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_mainImage];
    
    _action = [UIButton buttonWithType:UIButtonTypeSystem];
    [_action setTintColor:[UIColor orangeColor]];
    [_action setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_action addTarget:self action:@selector(performAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_action];
    
    _privacyAction = [UIButton buttonWithType:UIButtonTypeSystem];
    [_privacyAction setTintColor:[UIColor orangeColor]];
    [_privacyAction setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_privacyAction addTarget:self action:@selector(performPrivacyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_privacyAction];
}

- (void)setupLayout
{
    // Vertical
    static const CGFloat statusBarHeight = 20.f;
    static const CGFloat closeHeight = 16.f;
    static const CGFloat iconHeight = 30.f;
    static const CGFloat mainImageHeight = 120.f;
    static const CGFloat actionHeight = 30.f;
    static const CGFloat privacyActionHeight = 30.f;
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-statusBarHeight-[_close(==closeHeight)]-[_title(>=iconHeight)]-[_text]-[_mainImage(==mainImageHeight)]-[_action(==actionHeight)]"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:@{@"iconHeight" : @(iconHeight),
                                    @"statusBarHeight" : @(statusBarHeight),
                                    @"closeHeight" : @(closeHeight),
                                    @"mainImageHeight" : @(mainImageHeight),
                                    @"actionHeight" : @(actionHeight)}
                          views:NSDictionaryOfVariableBindings(_close, _title, _text, _mainImage, _action, _privacyAction)]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:[_icon(==iconHeight)]"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:@{@"iconHeight" : @(iconHeight)}
                          views:NSDictionaryOfVariableBindings(_icon)]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_icon
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:_title
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0
                         constant:0]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:[_sponsored(==iconHeight)]"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:@{@"iconHeight" : @(iconHeight)}
                          views:NSDictionaryOfVariableBindings(_sponsored)]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_sponsored
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:_title
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_action
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationLessThanOrEqual
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_action
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationLessThanOrEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1.0
                         constant:iconHeight]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:[_privacyAction(==privacyActionHeight)]"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:@{@"privacyActionHeight" : @(privacyActionHeight)}
                          views:NSDictionaryOfVariableBindings(_privacyAction)]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_privacyAction
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:_action
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0
                         constant:0]];
    
    // Horizontal
    static const CGFloat iconWidth = 30.f;
    static const CGFloat iconAndTitleHorizontalOffset = 8.f;
    static const CGFloat privacyActionWidth = 30.f;
    static const CGFloat privacyActionAndActionHorizontalOffset = 8.f;
    static const CGFloat sponsoredWidth = 70.f;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_close
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0
                         constant:0]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-[_icon(==iconWidth)]-iconAndTitleHorizontalOffset-[_title]-[_sponsored(==sponsoredWidth)]-|"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:@{@"iconWidth" : @(iconWidth),
                                    @"iconAndTitleHorizontalOffset" : @(iconAndTitleHorizontalOffset),
                                    @"sponsoredWidth" : @(sponsoredWidth)}
                          views:NSDictionaryOfVariableBindings(_icon, _title, _sponsored)]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-[_text]-|"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:nil
                          views:NSDictionaryOfVariableBindings(_text)]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_mainImage
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_mainImage
                         attribute:NSLayoutAttributeCenterX
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterX
                         multiplier:1.0
                         constant:0]];
    
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-[_privacyAction(==privacyActionWidth)]-privacyActionAndActionHorizontalOffset-[_action]-|"
                          options:NSLayoutFormatDirectionLeadingToTrailing
                          metrics:@{@"privacyActionWidth" : @(privacyActionWidth),
                                    @"privacyActionAndActionHorizontalOffset" : @(privacyActionAndActionHorizontalOffset)}
                          views:NSDictionaryOfVariableBindings(_privacyAction, _action)]];
}

- (void)close:(id)sender
{
    [self removeFromSuperview];
}

- (void)performAction:(id)sender
{
    if (_actionHandler != nil)
    {
        _actionHandler();
    }
}

- (void)performPrivacyAction:(id)sender
{
    if (_privacyActionHandler != nil)
    {
        _privacyActionHandler();
    }
}

@end

