//
//  GalleryViewController.h
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OLXAd.h"

@interface GalleryViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;

@property (strong, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)backButtonTapped:(id)sender;

- (void)initializeWithOLXAd:(OLXAd*) olxAd;

@end
