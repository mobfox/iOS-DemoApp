//
//  MoPubViewController.m
//  DemoApp
//
//  Created by ofirkariv on 27/09/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "MoPubViewController.h"

@interface MoPubViewController ()

@end

@implementation MoPubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loadTextField.delegate = self;
    if(self.invh.length == 0)
    _invh = MOPUB_HASH_BANNER;
    self.loadTextField.text = _invh;
    _loadTextField.placeholder = _invh;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(dismissKeyboard)]];
    
  
}

- (void)viewDidAppear:(BOOL)animated{
    _loadTextField.text = _invh;
}

-(void)dismissKeyboard {
    [self.loadTextField resignFirstResponder];
    
}

- (void)updateHashAfterScan:(NSString *)hash{
    
    [self setInvh:hash];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loadButton:(id)sender {
    
    [_errorLabel setText:@""];
    //add change options
    if([self.loadTextField.text length] > 0)
        _invh = self.loadTextField.text;
    switch ([self.typeSegmented selectedSegmentIndex]){

    case 0:
    self.adView = [[MPAdView alloc] initWithAdUnitId:_invh
                                                size:MOPUB_BANNER_SIZE];
    self.adView.delegate = self;
    self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2,
                                  self.view.bounds.size.height - MOPUB_BANNER_SIZE.height,
                                   MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
    [self.view addSubview:self.adView];
    [self.adView loadAd];
            break;
            
    case 1:
     
        self.interstitial = [MPInterstitialAdController
                                interstitialAdControllerForAdUnitId:_invh];
        self.interstitial.delegate = self;
        // Fetch the interstitial ad.
        [self.interstitial loadAd];
        break;
    
}
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (IBAction)typeChanged:(id)sender {
    switch ([self.typeSegmented selectedSegmentIndex]){
            case 0:
            _loadTextField.placeholder = MOPUB_HASH_BANNER;
            _loadTextField.text = MOPUB_HASH_BANNER;
            break;
            case 1:
            _loadTextField.placeholder = MOPUB_HASH_INTER;
            _loadTextField.text = MOPUB_HASH_INTER;
            break;
            
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"moPubToScan"]){
        ScanHashViewController *vc = [segue destinationViewController];
        vc.vcType = [segue identifier];
        vc.segueIdentify = @"scanToMoPub";
        vc.delegate = self;
    }
}

- (void)adViewDidLoadAd:(MPAdView *)view
{ //0, ([UIScreen mainScreen].bounds.size.width)*0.25
    CGSize size = [view adContentViewSize];
    CGFloat centeredX = 0;
    CGFloat bottomAlignedY = ([UIScreen mainScreen].bounds.size.height)*0.25;//self.view.bounds.size.height - size.height;
    view.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
}


- (IBAction)onScan:(id)sender {
      [self performSegueWithIdentifier:@"moPubToScan" sender:nil];
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

- (void)errorHandler:(NSError *)error{
    if(_errorLabel.isHidden)
        [_errorLabel setHidden:false];
    _errorLabel.text = [error localizedDescription];
    //_errorLabel.text = [NSString stringWithFormat:@"%@", error];
    _errorLabel.adjustsFontSizeToFitWidth = NO;
    _errorLabel.numberOfLines = 0;
    [_errorLabel sizeToFit];
    
}


////////              /////////
//Interstitial Load methods://
///////              /////////

- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial{
    if (self.interstitial.ready) [self.interstitial showFromViewController:self];
    else {
        // The interstitial wasn't ready, so continue as usual.
    }
    
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial withError:(NSError *)error{
    
    NSLog(@"interstitialDidFailToLoadAd", [error localizedDescription]);
    [self errorHandler:error];
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view {
    NSLog(@"adViewDidFailToLoadAd");
   NSError* err = [NSError errorWithDomain:@"MoPubError" code:00000 userInfo:[NSDictionary dictionaryWithObject:@"Cannot display banner, check log files" forKey:NSLocalizedDescriptionKey]];
    [self errorHandler:(NSError*)err];}
  




@end
