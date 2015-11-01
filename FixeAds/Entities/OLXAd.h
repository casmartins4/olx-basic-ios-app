//
//  OLXAd.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OLXParameters;
@class OLXPhoto;

@interface OLXAd : NSObject

@property (nonatomic, retain) NSString* idNumber;

#pragma mark - Urls
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* previewUrl;

#pragma mark - OLX Ad info
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* created;
@property (nonatomic, retain) NSString* age;
@property (nonatomic, retain) NSString* adDescription;

@property (nonatomic, assign) NSInteger highlighted;
@property (nonatomic, assign) NSInteger urgent;
@property (nonatomic, assign) NSInteger topAd;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, retain) NSArray* parameters;
@property (nonatomic, retain) NSArray* subtitle;

@property (nonatomic, retain) NSString* person;
@property (nonatomic, retain) NSString* userLabel;
@property (nonatomic, retain) NSString* userAdsId;
@property (nonatomic, retain) NSString* userId;
@property (nonatomic, retain) NSString* numericUserId;
@property (nonatomic, retain) NSString* userAdsUrl;
@property (nonatomic, retain) NSString* listLabel;
@property (nonatomic, retain) NSString* listLabelAd;
@property (nonatomic, retain) NSString* listLabelSmall;

#pragma mark - Options
@property (nonatomic, assign) BOOL hideUserAdsButton;
@property (nonatomic, retain) NSString* status;
@property (nonatomic, assign) BOOL isPriceNegotiable;
@property (nonatomic, assign) BOOL hasPhone;
@property (nonatomic, assign) BOOL hasEmail;

#pragma mark - Map & Location
@property (nonatomic, retain) NSString* mapZoom;
@property (nonatomic, retain) NSString* mapLatitude;
@property (nonatomic, retain) NSString* mapLongitude;
@property (nonatomic, retain) NSString* mapRadius;
@property (nonatomic, assign) BOOL mapShowDetailed;
@property (nonatomic, retain) NSString* cityLabel;
@property (nonatomic, retain) NSString* mapLocation;
@property (nonatomic, assign) BOOL accurateLocation;

#pragma mark - Photos
@property (nonatomic, retain) NSString* riakRing;
@property (nonatomic, retain) NSString* riakKey;
@property (nonatomic, retain) NSString* riakRev;
@property (nonatomic, retain) NSArray* photos;

#pragma mark - Photo url builders
- (NSString*) urlWithOLXPhoto:(OLXPhoto*) olxPhoto
                        width:(NSInteger) width
                    andHeight:(NSInteger) height;

- (NSString*) urlWithOLXPhoto:(OLXPhoto*) olxPhoto;

@end
