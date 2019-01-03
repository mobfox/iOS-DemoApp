//
//  NativeAdViewController.m
//  DemoApp
//
//  Created by Shimi Sheetrit on 2/11/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import "NativeAdViewController.h"
#import "NativeAdCell.h"

@interface NativeAdViewController ()

@property (strong, nonatomic) MobFoxNativeAd* nativeAd;


@end

@implementation NativeAdViewController

{
    NSString *demo_hash;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    self.indicator.frame = CGRectMake(40.0, 20.0, 100.0, 100.0);
    self.indicator.center = self.view.center;
    demo_hash = @"a764347547748896b84e0b8ccd90fd62";
     self.nativeAd = [[MobFoxNativeAd alloc] init:demo_hash nativeView:_nativeView];
      _nativeAd.delegate = self;
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barcode"]];
    arrow.frame = CGRectMake(0.0, 0.0, 5, 5);
    arrow.contentMode = UIViewContentModeCenter;
    
    _textField.rightView = arrow;
    _textField.rightViewMode = UITextFieldViewModeAlways;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loadNativeAd:(id)sender {
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
    [self.view addSubview:self.indicator];
    [_nativeAd loadAd];
}

//called when ad response is returned
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData{
    // Stop activity indicator
    [self.indicator stopAnimating];
    [self.indicator removeFromSuperview];
    _nativeIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:adData.icon.url]];
    _nativeMainImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:adData.main.url]];
    _nativeHeadline.text = adData.assetHeadline;
    _nativeDesc.text = adData.assetDescription;
    
    
    
}

//called when ad response cannot be returned
- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error{
    // Stop activity indicator
    [self.indicator stopAnimating];
    [self.indicator removeFromSuperview];
    NSLog(@"%@", [error description]);
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Load Fail"
                                                                   message:[error description]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//called on ad click
- (void)MobFoxNativeAdClicked{
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
