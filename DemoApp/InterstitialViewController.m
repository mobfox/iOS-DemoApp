//
//  InterstitialViewController.m
//  DemoApp
//
//  Created by ofir kariv on 6/6/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "InterstitialViewController.h"

@interface InterstitialViewController ()


- (IBAction)loadTextField:(id)sender;



@property (strong, nonatomic) MobFoxInterstitialAd* mobfoxInterAd;


@end

@implementation InterstitialViewController


- (void)viewDidLoad {
    
    
    [self setMOBFOX_INVH:MOBFOX_HASH_INTER];
    [self setMOPUB_INVH:MOPUB_HASH_CE_INTER];
    [self setADMOB_INVH:ADMOB_HASH_CE_INTER];
    [super viewDidLoad];
}

- (IBAction)loadButton:(id)sender {
    
    [super loadButton:sender];
    _mobfoxInterAd = [[MobFoxInterstitialAd alloc] init:self.invh withRootViewController:self];
    if(self.scriptURI.length>0)
        _mobfoxInterAd.debug_ad_request_url = self.scriptURI;
    if([self.floorTextField hasText])
        _mobfoxInterAd.r_floor = self.floorTextField.text;
    _mobfoxInterAd.delegate = self;
    [_mobfoxInterAd loadAd];
    }
    


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"interstitialToScan"]){
        ScanHashViewController *vc = [segue destinationViewController];
        vc.vcType = [segue identifier];
        vc.segueIdentify = @"scanToInterstitial";
        vc.delegate = self;
    }
}

- (IBAction)onScan:(id)sender {
    [self performSegueWithIdentifier:@"interstitialToScan" sender:self];
}


- (void)MobFoxInterstitialAdDidLoad:(MobFoxInterstitialAd *)interstitial{
    if(_mobfoxInterAd.ready){
        [_mobfoxInterAd show];
    }
    
    }


- (void)MobFoxInterstitialAdDidFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"%@", error);
    [self errorHandler:error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
