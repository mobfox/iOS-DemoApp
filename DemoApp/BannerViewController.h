//
//  BannerViewController.h
//  DemoApp
//
//  Created by ofir kariv on 6/5/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>
#import "MFDemoConstants.h"
#import "MobFoxObjectViewController.h"



@interface BannerViewController : MobFoxObjectViewController <UIPickerViewDelegate, UITextFieldDelegate, MobFoxAdDelegate>

@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (strong, nonatomic) IBOutlet NSString *loadTextFieldString;

@end
