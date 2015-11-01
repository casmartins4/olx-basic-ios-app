//
//  PagingDetailViewController.h
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OLXAd.h"

@protocol ChildPageSegueDelegate <NSObject>

- (void)shouldDoSegueWithIdentifier:(NSString*)segueIdentifier withOLXAd:(OLXAd*)olxAd;

@end

@interface PagingDetailViewController : UIViewController

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) id<ChildPageSegueDelegate> segueDelegate;

#pragma mark - IBOutlets
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) IBOutlet UIView *emptyImageView;
@property (strong, nonatomic) IBOutlet UIView *informationView;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *negotiableLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionLabel;

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIView *locationView;


#pragma mark - IBActions
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)shareButtonTapped:(id)sender;

#pragma mark - Segue methods
- (void)initWithIndexForData:(NSInteger) index;

@end
