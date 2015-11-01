//
//  PagingViewController.m
//  FixeAds
//
//  Created by Carlos Martins on 01/11/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "PagingViewController.h"
#import "OLXManager.h"
#import "OLXService.h"
#import "MapViewController.h"
#import "GalleryViewController.h"

@interface PagingViewController ()
@property (nonatomic, assign) NSInteger realDataIndex;
@property (nonatomic, retain) OLXAd* olxAd;
@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPageViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPageViewController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    PagingDetailViewController *initialViewController = [self viewControllerAtIndex:_realDataIndex];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

#pragma mark - UIPageViewController Delegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [(PagingDetailViewController*)viewController currentIndex];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [(PagingDetailViewController*)viewController currentIndex] + 1;
    
    if ([[OLXManager instance] dataElementForIndex:index] != nil) {
        return [self viewControllerAtIndex:index];
    }
    
    return nil;
}

- (PagingDetailViewController *)viewControllerAtIndex:(NSInteger)index {
    PagingDetailViewController *childViewController = [[PagingDetailViewController alloc] initWithNibName:@"PagingDetailPortraitView" bundle:nil];
    [childViewController initWithIndexForData:index];
    childViewController.segueDelegate = self;
    return childViewController;
}

#pragma mark - Segue methods
- (void)initWithIndexForData:(NSInteger) index {
    _realDataIndex = index;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[MapViewController class]]) {
        MapViewController* nextViewController = [segue destinationViewController];
        
        [nextViewController initializeWithOLXAd:_olxAd];
    } else if ([[segue destinationViewController] isKindOfClass:[GalleryViewController class]]) {
        GalleryViewController* nextViewController = [segue destinationViewController];
        
        [nextViewController initializeWithOLXAd:_olxAd];
    }
}

#pragma mark - Child Page Segue Delegate
- (void)shouldDoSegueWithIdentifier:(NSString*)segueIdentifier withOLXAd:(OLXAd*)olxAd {
    _olxAd = olxAd;
    [self performSegueWithIdentifier:segueIdentifier sender:self];
}

@end
