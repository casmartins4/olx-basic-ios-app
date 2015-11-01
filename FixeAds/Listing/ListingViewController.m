//
//  ListingViewController.m
//  FixeAds
//
//  Created by Carlos Martins on 31/10/15.
//  Copyright © 2015 fixeads. All rights reserved.
//

#import "ListingViewController.h"
#import "ListingCell.h"
#import "OLXService.h"
#import "SVPullToRefresh.h"
#import "OLXManager.h"
#import "PagingViewController.h"

@interface ListingViewController ()
@property (nonatomic, retain) OLXResponse* currentResponse;
@end

@implementation ListingViewController

static NSString* const CellIdentifier = @"ListingCellIdentifier";

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTableView];
    [self registerNibs];
    [self initialServiceRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Configuration

- (void) configureTableView {
    __weak ListingViewController* weakSelf = self;
    
    // Sets pull to refresh action handler
    [_listingTableView addPullToRefreshWithActionHandler:^{
        [weakSelf pullToRefreshTriggered];
    }];
    
    // Sets infinite scroll action handler
    [_listingTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf infiniteScrollTriggered];
    }];
}


// Register the corresponding nibs to the tableview
- (void)registerNibs {
    [_listingTableView registerNib:[UINib nibWithNibName:@"ListingCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
}

- (void) initialServiceRequest {
    [self callOLXServiceWithUrl:nil andResetDataSource:YES];
}

- (void)callOLXServiceWithUrl:(NSString*) url andResetDataSource:(BOOL) reset {
    OLXService* service = [OLXService instance];
    
    [service requestDataWithUrl:url success:^(OLXResponse *olxResponse) {
        [[OLXManager instance] addNewAds:olxResponse.ads andNextPageUrl:olxResponse.nextPageUrl andResetSource:reset];
        [_listingTableView reloadData];
        
        [_listingTableView.pullToRefreshView stopAnimating];
        [_listingTableView.infiniteScrollingView stopAnimating];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Pull to refresh and Infinite Scroll
- (void)pullToRefreshTriggered {
    [self callOLXServiceWithUrl:nil andResetDataSource:YES];
}

- (void)infiniteScrollTriggered {
    [self callOLXServiceWithUrl:[[OLXManager instance] nextPageUrl] andResetDataSource:NO];
}

#pragma mark - Listing Cell Delegate
- (void)shareAdWithUrl:(NSString*) urlToShare andDescription:(NSString*) description {
    NSURL *url = [NSURL URLWithString:urlToShare];
    
    NSArray *objectsToShare = @[description, url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - UITableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[OLXManager instance] dataSource] count];
}

// Cell at index path
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ListingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    OLXAd* olxAd = [[OLXManager instance] dataElementForIndex:indexPath.row];
    [cell setCellDelegate:self];
    [cell configureWithOLXAd:olxAd];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ShowDetailSegue" sender:self];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath* selectedIndexPath = [_listingTableView indexPathForSelectedRow];
    
    if ([[segue destinationViewController] isKindOfClass:[PagingViewController class]]) {
        PagingViewController* nextViewController = (PagingViewController*) [segue destinationViewController];
        
        [nextViewController initWithIndexForData:selectedIndexPath.row];
    }
}
@end
