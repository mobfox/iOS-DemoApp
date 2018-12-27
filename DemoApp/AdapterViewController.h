//
//  AdapterViewController.h
//  DemoApp
//
//  Created by ofirkariv on 26/09/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFDemoConstants.h"
#import "ScanHashViewController.h"

@interface AdapterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *loadTextField;
@property (strong, nonatomic) NSString *invh;
@property (strong, nonatomic) NSString *default_banner;
@property (strong, nonatomic) NSString *default_interstitial;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmented;
- (IBAction)loadButton:(id)sender;

- (IBAction)typeChanged:(id)sender;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (IBAction)onScan:(id)sender;
@end
