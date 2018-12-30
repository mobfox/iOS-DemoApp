//
//  Slide.m
//  DemoApp
//
//  Created by ofir kariv on 7/19/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "Slide.h"

@implementation Slide


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = (Slide*)[[NSBundle mainBundle] loadNibNamed:@"Slide" owner:self options:nil].firstObject;
        [self customInit];
    }
    return self;
}


-(void) customInit{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGRect buttonFrame = self.button.frame;
    buttonFrame.size = CGSizeMake(screenWidth*0.7, screenHeight*0.7);
    self.button.frame = buttonFrame;
    self.button.center = CGPointMake(screenWidth/2,screenHeight/2);
    
    CGRect supportButtonFrame = self.button.frame;
    supportButtonFrame.size = CGSizeMake(screenWidth*0.15, screenWidth*0.15);
    self.supportButton.frame = supportButtonFrame;
    self.supportButton.center = CGPointMake(screenWidth - (screenWidth*0.12),screenHeight - (screenWidth*0.12));

}
@end
