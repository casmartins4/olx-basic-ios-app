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
    [self configureCell];
    _imageScrollView.delegate = self;
}

- (void)configureCell {
    // Without this the scrollview gains control over the UITableView's didSelectRowAtIndexPath delegate method
    [_imageScrollView setUserInteractionEnabled:NO];
    [self.contentView addGestureRecognizer:_imageScrollView.panGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor *infoViewColor = _informationView.backgroundColor;
    [super setSelected:selected animated:animated];
    [_informationView setBackgroundColor:infoViewColor];
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
    
    _labelDescription.text = olxAd.title;
}

- (IBAction)shareButtonPressed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        [_shareButton setAlpha:0.5];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.4 animations:^{
                [_shareButton setAlpha:1.0];
            }];
        }
    }];
}

- (IBAction)shareButtonReleased:(id)sender {
    if ([_cellDelegate respondsToSelector:@selector(shareAdWithUrl:andDescription:)]) {
        [_cellDelegate shareAdWithUrl:urlToShare andDescription:_labelDescription.text];
    }
}

- (void)setBackgroundPhotos:(OLXAd*) olxAd {
    // Removes all existing subviews
    [_imageScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Build the new photo scrollview
    if (olxAd.photos != nil) {
        [_viewNoImage setHidden:YES];
        
        [_imageScrollView setContentSize:CGSizeMake(self.window.frame.size.width*olxAd.photos.count, _imageScrollView.frame.size.height)];
        
        for (int i = 0; i < olxAd.photos.count; i++) {
            OLXPhoto* olxPhoto = [olxAd.photos objectAtIndex:i];
            
            CGRect imageRect = CGRectMake(i*self.window.frame.size.width,
                                          0,
                                          self.window.frame.size.width,
                                          _imageScrollView.frame.size.height);
            
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:imageRect];
            [_imageScrollView addSubview:imageView];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            
            NSString* photoUrl = [olxAd urlWithOLXPhoto:olxPhoto width:imageRect.size.width andHeight:imageRect.size.height];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:photoUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
    }
    } else {
        [_viewNoImage setHidden:NO];
    }
}


@end
