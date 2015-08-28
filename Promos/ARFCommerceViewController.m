//
//  ARFMarcasViewController.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/11/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommerceViewController.h"
#import "ARFConstants.h"
#import "ARFCommerceCell.h"
#import "ARFCommerceBanner.h"

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


static NSString* const kCommerceCellIdentifier        = @"CommerceCell";


@interface ARFCommerceViewController ()

@property (nonatomic, strong) ARFCommerceBanner *commerceBanner;

@end

@implementation ARFCommerceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFCommerceCell class]) bundle:nil] forCellReuseIdentifier:kCommerceCellIdentifier];
    
    self.commerceBanner = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ARFCommerceBanner class]) owner:self options:nil] firstObject];
    [self.commerceBanner setBackgroundColor:[UIColor greenColor]];
    [self.tableView setTableHeaderView:self.commerceBanner];

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.commerceBanner setFrame:CGRectMake(0, 0, self.view.frame.size.width, 124)];
    [self.commerceBanner layoutSubviews];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"Marcas"];

}

//-(void)updateViewConstraints{
//    
//    [self.commerceBanner autoSetDimension:ALDimensionWidth toSize:self.view.frame.size.width];
//    [self.commerceBanner autoSetDimension:ALDimensionHeight toSize:124];
//    [self.commerceBanner autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
//    [super updateViewConstraints];
//}


//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    [self.view layoutIfNeeded];
//}


#pragma mark - PFQueryTableViewController
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = kCommerceClassName;
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (PFQuery *)queryForTable {
    
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:kAttributeCreatedAt];
    
    return query;
}


#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    ARFCommerceCell *cell = (ARFCommerceCell *)[tableView dequeueReusableCellWithIdentifier:kCommerceCellIdentifier];
    
    [cell configureCellWithPFObject:object];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

@end
