//
//  CustomEventForTest.m
//  DemoApp
//
//  Created by ofir kariv on 6/7/18.
//  Copyright © 2018 Matomy Media Group Ltd. All rights reserved.
//

#import "CustomEventForTest.h"

@implementation CustomEventForTest

- (void)requestAdWithSize:(CGSize)size networkID:(NSString*)nid customEventInfo:(NSDictionary *)info{
    DummyCEXIBView* view = [[DummyCEXIBView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.tag = 12345678;
    
    [self.delegate MFCustomEventAd:self didLoad:view];
}

@end
