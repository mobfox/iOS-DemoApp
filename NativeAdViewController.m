//
//  NativeAdViewController.m
//  DemoApp
//
//  Created by Ofir Kariv 1/1/19
//  Copyright © 2019 MobFox Ltd. All rights reserved.
//
#import "NativeAdViewController.h"
#import "NativeAdCell.h"

@interface NativeAdViewController ()

@property (strong, nonatomic) MobFoxNativeAd* nativeAd;

@property (nonatomic, strong) IBOutlet UIView* topBlock;
@property (nonatomic, strong) IBOutlet UIView* midBlock;
@property (nonatomic, strong) IBOutlet UIView* bottomBlock;

@end

@implementation NativeAdViewController

{
    NSString *demo_hash;
    
}

- (void)styleAdjustments {
    self.loadTextField.borderStyle = UITextBorderStyleNone;
    self.loadTextField.textAlignment = NSTextAlignmentCenter;
    self.loadTextField.layer.cornerRadius = 20;
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
    
}

- (void)InsetsAdjustments
{
    CGFloat topInset    = 20.0;
    CGFloat bottomInset = 0.0;
    if (@available(iOS 11.0, *)) {
        topInset    = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
        bottomInset = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
        
        if (topInset==0) topInset=20;
    }
    
    CGRect rcTop   = _topBlock.frame;
    CGRect rcMid   = _midBlock.frame;
    CGRect rcBottm = _bottomBlock.frame;
    
    _topBlock.frame    = CGRectMake(rcTop.origin.x, rcTop.origin.y+topInset,
                                 rcTop.size.width, rcTop.size.height);

    _bottomBlock.frame = CGRectMake(rcBottm.origin.x, rcBottm.origin.y-bottomInset,
                                 rcBottm.size.width, rcBottm.size.height);
    
    CGFloat midYTop    = _topBlock.frame.origin.y + _topBlock.frame.size.height;
    CGFloat midYBottom = _bottomBlock.frame.origin.y-1;

    _midBlock.frame    = CGRectMake(rcMid.origin.x, midYTop,
                                    rcMid.size.width, midYBottom-midYTop);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    demo_hash = @"a764347547748896b84e0b8ccd90fd62";
     self.nativeAd = [[MobFoxNativeAd alloc] init:demo_hash nativeView:_nativeView];
      _nativeAd.delegate = self;
    self.loadTextField.rightViewMode = UITextFieldViewModeAlways;
    if(self.invh.length == 0)
        [self setInvh:demo_hash];
    self.loadTextField.text = self.invh;
    self.loadTextField.placeholder = self.invh;
    self.loadTextField.delegate = self;
    [self InsetsAdjustments];
    [self styleAdjustments];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(dismissKeyboard)]];
  
}

- (void)viewDidAppear:(BOOL)animated{
    _loadTextField.text = demo_hash;
}

-(void)dismissKeyboard {
    [self.loadTextField resignFirstResponder];
}

- (void)updateHashAfterScan:(NSString *)hash{
    [self setInvh:hash];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"nativeToScan"]){
        ScanHashViewController *vc = [segue destinationViewController];
        vc.vcType = [segue identifier];
        vc.delegate = self;
    }
}

- (IBAction)onScan:(id)sender {
    [self performSegueWithIdentifier:@"nativeToScan" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loadNativeAd:(id)sender {
    // Start activity indicator
    [[ProgressView shared] startAnimation:self.view];
    [_nativeAd loadAd];
}

//called when ad response is returned
- (void)MobFoxNativeAdDidLoad:(MobFoxNativeAd*)ad withAdData:(MobFoxNativeData *)adData{
    [[ProgressView shared] stopAnimation];
    _nativeIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:adData.icon.url]];
    _nativeMainImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:adData.main.url]];
    _nativeHeadline.text = adData.assetHeadline;
    _nativeDesc.text = adData.assetDescription;
    
    
    
}

//called when ad response cannot be returned
- (void)MobFoxNativeAdDidFailToReceiveAdWithError:(NSError *)error{
    // Stop activity indicator
    [[ProgressView shared] stopAnimation];
    NSLog(@"%@", [error description]);
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Load Fail"
                                                                   message:[error description]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //move buttons in for keyboard
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 (self.view.frame.origin.y)-((self.view.frame.size.height)*0.333),
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    if([textField isEqual:self.loadTextField]){

    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //move buttons after keyboard disappears
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 (self.view.frame.origin.y)+((self.view.frame.size.height)*0.333),
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
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
