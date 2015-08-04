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
#import "ARFBannerView.h"

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "PureLayout.h"

static NSString* const kPromoCellIdentifier        = @"Cell";

@interface ARFPromosViewController ()

@end

@implementation ARFPromosViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ARFPromoCell class]) bundle:nil] forCellReuseIdentifier:kPromoCellIdentifier];
//
//    ARFBannerView *bannerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ARFBannerView class]) owner:nil options:nil] firstObject];
//    [bannerView setBackgroundColor:[UIColor blackColor]];
//    [bannerView setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    NSLog(@"%@", NSStringFromCGSize(self.view.frame.size));
    
    UIView * banner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,140)];
    [banner setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:banner.frame];
    [scroll setBackgroundColor:[UIColor lightGrayColor]];
    [scroll setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [scroll setContentSize:CGSizeMake(banner.frame.size.width*2, banner.frame.size.height)];
    
    [banner addSubview:scroll];
    [self.tableView setTableHeaderView:banner];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    [self setTitle:@"Promociones"];
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = kPromosClassName;
        

        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
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
    
    ARFPromosDetailViewController *promoDetailVC = [[ARFPromosDetailViewController alloc] initWithPromo:promo];
    [self.navigationController pushViewController:promoDetailVC animated:YES];
}

@end
