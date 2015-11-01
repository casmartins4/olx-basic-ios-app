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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Configuration

- (void) configureTableView {
    __weak ListingViewController* weakSelf = self;
    
    // Sets pull to refresh action handler
    [_listingTableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    
    // Sets infinite scroll action handler
    [_listingTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
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
    
    [service requestDataWithUrl:nil success:^(OLXResponse *olxResponse) {
        [[OLXManager instance] addNewAds:olxResponse.ads andNextPageUrl:olxResponse.nextPageUrl andResetSource:reset];
        [_listingTableView reloadData];
        
        [_listingTableView.pullToRefreshView stopAnimating];
        [_listingTableView.infiniteScrollingView stopAnimating];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Pull to refresh and Infinite Scroll
- (void)insertRowAtTop {
    [self callOLXServiceWithUrl:nil andResetDataSource:YES];
}

- (void)insertRowAtBottom {
    [self callOLXServiceWithUrl:_currentResponse.nextPageUrl andResetDataSource:NO];
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
    [cell setCellDelegate:self];
    
    OLXAd* olxAd = [[OLXManager instance] dataElementForIndex:indexPath.row];
    [cell configureWithOLXAd:olxAd];
    
    return cell;
}

@end
