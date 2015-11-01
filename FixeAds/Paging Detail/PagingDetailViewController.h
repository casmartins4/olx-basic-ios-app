//
//  PagingDetailViewController.h
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagingDetailViewController : UIViewController<UIPageViewControllerDataSource>

#pragma mark - IBOutlets
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) IBOutlet UIView *emptyImageView;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *negotiableLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIView *locationView;


#pragma mark - IBActions
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)shareButtonTapped:(id)sender;

#pragma mark - Segue methods
- (void)initWithIndexForData:(NSInteger) index;

@end
