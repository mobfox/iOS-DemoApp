//
//  AdMobViewController.m
//  DemoApp
//
//  Created by ofirkariv on 25/09/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "AdMobViewController.h"


@interface AdMobViewController ()
@property (nonatomic, strong) IBOutlet GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;


@end

@implementation AdMobViewController


- (void)styleAdjustments {
    self.loadTextField.borderStyle = UITextBorderStyleNone;
    self.loadTextField.textAlignment = NSTextAlignmentCenter;
    self.loadTextField.layer.cornerRadius = 15;
    self.loadTextField.layer.borderWidth = 2;
    self.loadTextField.layer.masksToBounds = true;
    self.loadTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.loadTextField.font = [UIFont fontWithName:@"Helvetica" size:12];
    self.loadButtonProperty.layer.borderWidth = 2.0;
    self.loadButtonProperty.layer.borderColor = [UIColor grayColor].CGColor;
    self.loadButtonProperty.layer.cornerRadius = 20;
    self.scanButtonProperty.layer.borderWidth = 2.0;
    self.scanButtonProperty.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.scanButtonProperty.layer.cornerRadius = 20;
    self.typeSegmented.layer.borderWidth = 2.0;
    self.typeSegmented.layer.borderColor = [UIColor darkGrayColor].CGColor;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleAdjustments];
    _loadTextField.delegate = self;
    if(self.invh.length == 0)
    _invh = ADMOB_HASH_GAD_BANNER;
    _loadTextField.placeholder = _invh;
    _loadTextField.text = _invh;

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(dismissKeyboard)]];
}

- (void)viewDidAppear:(BOOL)animated{
    _loadTextField.text = _invh;
}

- (void)updateHashAfterScan:(NSString *)hash{
    
    [self setInvh:hash];
    
}

-(void)dismissKeyboard {
    [self.loadTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)typeChanged:(id)sender {
     switch ([self.typeSegmented selectedSegmentIndex]){
             case 0:
             _loadTextField.placeholder = ADMOB_HASH_GAD_BANNER;
             _loadTextField.text = ADMOB_HASH_GAD_BANNER;
             break;
             case 1:
             _loadTextField.placeholder = ADMOB_HASH_GAD_INTER;
             _loadTextField.text = ADMOB_HASH_GAD_INTER;
             break;
       
     }
    
}




- (IBAction)loadButton:(id)sender {
    
   [_errorLabel setText:@""];
    switch ([self.typeSegmented selectedSegmentIndex]){
            case 0:
            if(_bannerView != nil){
                [_bannerView removeFromSuperview];
            }
            self.bannerView = [[GADBannerView alloc]
                               initWithAdSize:kGADAdSizeBanner];
            [self addBannerViewToView:self.bannerView];
            if([self.loadTextField.text length] > 0)
                _invh = self.loadTextField.text;
            self.bannerView.adUnitID = _invh;
            self.bannerView.rootViewController = self;
            [self.bannerView loadRequest:[GADRequest request]];
            self.bannerView.delegate = self;
            
            break;
            
            case 1:
            if([self.loadTextField.text length] > 0)
            _invh = self.loadTextField.text;
            self.interstitial = [[GADInterstitial alloc]
                                 initWithAdUnitID:_invh];
            GADRequest *request = [GADRequest request];
            self.interstitial.delegate = self;
            [self.interstitial loadRequest:request];
           
            break;
       
    }
    
}
- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.topLayoutGuide
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"adMobToScan"]){
        ScanHashViewController *vc = [segue destinationViewController];
        vc.vcType = [segue identifier];
        vc.segueIdentify = @"scanToAdMob";
        vc.delegate = self;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 (self.view.frame.origin.y)-((self.view.frame.size.height)*0.333),
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 (self.view.frame.origin.y)+((self.view.frame.size.height)*0.333),
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
}

- (IBAction)onScan:(id)sender {
    [self performSegueWithIdentifier:@"adMobToScan" sender:nil];
}


- (void)errorHandler:(NSError *)error{
    if(_errorLabel.isHidden)
        [_errorLabel setHidden:false];
    _errorLabel.text = [error localizedDescription];
    //_errorLabel.text = [NSString stringWithFormat:@"%@", error];
    _errorLabel.adjustsFontSizeToFitWidth = NO;
    _errorLabel.numberOfLines = 0;
    [_errorLabel sizeToFit];
    
}

/*
///
///
///DELEGATE METHODS -
///
///
 /*

/* Banner Delegate Methods */

/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
     [self errorHandler:error];
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}

/* Interstitial Delegate Methods */

/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];

    } else {
        NSLog(@"Ad wasn't ready");
    }
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    [self errorHandler:error];
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
}

/// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen");
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}



@end
