//
//  OLXService.m
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "OLXService.h"

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

@end
