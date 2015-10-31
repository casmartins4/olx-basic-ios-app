//
//  OLXResponseMapper.m
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "OLXResponseMapper.h"
#import "OLXAdMapper.h"

@implementation OLXResponseMapper

+ (OLXResponse*) mapDictionaryToOLXResponse:(NSDictionary*) dictionary {
    OLXResponse *olxResponse = [[OLXResponse alloc] init];
    
    olxResponse.totalAds = [dictionary objectForKey:@"total_ads"];
    
    NSDictionary* headerLabels = [dictionary objectForKey:@"top_header_labels"];
    olxResponse.categoryIcon = [headerLabels objectForKey:@"category_icon"];
    olxResponse.locationLabel = [headerLabels objectForKey:@"location_label"];
    
    olxResponse.page = [[dictionary objectForKey:@"page"] integerValue];
    olxResponse.totalPages = [[dictionary objectForKey:@"total_pages"] integerValue];
    olxResponse.adsOnPage = [[dictionary objectForKey:@"ads_on_page"] integerValue];
    
    olxResponse.nextPageUrl = [dictionary objectForKey:@"next_page_url"];
    
    NSArray *adDictionary = [dictionary objectForKey:@"ads"];
    NSMutableArray *ads = [[NSMutableArray alloc] initWithCapacity:adDictionary.count];
    
    for (NSDictionary* adEntryDictionary in adDictionary) {
        [ads addObject:[OLXAdMapper mapDictionaryToOLXAd:adEntryDictionary]];
    }
    
    olxResponse.ads = [NSArray arrayWithArray:ads];
    
    return olxResponse;
}

@end
