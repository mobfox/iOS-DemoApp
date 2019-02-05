//
//  BannerViewController.m
//  DemoApp
//
//  Created by ofir kariv on 6/5/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "BannerViewController.h"


@protocol BannerDelegate <MobFoxAdDelegate, UITextFieldDelegate>

@end

@interface BannerViewController ()
    



@property (weak, nonatomic) IBOutlet UIButton *onGenerateOutlet;
@property (weak, nonatomic) IBOutlet UILabel *invhOutlet;
@property (strong, nonatomic) NSArray *sizes;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButtonOutlet;
@property (strong, nonatomic) MobFoxAd *mobfoxAd;





@end

@implementation BannerViewController

{
    CGRect  adRect;
}



- (void)viewDidLoad {
    
   
    [self setMOBFOX_INVH:MOBFOX_HASH_BANNER];
    [self setMOPUB_INVH:MOPUB_HASH_CE_BANNER];
    [self setADMOB_INVH:ADMOB_HASH_CE_BANNER];
    [super viewDidLoad];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _width =  [prefs integerForKey:@"width"];
    _height = [prefs integerForKey:@"height"];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(dismissKeyboard)]];
    NSLog(@"width: %ld \n height: %ld ", (long)_width, (long)_height);
}

- (IBAction)loadButton:(id)sender {
  
    adRect = CGRectMake(0, 0, _width, _height);
    if (_mobfoxAd != nil)
        [(UIView*)_mobfoxAd removeFromSuperview];
    [super loadButton:sender];
    _mobfoxAd = [[MobFoxAd alloc] init:self.invh withFrame:adRect];
    if ([self.floorTextField hasText])
        _mobfoxAd.r_floor = self.floorTextField.text;
    [self.view addSubview: _mobfoxAd];
        _mobfoxAd.delegate = self;
    [_mobfoxAd loadAd];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)dismissKeyboard {
    [self.loadTextField resignFirstResponder];
   
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"bannerToScan"]){
    ScanHashViewController *vc = [segue destinationViewController];
    vc.vcType = [segue identifier];
    vc.delegate = self;
    }
}

- (IBAction)onScan:(id)sender {
    [self performSegueWithIdentifier:@"bannerToScan" sender:self];
}



- (void)MobFoxAdDidFailToReceiveAdWithError:(NSError *)error{
    // Stop activity indicator
    [[ProgressView shared] stopAnimation];
    
    //Handle Error
    
    NSLog(@"%@", error);
    [self errorHandler:error];
}


- (void)MobFoxAdDidLoad:(MobFoxAd *)banner{
    // Stop activity indicator
    [[ProgressView shared] stopAnimation];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}



@end
