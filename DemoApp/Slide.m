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
    
    // To keep all UI controls frames in proportion to the real screen sizes
    // you need to calculate the with and height ratios
    CGFloat ratioW = 375.0/screenWidth;
    CGFloat ratioH = 667.0/screenHeight;
    
    CGRect buttonFrame = self.button.frame;
    buttonFrame.size = CGSizeMake(ratioW*screenWidth*0.7, ratioH*screenHeight*0.7);
    self.button.frame = buttonFrame;
    self.button.center = CGPointMake(ratioW*screenWidth/2,ratioH*screenHeight/2);
    
    CGRect supportButtonFrame = self.button.frame;
    supportButtonFrame.size = CGSizeMake(ratioW*screenWidth*0.15, ratioH*screenWidth*0.15);
    self.supportButton.frame = supportButtonFrame;
    self.supportButton.center = CGPointMake(ratioW*(screenWidth - (screenWidth*0.12)),
                                            ratioH*(screenHeight - (screenWidth*0.12)));

}
@end
