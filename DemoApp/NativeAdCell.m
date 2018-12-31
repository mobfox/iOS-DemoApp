//
//  NativeAdCell.m
//  DemoApp
//
//  Created by ofirkariv on 31/12/2018.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "NativeAdCell.h"

@interface NativeAdCell()
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *mainTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *callToActionButton;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIImageView *privacyInformationIconImageView;
@property (nonatomic, weak) IBOutlet UIImageView *mainImageView;
@property (nonatomic, weak) IBOutlet UIView *videoView;
@property (nonatomic, weak) IBOutlet UIView *containerView;


@end

@implementation NativeAdCell


- (UILabel *)nativeMainTextLabel {
    return self.mainTextLabel;
}


- (UILabel *)nativeTitleTextLabel {
    return self.titleLabel;
}


- (UILabel *)nativeCallToActionTextLabel {
    return self.callToActionButton;
}


- (UIImageView *)nativeIconImageView {
    return self.iconImageView;
}


- (UIImageView *)nativeMainImageView {
    return self.mainImageView;
}


- (UIView *)nativeVideoView {
    return self.videoView;
}


- (UIImageView *)nativePrivacyInformationIconImageView {
    return self.privacyInformationIconImageView;
}


+ (UINib *)nibForAd {
    return [UINib nibWithNibName:@"NativeAdCell" bundle:nil];
}


@end
