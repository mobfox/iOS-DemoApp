//
//  MobFoxObjectViewController.h
//  DemoApp
//
//  Created by ofirkariv on 12/09/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanHashViewController.h"
#import "ProgressView.h"

@interface MobFoxObjectViewController : UIViewController <UITextFieldDelegate, ScanHashViewControllerDelegate>

@property (nonatomic, strong) NSString *scriptURI;
@property (strong, nonatomic) NSString *invh;
@property (strong, nonatomic) NSString *server;


@property (weak, nonatomic) IBOutlet UISegmentedControl *serverSegmented;
@property (strong, nonatomic) IBOutlet UIView *errorView;


// UI Objects Properties

@property (strong, nonatomic) IBOutlet UIButton *loadButtonProperty;
@property (strong, nonatomic) IBOutlet UIButton *scanButtonProperty;
@property (strong, nonatomic) IBOutlet UITextField *floorProperty;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mediationSegmented;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UITextField *loadTextField;
@property (strong, nonatomic) IBOutlet UITextField *floorTextField;


@property (strong, nonatomic) NSString *MOBFOX_INVH;
@property (strong, nonatomic) NSString *MOPUB_INVH;
@property (strong, nonatomic) NSString *ADMOB_INVH;
- (void)popUpWithTitle:(NSString *)title message:(NSString *)message;
-(IBAction)loadButton:(id)sender;
-(BOOL)isLink : (NSString*) str;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
-(void)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)mediationChanged:(id)sender;
- (void)errorHandler:(NSError *)error;
@end
