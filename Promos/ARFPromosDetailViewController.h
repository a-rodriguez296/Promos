//
//  ARFPromosDetailViewController.h
//  Promos
//
//  Created by Alejandro Rodriguez on 7/21/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBaseViewController.h"


@import UIKit;
@import Social;
#import <Parse/Parse.h>


@interface ARFPromosDetailViewController : ARFBaseViewController

@property (nonatomic, strong) PFObject * promo;


-(id) initWithPromo:(PFObject *) promo;

@end
