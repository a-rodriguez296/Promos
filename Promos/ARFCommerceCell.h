//
//  ARFCommerceCell.h
//  Promos
//
//  Created by Alejandro Rodriguez on 8/14/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface ARFCommerceCell : PFTableViewCell


-(void) configureCellWithPFObject:(PFObject *) object;


@end
