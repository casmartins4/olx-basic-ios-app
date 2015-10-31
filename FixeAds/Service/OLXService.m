//
//  OLXService.m
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "OLXService.h"
#import "AFNetworking.h"
#import "OLXResponseMapper.h"

@implementation OLXService

static NSString* const APIUrl = @"https://olx.pt/i2/ads/?json=1&search%5bcategory_id%5d=25";

+ (instancetype) instance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initAndConfigure];
    });
    return sharedInstance;
}

- (instancetype) initAndConfigure {
    if (self = [super init]) {
        [self initWithConfiguration];
    }
    return self;
}

- (void) initWithConfiguration {
    
}

- (void) requestDataWithUrl:(NSString*) url
                    success:(void (^)(OLXResponse* olxResponse)) success
                    failure:(void (^)(NSError* error)) failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // If it's the first call, then use the original api url
    url = (url == nil) ? APIUrl : url;
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            OLXResponse *olxResponse = [OLXResponseMapper mapDictionaryToOLXResponse:responseObject];
            
            if (olxResponse != nil) {
                success(olxResponse);
            } else {
                failure(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
