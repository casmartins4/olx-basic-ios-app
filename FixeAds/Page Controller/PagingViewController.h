//
//  PagingViewController.h
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagingDetailViewController.h"
#import "OLXAd.h"

@interface PagingViewController : UIViewController<UIPageViewControllerDataSource, ChildPageSegueDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;

#pragma mark - Segue methods
- (void)initWithIndexForData:(NSInteger) index;

@end
