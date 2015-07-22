//
//  ARFPromoCell.h
//  Promos
//
//  Created by Alejandro Rodriguez on 7/21/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface ARFPromoCell : PFTableViewCell

-(void) configureCellWithPFObject:(PFObject *) object;

@end
