//
//  ARFCommerceCell.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/14/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommerceCell.h"
#import "ARFConstants.h"

#import "UAPush.h"
#import "UAirship.h"

@interface ARFCommerceCell ()


@property (nonatomic, strong) PFObject * object;



@property (weak, nonatomic) IBOutlet UILabel *lblCommerceName;

@property (weak, nonatomic) IBOutlet UIButton *btnNotifications;


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
    
    self.object = object;
    
    [self.lblCommerceName setText:[object objectForKey:kCommerceAttributeName]];
    [self.btnNotifications setSelected:[self deviceContainsTagWithName:[object objectForKey:kCommerceAttributeName]]];
    [self.btnNotifications addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(BOOL) deviceContainsTagWithName:(NSString *) tagName{
    return [[UAirship push].tags containsObject:tagName];
}

-(void) didTapButton:(id) sender{
    
    UIButton *btnNotifications = (UIButton *) sender;
    if (!btnNotifications.selected) {
        [[UAirship push] addTag:[self.object objectForKey:kCommerceAttributeName]];
    }
    else{
        [[UAirship push] removeTag:[self.object objectForKey:kCommerceAttributeName]];
    }
    [[UAirship push] updateRegistration];
    
    
    [btnNotifications setSelected:!self.btnNotifications.selected];
    
}


@end
