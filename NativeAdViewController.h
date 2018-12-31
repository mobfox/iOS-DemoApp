//
//  NativeAdViewController.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 2/11/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobFoxObjectViewController.h"
#import <MobFoxSDKCore/MobFoxSDKCore.h>

@interface NativeAdViewController : UIViewController <MobFoxNativeAdDelegate>

@property (strong, nonatomic) IBOutlet UIView *nativeView;
@property (strong, nonatomic) IBOutlet UIImageView *nativeIcon;
@property (strong, nonatomic) IBOutlet UILabel *nativeHeadline;
@property (strong, nonatomic) IBOutlet UILabel *nativeDesc;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;



@end
