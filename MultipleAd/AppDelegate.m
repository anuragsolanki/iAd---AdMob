//
//  AppDelegate.m
//  MultipleAd
//
//  Created by Anurag Solanki on 20/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
{
    UIViewController<BannerViewContainer> *_currentController;
    ADBannerView *_bannerView;
    GADBannerView *_admobBannerView;
}
@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    // The ADBannerView will fix up the given size, we just want to ensure it is created at a location off the bottom of the screen.
    // This ensures that the first animation doesn't come in from the top of the screen.
    _bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, bounds.size.height, 0.0, 0.0)];
    _bannerView.delegate = self;
    
    //    _currentController = nil; // top most controller is not a banner container, so this starts out nil.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    _currentController = (UIViewController<BannerViewContainer> *)[[navigationController viewControllers] objectAtIndex:0];
    navigationController.delegate = self;
    
    // Override point for customization after application launch.
    return YES;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [_currentController showBannerView:banner animated:YES];
}

//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    [_currentController hideBannerView:_bannerView animated:YES];
//}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
    // 1
    //    [_bannerView removeFromSuperview];
    [_currentController hideBannerView:_bannerView animated:YES];
    
    // 2
    CGRect bounds = [[UIScreen mainScreen] bounds];
    _admobBannerView = [[GADBannerView alloc]
                        initWithFrame:CGRectMake(0.0,bounds.size.height,
                                                 GAD_SIZE_320x50.width,
                                                 GAD_SIZE_320x50.height)];
    
    // 3
    _admobBannerView.adUnitID = @"a14ec3f0a2028f2"; ///////NEED TO CHANGE UNIT ID
    _admobBannerView.rootViewController = _currentController;
    _admobBannerView.delegate = self;
    
    // 4
    //    [self.view addSubview:_admobBannerView];
    //    [self.admobBannerView loadRequest:[GADRequest request]];
    
    [_currentController showAdMobBannerView:_admobBannerView animated:YES];
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    [_admobBannerView removeFromSuperview];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    _currentController = [viewController respondsToSelector:@selector(showBannerView:animated:)] ? (UIViewController<BannerViewContainer> *)viewController : nil;
    if (_bannerView.bannerLoaded && (_currentController != nil)) {
        [(UIViewController<BannerViewContainer> *)viewController showBannerView:_bannerView animated:NO];
    }
}

//////////////////////

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
