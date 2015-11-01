//
//  OLXAd.m
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "OLXAd.h"
#import "OLXParameters.h"
#import "OLXPhoto.h"

@implementation OLXAd

static NSString* const OLXPhotoUrl = @"http://img.olx.pt/images_olxpt/";

#pragma mark - Photo url builders

// Returns an URL with a given width and height
- (NSString*) urlWithOLXPhoto:(OLXPhoto*) olxPhoto
                        width:(NSInteger) width
                    andHeight:(NSInteger) height {
    
    // Format of the url: [riak_key]_[slot_id]_[w]x[h]_[riak_rev].jpg
    return [NSString stringWithFormat:@"%@%@_%ld_%ldx%ld.jpg", OLXPhotoUrl, _riakKey, olxPhoto.slotId, width, height];
}

// Returns an URL with the known dimensions
- (NSString*) urlWithOLXPhoto:(OLXPhoto*) olxPhoto {
    return [NSString stringWithFormat:@"%@%@_%ld_%ldx%ld.jpg", OLXPhotoUrl, _riakKey, olxPhoto.slotId, olxPhoto.width, olxPhoto.height];
}

@end
