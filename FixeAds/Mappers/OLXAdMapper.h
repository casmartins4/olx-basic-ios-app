//
//  OLXAdMapper.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLXAd.h"

@interface OLXAdMapper : NSObject

+ (OLXAd*) mapDictionaryToOLXAd:(NSDictionary*) dictionary;

@end
