//
//  Slide.h
//  DemoApp
//
//  Created by ofir kariv on 7/19/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Slide : UIView
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;

@end
