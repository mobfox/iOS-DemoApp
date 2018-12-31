//
//  MobFoxObjectViewController.m
//  DemoApp
//
//  Created by ofirkariv on 12/09/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "MobFoxObjectViewController.h"
#import "InterstitialViewController.h"
#import "BannerViewController.h"

@interface MobFoxObjectViewController ()

@end

@implementation MobFoxObjectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
   self.indicator.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    self.indicator.frame = CGRectMake(40.0, 20.0, 100.0, 100.0);
    self.indicator.center = self.view.center;
    self.loadTextField.delegate = self;
    self.floorTextField.delegate = self;
    if(self.invh.length == 0)
        [self setInvh:self.MOBFOX_INVH];
    self.loadTextField.text = self.invh;
    self.loadTextField.placeholder = self.invh;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(dismissKeyboard)]];
    
    
    }
- (void)viewDidAppear:(BOOL)animated{
    _loadTextField.text = _invh;
}
    -(void)dismissKeyboard {
    [self.loadTextField resignFirstResponder];
    [self.floorTextField resignFirstResponder];
    }

- (void)updateHashAfterScan:(NSString *)hash{
    
    [self setInvh:hash];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loadButton:(id)sender {
    
    // start activity indicator, this should be implemented to stop when ad loaded
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
    [self.view addSubview:self.indicator];
    if ([_errorLabel.text length]>0){
        _errorLabel.text = @"";
    }
  //  [_scriptURI  isEqual: @""];
    
    // 1. check server
    if (self.serverSegmented.selectedSegmentIndex == 0 || self.serverSegmented == nil)
        self.server = @"";
    if (self.serverSegmented.selectedSegmentIndex == 1)
        self.server = @"http://nvirginia-my.mobfox.com";
    if (self.serverSegmented.selectedSegmentIndex == 2)
        self.server = @"http://tokyo-my.mobfox.com";
    
    
    // 2. check adapter
    
    if(self.mediationSegmented != nil){
    switch ([self.mediationSegmented selectedSegmentIndex]){
            // no adapter
        case 0:
            
            if([self.loadTextField.text length] > 0){
                
                if([self isLink:self.loadTextField.text]){  // if the text is link, generating video hash interstitial with debug url link that was written by the user.
                    self.invh = self.MOBFOX_INVH;
                    _scriptURI = self.loadTextField.text;
                }
                
                else {  // otherwise, this is invertory hash and we are using it to generate.
                    self.invh = self.loadTextField.text;
                }
                
            }
            else {
                self.invh = self.MOBFOX_INVH;
            }
            
            
            break;
            // admob
        case 1:
            self.invh = self.ADMOB_INVH;
            self.loadTextField.text = @"";
            self.loadTextField.placeholder = @"Admob Hash Do Not Change";
            
            
            break;
        case 2:
            self.invh = self.MOPUB_INVH;
            self.loadTextField.placeholder = @"Mopub Hash Do Not Change ";
            break;
            
    }}
    
}



 - (IBAction)mediationChanged:(id)sender {
 switch ([self.mediationSegmented selectedSegmentIndex]){
 case 0:
 self.invh = self.MOBFOX_INVH;
 self.loadTextField.text = self.invh;
 self.loadTextField.placeholder = MOBFOX_HASH_INTER;
 break;
 case 1:
 self.invh = self.ADMOB_INVH;
 self.loadTextField.text = @"";
 self.loadTextField.placeholder = @"Admob Hash Do Not Change";
 
 break;
 case 2:
 self.invh = self.MOPUB_INVH;
 self.loadTextField.text = @"";
 self.loadTextField.placeholder = @"Mopub Hash Do Not Change ";
 break;
 
 }
 
 }




- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //move buttons in for keyboard
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 (self.view.frame.origin.y)-((self.view.frame.size.height)*0.333),
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
     if([textField isEqual:self.loadTextField]){
    NSInteger mediationSegInt=  [self.mediationSegmented selectedSegmentIndex];
    if((mediationSegInt == 1) || (mediationSegInt == 2)){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert message:" message:@"Invertory hash can not be changed on mediation mode. Please change mediation to 'Default' before editing" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //move buttons after keyboard disappears
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 (self.view.frame.origin.y)+((self.view.frame.size.height)*0.333),
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
}

-(BOOL)isLink : (NSString*) str {
    NSString *substring = [str substringToIndex:4];
    if([substring isEqualToString:@"http"])
        return true;
    return false;
    
}

- (void)errorHandler:(NSError *)error{
    if(_errorLabel.isHidden)
        [_errorLabel setHidden:false];
    _errorLabel.text = [error localizedDescription];
    _errorLabel.adjustsFontSizeToFitWidth = NO;
    _errorLabel.numberOfLines = 0;
    [_errorLabel sizeToFit];
    
}


@end
