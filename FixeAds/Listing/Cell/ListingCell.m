//
//  ListingCell.m
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "ListingCell.h"
#import "OLXPhoto.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ListingCell

NSString* urlToShare;

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithOLXAd:(OLXAd*) olxAd {
    urlToShare = olxAd.url;
    
    [self setBackgroundPhotos:olxAd];
    
    _labelPrice.text = olxAd.listLabel;
    
    if (olxAd.isPriceNegotiable) {
        _labelNegotiable.text = olxAd.listLabelSmall;
        [_labelNegotiable setHidden:NO];
    } else {
        [_labelNegotiable setHidden:YES];
    }
    
    _labelLocation.text = olxAd.cityLabel;
    _labelDate.text = olxAd.created;
    
    _labelDescription.text = olxAd.adDescription;
}

- (IBAction)shareButtonPressed:(id)sender {
    if ([_cellDelegate respondsToSelector:@selector(shareAdWithUrl:andDescription:)]) {
        [_cellDelegate shareAdWithUrl:urlToShare andDescription:_labelDescription.text];
    }
}

- (IBAction)shareButtonReleased:(id)sender {
}

- (void)setBackgroundPhotos:(OLXAd*) olxAd {
    if (olxAd.photos != nil) {
        OLXPhoto* firstPhoto = [olxAd.photos firstObject];
        NSString* firstPhotoUrl = [olxAd urlWithOLXPhoto:firstPhoto width:_imageBackground.frame.size.width andHeight:_imageBackground.frame.size.height];
        
        NSURL* url = [NSURL URLWithString:firstPhotoUrl];
        
        [_imageBackground sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
}

@end
