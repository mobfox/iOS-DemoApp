//
//  MobFoxNativeCustomEventMoPub.m
//  MobFoxCoreDemo
//
//  Created by Itamar Nabriski on 10/14/15.
//  Copyright © 2015 Itamar Nabriski. All rights reserved.
//

#import "MobFoxNativeCustomEventMoPub.h"
#import "MPNativeAdRequest.h"
#import "MPNativeAd.h"
#import "MPNativeAdConstants.h"


@implementation MobFoxNativeCustomEventMoPub

- (void)requestAdWithNetworkID:(NSString*)nid customEventInfo:(NSDictionary *)info{
    
    NSArray* empty = [NSArray array];
    MPNativeAdRequest* req = [MPNativeAdRequest requestWithAdUnitIdentifier:nid rendererConfigurations:empty];
    [req startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd* response, NSError *error) {
        if(error){
            [self.delegate MFNativeCustomEventAdDidFailToReceiveAdWithError:error];
            return;
        }
        
        //NSString *iconImage = [dict objectForKey:kAdIconImageKey];
        //NSString *mainImage = [dict objectForKey:kAdMainImageKey];
        //NSURL *iconImageURL = [[NSURL alloc] initWithString:iconImage];
        //NSURL *mainImageURL = [[NSURL alloc] initWithString:mainImage];
        //mobFoxNativeData.icon = [[MobFoxNativeImage alloc] initWithURL:iconImageURL width:[NSNumber numberWithInteger:nativeAd.icon.width] height:[NSNumber numberWithInteger:nativeAd.icon.height]];
        //mobFoxNativeData.main = [[MobFoxNativeImage alloc] initWithURL:nativeAd.coverImage.url width:[NSNumber numberWithInteger:nativeAd.coverImage.width]  height:[NSNumber numberWithInteger:nativeAd.coverImage.width] ];
        
        NSDictionary *dict = response.properties;
        NSString *title = [dict objectForKey:kAdTitleKey];
        NSString *description = [dict objectForKey:kAdTextKey];
        NSString *ctaText = [dict objectForKey:kAdCTATextKey];
        
  
        MobFoxNativeData *mobFoxNativeData = [[MobFoxNativeData alloc] init];
        mobFoxNativeData.assetHeadline = title;
        mobFoxNativeData.assetDescription = description;
        mobFoxNativeData.callToActionText = ctaText;
        
        
        [self.delegate MFNativeCustomEventAd:self didLoad:mobFoxNativeData];
    }];
}


@end
