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
    //[_imageScrollView setUserInteractionEnabled:NO];
    //[self.contentView addGestureRecognizer:_imageScrollView.panGestureRecognizer];
    _imageScrollView.delegate = self;
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
    [_imageScrollView setContentSize:CGSizeMake(self.window.frame.size.width*olxAd.photos.count, _imageScrollView.frame.size.height)];
    
    for (int i = 0; i < olxAd.photos.count; i++) {
        OLXPhoto* olxPhoto = [olxAd.photos objectAtIndex:i];
        
        CGRect imageRect = CGRectMake(i*self.window.frame.size.width,
                                      0,
                                      self.window.frame.size.width,
                                      _imageScrollView.frame.size.height);
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:imageRect];
        [_imageScrollView addSubview:imageView];
        
        NSString* photoUrl = [olxAd urlWithOLXPhoto:olxPhoto width:imageRect.size.width andHeight:imageRect.size.height];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:photoUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _imageScrollView.frame.size.width;
    int page = floor((_imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //self.pageControl.currentPage = page;
}

@end
