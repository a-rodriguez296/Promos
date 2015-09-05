//
//  ARFPromosViewController.m
//  Promos
//
//  Created by Alejandro Rodriguez on 7/21/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPromosViewController.h"
#import "ARFConstants.h"
#import "ARFPromoCell.h"
#import "ARFPromosDetailViewController.h"
#import "ARFPromosBannerView.h"

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString* const kPromoCellIdentifier        = @"Cell";

@interface ARFPromosViewController ()

@property (nonatomic, strong) ARFPromosBannerView * promosBanner;


@end

@implementation ARFPromosViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFPromoCell class]) bundle:nil] forCellReuseIdentifier:kPromoCellIdentifier];

    //Se agregó el header
    self.promosBanner = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ARFPromosBannerView class]) owner:self options:nil] firstObject];
    [self.promosBanner setDelegate:self];
    [self.tableView setTableHeaderView:self.promosBanner];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"Promociones"];
    
   
    
    
    @weakify(self);
    
    PFQuery *featuredQuery = [PFQuery queryWithClassName:self.parseClassName];
    [featuredQuery whereKey:kPromosAttributeFeatured equalTo:[NSNumber numberWithBool:YES]];
    [featuredQuery setLimit:3];
    [featuredQuery setCachePolicy:kPFCachePolicyCacheThenNetwork];
    [featuredQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        @strongify(self);
        if (!error) {
            
            [self.promosBanner setObjects:objects];
            
            
        } else {
            
        }
    }];

    
    //Setup autolayout del header
    [self.promosBanner setFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    [self.promosBanner layoutSubviews];
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = kPromosClassName;
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

#pragma mark - PFQueryTableViewController

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
    
    ARFPromoCell *cell = (ARFPromoCell *)[tableView dequeueReusableCellWithIdentifier:kPromoCellIdentifier];

    // Configure the cell
    [cell configureCellWithPFObject:object];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

- (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
    return [self.objects objectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *promo = [self objectAtIndex:indexPath];
    [self pushToDetailWithObject:promo];
}


#pragma mark ARFBannerDelegate

-(void)ARFBannerView:(ARFPromosBannerView *)bannerView didTouchBannerAtIndex:(NSUInteger)index object:(PFObject *)object{
    [self pushToDetailWithObject:object];
}


#pragma mark Utils

-(void) pushToDetailWithObject:(PFObject *) object{
    
    ARFPromosDetailViewController *promoDetailVC = [[ARFPromosDetailViewController alloc] initWithPromo:object];
    [promoDetailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:promoDetailVC animated:YES];
}
@end
