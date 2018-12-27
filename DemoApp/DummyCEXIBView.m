//
//  DummyCEXIBView.m
//  DemoApp
//
//  Created by ofir kariv on 6/7/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "DummyCEXIBView.h"

@interface DummyCEXIBView ()
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation DummyCEXIBView


- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

-(void)customInit{
    [[NSBundle mainBundle] loadNibNamed:@"DummyCustomEvent" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
