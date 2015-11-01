//
//  GalleryViewController.m
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "GalleryViewController.h"
#import "OLXPhoto.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GalleryViewController ()
@property (strong, retain) OLXAd* currentOLXAd;
@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load view for portrait
    [[NSBundle mainBundle] loadNibNamed:@"GalleryPortraitView" owner:self options:nil];
    
    [self configureGallery];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Configuration {
- (void)configureGallery {
    [self configureScrollGallery];
}

- (void)configureScrollGallery {
    // Build the new photo scrollview
    CGSize sizeOfScreen = [[UIScreen mainScreen] bounds].size;
    
    [_imageScrollView setContentSize:CGSizeMake(sizeOfScreen.width, _currentOLXAd.photos.count * 310)];
    
    CGFloat accumulatedHeight = 0;
    
    for (int i = 0; i < _currentOLXAd.photos.count; i++) {
        OLXPhoto* olxPhoto = [_currentOLXAd.photos objectAtIndex:i];
        
        CGRect imageRect = CGRectMake(0,
                                      accumulatedHeight,
                                      sizeOfScreen.width,
                                      300);
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:imageRect];
        
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [_imageScrollView addSubview:imageView];
        NSString* photoUrl = [_currentOLXAd urlWithOLXPhoto:olxPhoto];
        [imageView sd_setImageWithURL:[NSURL URLWithString:photoUrl]];
        
        accumulatedHeight += 300 + 10;
    }
}

- (void)initializeWithOLXAd:(OLXAd*) olxAd {
    _currentOLXAd = olxAd;
}

#pragma mark - Navigation
- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
