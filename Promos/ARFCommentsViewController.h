//
//  ARFCommentsViewController.h
//  Promos
//
//  Created by Alejandro Rodriguez on 8/28/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//


@import UIKit;

#import <Parse/Parse.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ARFCommentsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewBottomCst;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(id) initWithObject:(PFObject *) object;

@end
