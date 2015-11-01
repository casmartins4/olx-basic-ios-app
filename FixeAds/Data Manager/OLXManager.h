//
//  OLXManager.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLXAd.h"

@interface OLXManager : NSObject

+ (instancetype) instance;

- (NSMutableArray*)dataSource;
- (void)addNewAds:(NSArray*) olxAds andNextPageUrl:(NSString*) pageUrl andResetSource:(BOOL) reset;

- (OLXAd*)dataElementForIndex:(NSInteger) index;
- (NSInteger)getHighestIndex;
- (NSString*)nextPageUrl;

@end
