//
//  OLXResponseMapper.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLXResponse.h"

@interface OLXResponseMapper : NSObject

+ (OLXResponse*) mapDictionaryToOLXResponse:(NSDictionary*) dictionary;

@end
