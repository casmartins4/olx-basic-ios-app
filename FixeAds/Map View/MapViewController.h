//
//  MapViewController.h
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OLXAd.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (void)initializeWithOLXAd:(OLXAd*) olxAd;

#pragma mark - Back Button Tapped
- (IBAction)backButtonTapped:(id)sender;

@end
