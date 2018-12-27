//
//  SettingsViewController.h
//  DemoApp
//
//  Created by Shimi Sheetrit on 2/3/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobFoxSDKCore/MobFoxSDKCore.h>

@class ScanHashViewController;
@protocol ScanHashViewControllerDelegate <NSObject>
    - (IBAction)updateHashAfterScan:(NSString *)hash;
@end

@interface ScanHashViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate, MobFoxInterstitialAdDelegate>

@property (strong, nonatomic) NSString *vcType;
@property (strong, nonatomic) NSString *segueIdentify;
@property (nonatomic, weak) id <ScanHashViewControllerDelegate> delegate;

@end
 
