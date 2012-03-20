//
//  ViewController.m
//  MultipleAd
//
//  Created by Anurag Solanki on 20/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    ADBannerView *_bannerView;
    GADBannerView *_adMobBannerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self layoutAnimated:NO];
    
    //    [self bannerView:self.bannerView didFailToReceiveAdWithError:nil]; // FORCEFULLY FAIL iAD
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)layoutAnimated:(BOOL)animated
{
    //    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
    _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    //    } else {
    //        _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
    //    }
    
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = _bannerView.frame;
    if (_bannerView.bannerLoaded) {
        contentFrame.size.height -= _bannerView.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        //        self.view.frame = contentFrame;
        //        [self.view layoutIfNeeded];
        _bannerView.frame = bannerFrame;
    }];
}

- (void)showBannerView:(ADBannerView *)bannerView animated:(BOOL)animated
{
    _bannerView = bannerView;
    [self.view addSubview:_bannerView];
    [self layoutAnimated:animated];
}

- (void)hideBannerView:(ADBannerView *)bannerView animated:(BOOL)animated
{
    _bannerView = nil;
    [self layoutAnimated:animated];
}

- (void)showAdMobBannerView:(GADBannerView *)bannerView animated:(BOOL)animated
{
    _adMobBannerView = bannerView;
    [self.view addSubview:bannerView];
    [bannerView loadRequest:[GADRequest request]];
    
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = _adMobBannerView.frame;
    contentFrame.size.height -= _adMobBannerView.frame.size.height;
    bannerFrame.origin.y = contentFrame.size.height;
    _adMobBannerView.frame = bannerFrame;
    //    [self layoutAnimated:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
