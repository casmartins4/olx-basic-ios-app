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

@interface ListingViewController ()

@end

@implementation ListingViewController

static NSString* const CellIdentifier = @"ListingCellIdentifier";

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self registerNibs];
    
    [[OLXService instance] requestDataWithUrl:nil success:^(OLXResponse *olxResponse) {
        
    } failure:^(NSError *error) {
        
    }];
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
// Register the corresponding nibs to the tableview
- (void) registerNibs {
    [_listingTableView registerNib:[UINib nibWithNibName:@"ListingCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - UITableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

// Cell at index path
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}
@end
