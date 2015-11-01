//
//  ListingViewController.h
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListingCell.h"

@interface ListingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ListingCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *listingTableView;

@end
