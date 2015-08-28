//
//  ARFCommentsCell.h
//  Promos
//
//  Created by Alejandro Rodriguez on 8/31/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>

@interface ARFCommentsCell : UITableViewCell


-(void) configureCellWithObject:(PFObject *) object;

@end
