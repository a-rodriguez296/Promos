//
//  ARFPromosViewController.h
//  Promos
//
//  Created by Alejandro Rodriguez on 7/21/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//


#import "ARFPromosBannerView.h"
#import "ARFPromoCell.h"

#import "PFQueryTableViewController.h"

@interface ARFPromosViewController : PFQueryTableViewController <ARFPromosBannerDelegate,ARFPromoCellDelegate>

@end
