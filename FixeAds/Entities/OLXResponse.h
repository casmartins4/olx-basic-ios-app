//
//  OLXResponse.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OLXAd;

@interface OLXResponse : NSObject

@property (nonatomic, retain) NSString* totalAds;

@property (nonatomic, retain) NSString* categoryIcon;
@property (nonatomic, retain) NSString* locationLabel;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalPages;
@property (nonatomic, assign) NSInteger adsOnPage;

@property (nonatomic, retain) NSString* nextPageUrl;

@property (nonatomic, retain) NSArray* ads;

@end