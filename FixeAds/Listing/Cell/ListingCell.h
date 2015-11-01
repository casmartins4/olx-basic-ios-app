//
//  ListingCell.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OLXAd.h"

@protocol ListingCellDelegate <NSObject>

@required
- (void)shareAdWithUrl:(NSString*) urlToShare andDescription:(NSString*) description;

@end

@interface ListingCell : UITableViewCell

@property (nonatomic, weak) id<ListingCellDelegate> cellDelegate;

@property (strong, nonatomic) IBOutlet UIImageView *imageBackground;

@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelNegotiable;

@property (strong, nonatomic) IBOutlet UILabel *labelLocation;
@property (strong, nonatomic) IBOutlet UILabel *labelDate;

@property (strong, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

- (void)configureWithOLXAd:(OLXAd*) olxAd;


- (IBAction)shareButtonPressed:(id)sender;
- (IBAction)shareButtonReleased:(id)sender;


@end
