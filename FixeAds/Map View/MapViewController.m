//
//  MapViewController.m
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()
@property (strong, retain) OLXAd* currentOLXAd;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSBundle mainBundle] loadNibNamed:@"MapPortraitView" owner:self options:nil];
    
    [self configureMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue initializers
- (void)initializeWithOLXAd:(OLXAd*) olxAd {
    _currentOLXAd = olxAd;
}

#pragma mark - Map Configuration
- (void)configureMap {
    // Zoom Location
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [_currentOLXAd.mapLatitude floatValue];
    zoomLocation.longitude= [_currentOLXAd.mapLongitude floatValue];
    
    // View Region
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 20000, 20000);
    [_mapView setRegion:viewRegion animated:YES];
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:zoomLocation radius:1000];
    [self.mapView addOverlay:circle];
}

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor redColor];
    circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    return circleView;
}

#pragma mark - Navigation 
- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
