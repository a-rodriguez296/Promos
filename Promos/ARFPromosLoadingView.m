//
//  ARFPromosLoadingView.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/18/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPromosLoadingView.h"

@interface ARFPromosLoadingView ()




@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation ARFPromosLoadingView

//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        
//        self.view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
////        [self addSubview:self.view];
//        return self;
//    }
//    return nil;
//}


-(void) stopLoading{
    
    [self.activityIndicator stopAnimating];
}



@end
