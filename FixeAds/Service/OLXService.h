//
//  OLXService.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLXResponse.h"

@interface OLXService : NSObject

+ (instancetype) instance;

- (void) requestDataWithUrl:(NSString*) url
                    success:(void (^)(OLXResponse* olxResponse)) success
                    failure:(void (^)(NSError* error)) failure;

@end
