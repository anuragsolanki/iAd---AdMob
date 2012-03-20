//
//  AppDelegate.h
//  MultipleAd
//
//  Created by Anurag Solanki on 20/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"


@protocol BannerViewContainer <NSObject>

- (void)showBannerView:(ADBannerView *)bannerView animated:(BOOL)animated;
- (void)hideBannerView:(ADBannerView *)bannerView animated:(BOOL)animated;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate, GADBannerViewDelegate, ADBannerViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
