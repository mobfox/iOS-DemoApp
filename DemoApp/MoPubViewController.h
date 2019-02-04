//
//  MoPubViewController.h
//  DemoApp
//
//  Created by ofirkariv on 27/09/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAdView.h"
#import "MPInterstitialAdController.h"
#import "ScanHashViewController.h"
#import "MFDemoConstants.h"

@interface MoPubViewController : UIViewController <UITextFieldDelegate, MPAdViewDelegate, MPInterstitialAdControllerDelegate, ScanHashViewControllerDelegate>

@property (nonatomic) MPAdView *adView;
@property (strong, nonatomic) IBOutlet UITextField *loadTextField;
@property (nonatomic, retain) MPInterstitialAdController *interstitial;
@property (strong, nonatomic) NSString *invh;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmented;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UIButton *loadButtonProperty;
@property (strong, nonatomic) IBOutlet UIButton *scanButtonProperty;

@end
