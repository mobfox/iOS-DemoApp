//
//  AdMobViewController.h
//  DemoApp
//
//  Created by ofirkariv on 25/09/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFDemoConstants.h"
#import "ScanHashViewController.h"

@import GoogleMobileAds;

@interface AdMobViewController : UIViewController <UITextFieldDelegate, GADBannerViewDelegate, GADInterstitialDelegate, ScanHashViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *loadTextField;
@property (strong, nonatomic) NSString *invh;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;


@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmented;
- (IBAction)loadButton:(id)sender;


@end
