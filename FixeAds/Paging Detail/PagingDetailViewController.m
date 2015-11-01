//
//  PagingDetailViewController.m
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "PagingDetailViewController.h"
#import "OLXAd.h"
#import "OLXManager.h"
#import "MapViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PagingDetailViewController ()
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, retain) OLXAd* olxAd;
@end

@implementation PagingDetailViewController

static NSString* const TopInfoCellIdentifier = @"TopInfoCellIdentifier";

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load view for portrait
    [[NSBundle mainBundle] loadNibNamed:@"PagingDetailPortraitView" owner:self options:nil];
    
    // Bug in iOS that makes the UIScrollView appear below the top status bar
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setDelegates];
    [self configureActions];
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
- (void)setDelegates {
    
}

- (void)configureActions {
    UITapGestureRecognizer* locationTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationViewTapped:)];
    
    [_locationView setUserInteractionEnabled:YES];
    [locationTapRecognizer setNumberOfTapsRequired:1];
    [_locationView addGestureRecognizer:locationTapRecognizer];
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
    
    _descriptionLabel.text = olxAd.adDescription;

}


#pragma mark - UIPageViewController Delegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return viewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return viewController;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)shareButtonTapped:(id)sender {
    
}

- (void)locationViewTapped:(id) sender {
    
}
@end
