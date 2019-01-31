//
//  MobFoxMainViewController.m
//  DemoApp
//
//  Created by ofir kariv on 7/19/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "MobFoxMainViewController.h"

#define URLEMail @"mailto:sdk_support@mobfox.com?subject=Demo-App-iOS"

@interface MobFoxMainViewController ()


@property (weak, nonatomic) IBOutlet UIScrollView *slideScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@end

@implementation MobFoxMainViewController


//////Slides key:///////////
//0 - Banner 320X50////////
//1 - Banner 300X50///////
//2 - Banner 300X250/////
//3 - Interstitial//////
//4 - Native Ad////////
//5 - Adapter-AdMob///
//6 - Adapater-MoPub/
////////////////////


- (NSArray*)createSlides{
    NSArray *arr;
    Slide *banner320_50Slide = [[Slide alloc] init];
    banner320_50Slide.label.text = @"Banner";
    banner320_50Slide.backgroundColor = [UIColor whiteColor];
    [banner320_50Slide.button setBackgroundImage:[UIImage imageNamed:@"banner32050"] forState: UIControlStateNormal];
    banner320_50Slide.button.tag = 0;
    [banner320_50Slide.button.widthAnchor constraintEqualToConstant: 40.0].active = YES;
    banner320_50Slide.width = 320;
    banner320_50Slide.height = 50;
    [banner320_50Slide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    Slide *banner300_50Slide = [[Slide alloc] init];
    banner300_50Slide.label.text = @"Banner";
    banner300_50Slide.backgroundColor = [UIColor whiteColor];
    [banner300_50Slide.button setBackgroundImage:[UIImage imageNamed:@"banner30050"] forState: UIControlStateNormal];
    banner300_50Slide.button.tag = 1;
    banner300_50Slide.width = 300;
    banner300_50Slide.height = 50;
    [banner300_50Slide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *banner300_250Slide = [[Slide alloc] init];
    banner300_250Slide.label.text = @"Banner";
    banner300_250Slide.backgroundColor = [UIColor whiteColor];
    [banner300_250Slide.button setBackgroundImage:[UIImage imageNamed:@"banner300250"] forState: UIControlStateNormal];
    banner300_250Slide.button.tag = 2;
    banner300_250Slide.width = 300;
    banner300_250Slide.height = 250;
    [banner300_250Slide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *interstitialSlide = [[Slide alloc] init];
    interstitialSlide.label.text = @"Interstitial";
    interstitialSlide.backgroundColor = [UIColor whiteColor];
    [interstitialSlide.button setBackgroundImage:[UIImage imageNamed:@"interstitial"] forState: UIControlStateNormal];
    interstitialSlide.button.tag = 3;
    [interstitialSlide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *nativeAdSlide = [[Slide alloc] init];
    nativeAdSlide.label.text = @"NativeAd";
    nativeAdSlide.backgroundColor = [UIColor whiteColor];
    [nativeAdSlide.button setBackgroundImage:[UIImage imageNamed:@"native"] forState: UIControlStateNormal];
    nativeAdSlide.button.tag = 4;
    [nativeAdSlide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    Slide *adMobAdapterSlide = [[Slide alloc] init];
    adMobAdapterSlide.label.text = @"AdMob";
    adMobAdapterSlide.backgroundColor = [UIColor whiteColor];
    [adMobAdapterSlide.button setBackgroundImage:[UIImage imageNamed:@"adMob"] forState: UIControlStateNormal];
    adMobAdapterSlide.button.tag = 5;
    [adMobAdapterSlide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *moPubAdapterSlide = [[Slide alloc] init];
    moPubAdapterSlide.label.text = @"MoPub";
    moPubAdapterSlide.backgroundColor = [UIColor whiteColor];
    [moPubAdapterSlide.button setBackgroundImage:[UIImage imageNamed:@"moPub"] forState: UIControlStateNormal];
    moPubAdapterSlide.button.tag = 6;
    [moPubAdapterSlide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    arr = [NSArray arrayWithObjects: banner320_50Slide, banner300_50Slide, banner300_250Slide, interstitialSlide, nativeAdSlide, adMobAdapterSlide, moPubAdapterSlide, nil];
    return arr;
}

- (void) setupSlideScrollView:(NSArray<Slide*>*) slides {
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    _slideScrollView.frame = CGRectMake(0, 0, width, height);
    _slideScrollView.contentSize = CGSizeMake(width * (CGFloat)slides.count, 1);
    _slideScrollView.pagingEnabled  = true;
    _slideScrollView.directionalLockEnabled = true;
    _slideScrollView.bounces = true;
   
    for (int i = 0; i<slides.count; ++i) {
        slides[i].frame = CGRectMake(width * (CGFloat)i, 0, width, height);
        
        [_slideScrollView addSubview:slides[i]];
    }
     NSLog(@"%@", _slideScrollView.subviews);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageIndex = round(scrollView.contentOffset.x/self.view.frame.size.width);
    _pageControl.currentPage = (int)pageIndex;
    
    
}


- (void)onButtonClicked:(UIButton*) sender{
    self.navigationController.navigationBarHidden = NO;
   NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    switch (sender.tag) {
        case 0:
            [prefs setInteger:320 forKey:@"width"];
            [prefs setInteger:50 forKey:@"height"];
            [self performSegueWithIdentifier:@"mainToBanner" sender:self];
            break;

        case 1:
            [prefs setInteger:300 forKey:@"width"];
            [prefs setInteger:50 forKey:@"height"];
            [self performSegueWithIdentifier:@"mainToBanner" sender:self];
            break;
            
        case 2:
            [prefs setInteger:300 forKey:@"width"];
            [prefs setInteger:250 forKey:@"height"];
            [self performSegueWithIdentifier:@"mainToBanner" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"mainToInterstitial" sender:self];
            break;
            
        case 4:
            [self performSegueWithIdentifier:@"mainToNative" sender:self];
            break;
            
        case 5:
             [self performSegueWithIdentifier:@"mainToAdMob" sender:self];
            break;
        case 6:
            [self performSegueWithIdentifier:@"mainToMoPub" sender:self];
            break;
            
        case 10:
            break;
        case 11:
            break;
            
        default:
            break;
    }
    
  
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _slideScrollView.delegate = self;
    NSArray *slides = self.createSlides;
    [self setupSlideScrollView:slides];
    _pageControl.numberOfPages = slides.count;
    _pageControl.currentPage = 0;
    [self.view bringSubviewToFront:_pageControl];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIButton *supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [supportButton addTarget:self action:@selector(supportBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:supportButton];
    [supportButton setImage:[UIImage imageNamed:@"support"] forState:UIControlStateNormal];
    CGRect buttonFrame = supportButton.frame;
    //buttonFrame.size = CGSizeMake(20, 20);
    buttonFrame.size = CGSizeMake(screenWidth*0.16, screenWidth*0.16);
    supportButton.frame = buttonFrame;
    supportButton.center = CGPointMake(screenWidth - (screenWidth*0.12),screenHeight - (screenWidth*0.12));
    //supportButton.center = CGPointMake(50,50);
    [self.view bringSubviewToFront:supportButton];
    
}

- (void)supportBtnClicked:(id)sender{

    
    NSString * encodedString = [URLEMail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:[NSURL URLWithString: encodedString] options:@{} completionHandler:nil];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
