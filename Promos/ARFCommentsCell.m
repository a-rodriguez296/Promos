//
//  ARFCommentsCell.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/31/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommentsCell.h"
#import "ARFConstants.h"



@interface ARFCommentsCell ()


@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end

@implementation ARFCommentsCell


-(void)prepareForReuse{
    [super prepareForReuse];
    
    [self.lblUsername setText:nil];
    [self.lblComment setText:nil];
}


-(void) configureCellWithObject:(PFObject *) object{
    
    [self.lblUsername setText:@"Alejandro"];
    [self.lblComment setText:[object objectForKey:kCommentsAttributeText]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.lblDate setText:[dateFormatter stringFromDate:object.createdAt]];
}



@end
