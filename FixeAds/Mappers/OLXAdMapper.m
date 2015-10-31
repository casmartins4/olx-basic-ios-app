//
//  OLXAdMapper.m
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "OLXAdMapper.h"
#import "OLXParameters.h"
#import "OLXPhoto.h"

@implementation OLXAdMapper

+ (OLXAd*) mapDictionaryToOLXAd:(NSDictionary*) dictionary {
    OLXAd* olxAd = [[OLXAd alloc] init];
    
    olxAd.idNumber = [dictionary objectForKey:@"id"];
    
    olxAd.url = [dictionary objectForKey:@"url"];
    olxAd.previewUrl = [dictionary objectForKey:@"preview_url"];
    
    olxAd.title = [dictionary objectForKey:@"title"];
    olxAd.created = [dictionary objectForKey:@"created"];
    olxAd.age = [dictionary objectForKey:@"age"];
    olxAd.adDescription = [dictionary objectForKey:@"description"];
    
    olxAd.highlighted = [[dictionary objectForKey:@"highlighted"] integerValue];
    olxAd.urgent = [[dictionary objectForKey:@"urgent"] integerValue];
    olxAd.topAd = [[dictionary objectForKey:@"topAd"] integerValue];
    
    olxAd.categoryId = [[dictionary objectForKey:@"category_id"] integerValue];
    
    NSArray* parametersArray = [dictionary objectForKey:@"params"];
    NSMutableArray* olxParametersArray = [[NSMutableArray alloc] init];
    for (NSArray* parameterArray in parametersArray) {
        OLXParameters* adParameters = [[OLXParameters alloc] init];
        adParameters.title = [parameterArray firstObject];
        adParameters.value = [parameterArray lastObject];
        
        [olxParametersArray addObject:adParameters];
    }
    
    olxAd.parameters = [NSArray arrayWithArray:olxParametersArray];
    
    olxAd.subtitle = [dictionary objectForKey:@"subtitle"];
    
    olxAd.hideUserAdsButton = [dictionary objectForKey:@"hide_user_ads_button"];
    olxAd.status = [dictionary objectForKey:@"status"];
    olxAd.isPriceNegotiable = [dictionary objectForKey:@"is_price_negotiable"];
    olxAd.hasPhone = [dictionary objectForKey:@"has_phone"];
    olxAd.hasEmail = [dictionary objectForKey:@"has_email"];
    
    olxAd.person = [dictionary objectForKey:@"person"];
    olxAd.userLabel = [dictionary objectForKey:@"user_label"];
    olxAd.userAdsId = [dictionary objectForKey:@"user_ads_id"];
    olxAd.userId = [dictionary objectForKey:@"user_id"];
    olxAd.numericUserId = [dictionary objectForKey:@"numeric_user_id"];
    olxAd.userAdsUrl = [dictionary objectForKey:@"user_ads_url"];
    olxAd.listLabel = [dictionary objectForKey:@"list_label"];
    olxAd.listLabel = [dictionary objectForKey:@"list_label"];
    olxAd.listLabelAd = [dictionary objectForKey:@"list_label_ad"];
    olxAd.listLabelSmall = [dictionary objectForKey:@"list_label_small"];
    
    olxAd.mapZoom = [dictionary objectForKey:@"map_zoom"];
    olxAd.mapLatitude = [dictionary objectForKey:@"map_lat"];
    olxAd.mapLongitude = [dictionary objectForKey:@"map_lon"];
    olxAd.mapRadius = [dictionary objectForKey:@"map_radius"];
    olxAd.mapShowDetailed = [dictionary objectForKey:@"map_show_detailed"];
    olxAd.cityLabel = [dictionary objectForKey:@"city_label"];
    olxAd.accurateLocation = [dictionary objectForKey:@"accurate_location"];
    
    NSDictionary* photosDictionary = [dictionary objectForKey:@"photos"];
    olxAd.riakRing = [photosDictionary objectForKey:@"riak_ring"];
    olxAd.riakKey = [photosDictionary objectForKey:@"riak_key"];
    olxAd.riakRev = [photosDictionary objectForKey:@"riak_rev"];
    
    NSArray* photosArray = [photosDictionary objectForKey:@"photos"];
    NSMutableArray* olxPhotos = [[NSMutableArray alloc] init];
    for (NSDictionary* photoDictionary in photosArray) {
        OLXPhoto* olxPhoto = [[OLXPhoto alloc] init];
        
        olxPhoto.slotId = [[photoDictionary objectForKey:@"slot_id"] integerValue];
        olxPhoto.width = [[photoDictionary objectForKey:@"w"] integerValue];
        olxPhoto.height = [[photoDictionary objectForKey:@"h"] integerValue];
        
        [olxPhotos addObject:olxPhoto];
    }
    olxAd.photos = [NSArray arrayWithArray:olxPhotos];

    return olxAd;
}

@end
