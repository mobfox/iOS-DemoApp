//
//  ProgressView.m
//  DemoApp
//
//  Created by ofirkariv on 04/02/2019.
//  Copyright © 2019 Matomy Media Group Ltd. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()

@property (nonatomic) UIView* containerView;
@property (nonatomic) UIView* progressView;
@property (nonatomic) UIActivityIndicatorView* indicator;
+(ProgressView *) shared;



@end

@implementation ProgressView


+(ProgressView *) shared{
    static ProgressView* sharedVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedVC = [[self alloc] init];
    });
    return sharedVC;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
        self.indicator.frame = CGRectMake(40.0, 20.0, 100.0, 100.0);
        
    }
    return self;
}


- (void) startAnimation:(UIView *)view{
    self.indicator.center = view.center;
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
    [view addSubview:self.indicator];
}

-(void) stopAnimation{
    [self.indicator stopAnimating];
    [self.indicator removeFromSuperview];
}
@end
