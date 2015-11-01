//
//  OLXManager.m
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "OLXManager.h"

@implementation OLXManager

NSMutableArray* dataSource;
NSString* nextPageUrl;

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
    dataSource = [[NSMutableArray alloc] init];
}

- (NSMutableArray*)dataSource {
    return dataSource;
}

- (void)addNewAds:(NSArray*) olxAds andNextPageUrl:(NSString*) pageUrl andResetSource:(BOOL) reset {
    if (reset) {
        dataSource = [[NSMutableArray alloc] initWithCapacity:olxAds.count];
    }
    
    [dataSource addObjectsFromArray:olxAds];
    nextPageUrl = pageUrl;
}

- (OLXAd*)dataElementForIndex:(NSInteger) index {
    if (dataSource != nil && index >= 0 && index < dataSource.count) {
        return [dataSource objectAtIndex:index];
    }
    
    return nil;
}

- (NSInteger)getHighestIndex {
    return dataSource.count - 1;
}

- (NSString*)nextPageUrl {
    return nextPageUrl;
}

@end
