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

@protocol ARFPromoCellDelegate;



@interface ARFPromoCell : PFTableViewCell

@property (nonatomic, weak) id<ARFPromoCellDelegate> delegate;


-(void) configureCellWithPFObject:(PFObject *) object;

@end


@protocol ARFPromoCellDelegate <NSObject>

-(void) didTapDownloadWithCell:(ARFPromoCell *) cell;

@end