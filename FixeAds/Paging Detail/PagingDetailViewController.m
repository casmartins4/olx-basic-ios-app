//
//  PagingDetailViewController.m
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "PagingDetailViewController.h"
#import "OLXManager.h"
#import "OLXService.h"
#import "MapViewController.h"
#import "GalleryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PagingDetailViewController ()
@property (nonatomic, retain) OLXAd* olxAd;
@end

@implementation PagingDetailViewController

static NSString* const TopInfoCellIdentifier = @"TopInfoCellIdentifier";

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load view for portrait
    [[NSBundle mainBundle] loadNibNamed:@"PagingDetailPortraitView" owner:self options:nil];
    
    [self configureActions];
    [self prepareNextOLXAd];
    [self fillDataWithOLXAd:_olxAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue initalizers
- (void)initWithIndexForData:(NSInteger) index {
    _currentIndex = index;
    _olxAd = [[OLXManager instance] dataElementForIndex:_currentIndex];
}

#pragma mark - Configuration
- (void)configureActions {
    // Location Tap Gesture
    UITapGestureRecognizer* locationTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationViewTapped:)];
    
    [_locationView setUserInteractionEnabled:YES];
    [locationTapRecognizer setNumberOfTapsRequired:1];
    [_locationView addGestureRecognizer:locationTapRecognizer];
    
    // Gallery Tap Gesture
    UITapGestureRecognizer* galleryTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(galleryViewTapped:)];
    
    [galleryTapRecognizer setNumberOfTapsRequired:1];
    [_informationView addGestureRecognizer:galleryTapRecognizer];
    
}

- (void)prepareNextOLXAd {
    // If true, then it's the last OLXAd stored. GET MOOOORE
    OLXManager* manager = [OLXManager instance];
    if (_currentIndex == [manager getHighestIndex]) {
        OLXService* service = [OLXService instance];
        
        NSString* nextPageUrl = [manager nextPageUrl];
        if (nextPageUrl != nil) {
            [service requestDataWithUrl:nextPageUrl success:^(OLXResponse *olxResponse) {
                [[OLXManager instance] addNewAds:olxResponse.ads andNextPageUrl:olxResponse.nextPageUrl andResetSource:NO];
            } failure:^(NSError *error) {
                
            }];
        }
    }
}

- (void)fillDataWithOLXAd:(OLXAd*) olxAd {
    [self setBackgroundPhotos:olxAd];
    [self fillTopInfo:olxAd];
}

- (void)setBackgroundPhotos:(OLXAd*) olxAd {
    // Removes all existing subviews
    [_imageScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Build the new photo scrollview
    if (olxAd.photos != nil) {
        [_emptyImageView setHidden:YES];
        
        CGSize sizeOfScreen = [[UIScreen mainScreen] bounds].size;
        
        [_imageScrollView setContentSize:CGSizeMake(sizeOfScreen.width*olxAd.photos.count, _imageScrollView.frame.size.height)];
        
        for (int i = 0; i < olxAd.photos.count; i++) {
            OLXPhoto* olxPhoto = [olxAd.photos objectAtIndex:i];
            
            CGRect imageRect = CGRectMake(i*sizeOfScreen.width,
                                          0,
                                          sizeOfScreen.width,
                                          _imageScrollView.frame.size.height);
            
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:imageRect];
            [_imageScrollView addSubview:imageView];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            NSString* photoUrl = [olxAd urlWithOLXPhoto:olxPhoto width:imageRect.size.width andHeight:imageRect.size.height];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:photoUrl]];
        }
    } else {
        [_emptyImageView setHidden:NO];
    }
}

- (void)fillTopInfo:(OLXAd*) olxAd {
    _priceLabel.text = olxAd.listLabel;
    
    if (olxAd.isPriceNegotiable) {
        _negotiableLabel.text = olxAd.listLabelSmall;
        [_negotiableLabel setHidden:NO];
    } else {
        [_negotiableLabel setHidden:YES];
    }
    
    _locationLabel.text = olxAd.cityLabel;
    _dateLabel.text = olxAd.created;
    
    _titleLabel.text = olxAd.title;
    _descriptionLabel.text = olxAd.adDescription;

}

#pragma mark - Navigation
- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareButtonTapped:(id)sender {
    NSURL *url = [NSURL URLWithString:_olxAd.url];
    
    NSArray *objectsToShare = @[_olxAd.adDescription, url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)locationViewTapped:(id) sender {
    if ([_segueDelegate respondsToSelector:@selector(shouldDoSegueWithIdentifier:withOLXAd:)]) {
        [_segueDelegate shouldDoSegueWithIdentifier:@"ShowMapSegue" withOLXAd:_olxAd];
    }
}

- (void)galleryViewTapped:(id) sender {
    if (_olxAd.photos != nil) {
        if ([_segueDelegate respondsToSelector:@selector(shouldDoSegueWithIdentifier:withOLXAd:)]) {
            [_segueDelegate shouldDoSegueWithIdentifier:@"ShowGallerySegue" withOLXAd:_olxAd];
        }
    }
}
@end
