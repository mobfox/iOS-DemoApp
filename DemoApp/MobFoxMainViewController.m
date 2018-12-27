//
//  MobFoxMainViewController.m
//  DemoApp
//
//  Created by ofir kariv on 7/19/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "MobFoxMainViewController.h"

@interface MobFoxMainViewController ()


@property (weak, nonatomic) IBOutlet UIScrollView *slideScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@end

@implementation MobFoxMainViewController


//////Slides key://////////
//0 - Banner 320X50///////
//1 - Banner 300X50//////
//2 - Banner 300X250////
//3 - Interstitial/////
//4 - Adapter-AdMob///
//5 - Adapater-MoPub/
////////////////////


- (NSArray*)createSlides{
    NSArray *arr;
    
    Slide *banner320_50Slide = (Slide*)[[NSBundle mainBundle] loadNibNamed:@"Slide" owner:self options:nil].firstObject;
    banner320_50Slide.label.text = @"Banner";
    [banner320_50Slide.button setBackgroundImage:[UIImage imageNamed:@"banner32050"] forState: UIControlStateNormal];
    banner320_50Slide.button.tag = 1;
    banner320_50Slide.width = 320;
    banner320_50Slide.height = 50;
    [banner320_50Slide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *banner300_50Slide = (Slide*)[[NSBundle mainBundle] loadNibNamed:@"Slide" owner:self options:nil].firstObject;
    banner300_50Slide.label.text = @"Banner";
    [banner300_50Slide.button setBackgroundImage:[UIImage imageNamed:@"banner30050"] forState: UIControlStateNormal];
    banner300_50Slide.button.tag = 0;
    banner300_50Slide.width = 300;
    banner300_50Slide.height = 50;
    [banner300_50Slide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *banner300_250Slide = (Slide*)[[NSBundle mainBundle] loadNibNamed:@"Slide" owner:self options:nil].firstObject;
    banner300_250Slide.label.text = @"Banner";
    [banner300_250Slide.button setBackgroundImage:[UIImage imageNamed:@"banner300250"] forState: UIControlStateNormal];
    banner300_250Slide.button.tag = 2;
    banner300_250Slide.width = 300;
    banner300_250Slide.height = 250;
    [banner300_250Slide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *interstitialSlide = (Slide*)[[NSBundle mainBundle] loadNibNamed:@"Slide" owner:self options:nil].firstObject;
    interstitialSlide.label.text = @"Interstitial";
    [interstitialSlide.button setBackgroundImage:[UIImage imageNamed:@"interstitial"] forState: UIControlStateNormal];
    interstitialSlide.button.tag = 3;
    [interstitialSlide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *adMobAdapterSlide = (Slide*)[[NSBundle mainBundle] loadNibNamed:@"Slide" owner:self options:nil].firstObject;
    adMobAdapterSlide.label.text = @"AdMob";
    [adMobAdapterSlide.button setBackgroundImage:[UIImage imageNamed:@"adMob"] forState: UIControlStateNormal];
    adMobAdapterSlide.button.tag = 4;
    [adMobAdapterSlide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    Slide *moPubAdapterSlide = (Slide*)[[NSBundle mainBundle] loadNibNamed:@"Slide" owner:self options:nil].firstObject;
    moPubAdapterSlide.label.text = @"MoPub";
    [moPubAdapterSlide.button setBackgroundImage:[UIImage imageNamed:@"moPub"] forState: UIControlStateNormal];
    moPubAdapterSlide.button.tag = 5;
    [moPubAdapterSlide.button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    arr = [NSArray arrayWithObjects: banner320_50Slide, banner300_50Slide, banner300_250Slide, interstitialSlide, adMobAdapterSlide, moPubAdapterSlide, nil];
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
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pageIndex = round(scrollView.contentOffset.x/self.view.frame.size.width);
    _pageControl.currentPage = (int)pageIndex;
    
    
}


- (void)onButtonClicked:(UIButton*) sender{
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
             [self performSegueWithIdentifier:@"mainToAdMob" sender:self];
            break;
        case 5:
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _slideScrollView.delegate = self;
    NSArray *slides = self.createSlides;
    [self setupSlideScrollView:slides];
    _pageControl.numberOfPages = slides.count;
    _pageControl.currentPage = 0;
    
    [self.view bringSubviewToFront:_pageControl];
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
