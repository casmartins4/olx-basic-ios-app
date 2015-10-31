//
//  OLXService.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLXService : NSObject

+ (instancetype) instance;

- (void) requestInitial:(NSString*) username
               andPassword:(NSString*) password
             withOSVersion:(NSString*) osVersion
            andDeviceModel:(NSString*) deviceModel
                   success:(void (^)(PALoginResponse* loginResponse))success
                   failure:(void (^)(NSError* error))failure;


@end
