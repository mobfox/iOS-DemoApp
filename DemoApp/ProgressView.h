//
//  ProgressView.h
//  DemoApp
//
//  Created by ofirkariv on 04/02/2019.
//  Copyright © 2019 Matomy Media Group Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : NSObject
+(ProgressView *) shared;
- (void) startAnimation:(UIView *)view;
-(void) stopAnimation;

@end
