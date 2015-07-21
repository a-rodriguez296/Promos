//
//  ARFPromoCell.m
//  Promos
//
//  Created by Alejandro Rodriguez on 7/21/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPromoCell.h"
#import "ARFConstants.h"

@interface ARFPromoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imagePromo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;


@end

@implementation ARFPromoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureCellWithPFObject:(PFObject *) object{
    
    self.lblTitle.text = [object objectForKey:kPromosAttributeTitle];
    NSLog(@"%@",self.lblTitle.text);
    self.lblSubtitle.text = [object objectForKey:kPromosAttributeSubtitle];
    NSLog(@"%@", self.lblSubtitle.text);
}

@end
