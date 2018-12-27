//
//  MobFoxInterstitialCustomEventAdMob.m
//  BannerExample
//
//  Created by Itamar Nabriski on 11/3/15.
//  Copyright © 2015 Google. All rights reserved.
//

#import "MobFoxInterstitialCustomEventAdMob.h"

#define TEST_DEVICES ""

@interface MobFoxInterstitialCustomEventAdMob()
@end

@implementation MobFoxInterstitialCustomEventAdMob

    
-(void)requestInterstitialWithNetworkId:(NSString*)networkId customEventInfo:(NSDictionary *)info {

    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:networkId];
    self.interstitial.delegate = self;
    GADRequest* request = [GADRequest request];
    
    if([info objectForKey:@"demo_gender"]){
        NSString *gender = [[info valueForKey:@"demo_gender"] lowercaseString];
        
        if([gender isEqualToString:@"m"]) {
            
            request.gender = kGADGenderMale;
            
        } else if([gender isEqualToString:@"f"]) {
            
            request.gender = kGADGenderFemale;
            
        } else {
            
            request.gender = kGADGenderUnknown;
        }
    }
    
    if([info objectForKey:@"yob"]){
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.month    = 1;
        components.day      = 1;
        components.year =   [[info valueForKey:@"yob"] integerValue];
        request.birthday = [[NSCalendar currentCalendar] dateFromComponents:components];
    }
    
    [self.interstitial loadRequest:request];
}

-(void)presentWithRootController:(UIViewController *)rootViewController {
    
    NSLog(@"dbg: ### AdMob: >>> INTERSTITIAL: presentAd <<<");
    
    [self.interstitial presentFromRootViewController:rootViewController];
}


// Sent when an interstitial ad request succeeded.  Show it at the next
// transition point in your application such as when transitioning between view
// controllers.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    
    NSLog(@"dbg: ### AdMob: >>> INTERSTITIAL: didReceiveAd <<<");
    
    if ([ad isReady]) {
        [self.delegate MFInterstitialCustomEventAdDidLoad:self];
    }
}

// Sent when an interstitial ad request completed without an interstitial to
// show.  This is common since interstitials are shown sparingly to users.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error{
    
    NSLog(@"dbg: ### AdMob: >>> INTERSTITIAL: receiveAdWithError <<<");

    [self.delegate MFInterstitialCustomEventAdDidFailToReceiveAdWithError:error];
}



// Sent just before presenting an interstitial.  After this method finishes the
// interstitial will animate onto the screen.  Use this opportunity to stop
// animations and save the state of your application in case the user leaves
// while the interstitial is on screen (e.g. to visit the App Store from a link
// on the interstitial).
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
   // [self.delegate MFInterstitialCustomEventAdDidLoad:self];
}

// Sent before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
}

// Sent just after dismissing an interstitial and it has animated off the
// screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    [self.delegate MFInterstitialCustomEventAdClosed];
}

// Sent just before the application will background or terminate because the
// user clicked on an ad that will launch another application (such as the App
// Store).  The normal UIApplicationDelegate methods, like
// applicationDidEnterBackground:, will be called immediately before this.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    [self.delegate MFInterstitialCustomEventMobFoxAdClicked];
}

-(void)dealloc{
    self.interstitial.delegate = nil;
    self.interstitial = nil;
}
@end
