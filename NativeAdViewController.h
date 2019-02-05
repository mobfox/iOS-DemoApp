//
//  NativeAdViewController.h
//  DemoApp
//
//  Created by Ofir Kariv 1/1/19
//  Copyright © 2019 MobFox Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobFoxObjectViewController.h"
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import "ScanHashViewController.h"

@interface NativeAdViewController : UIViewController <ScanHashViewControllerDelegate, MobFoxNativeAdDelegate, UITextFieldDelegate>


@property (strong, nonatomic) NSString *invh;
@property (strong, nonatomic) IBOutlet UIView *nativeView;
@property (strong, nonatomic) IBOutlet UIImageView *nativeIcon;
@property (strong, nonatomic) IBOutlet UILabel *nativeHeadline;
@property (strong, nonatomic) IBOutlet UILabel *nativeDesc;
@property (strong, nonatomic) IBOutlet UIImageView *nativeMainImage;
@property (strong, nonatomic) IBOutlet UITextField *loadTextField;
@property (strong, nonatomic) IBOutlet UIButton *loadButtonProperty;
@property (strong, nonatomic) IBOutlet UIButton *scanButtonProperty;






@end
