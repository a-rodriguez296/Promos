//
//  ARFCommerceCell.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/11/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommerceCell.h"
#import "ARFConstants.h"

#import "UAPush.h"
#import "UAirship.h"

@interface ARFCommerceCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblCommerceName;

@property (weak, nonatomic) IBOutlet UISwitch *switchNotifications;

@end

@implementation ARFCommerceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) configureCellWithPFObject:(PFObject *) object{
    
    [self.lblCommerceName setText:[object objectForKey:kCommerceAttributeName]];
    
    [self.switchNotifications setSelected:[self deviceContainsTagWithName:[object objectForKey:kCommerceAttributeName]]];
    
//    [[UAirship push] addTag:[object objectForKey:kCommerceAttributeName]];
//    [[UAirship push] updateRegistration];
}



-(BOOL) deviceContainsTagWithName:(NSString *) tagName{
    return [[UAirship push].tags containsObject:tagName];
}

@end
