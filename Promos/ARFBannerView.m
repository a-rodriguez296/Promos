//
//  ARFBannerView.m
//  Promos
//
//  Created by Alejandro Rodriguez on 7/31/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBannerView.h"

#include <stdlib.h>

@interface ARFBannerView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ARFBannerView

-(void)awakeFromNib{
    
    [self addButtonAtPosition:0];
    
    for (int i = 1; i<5; i++) {
        
        [self addButtonAtPosition:i];
    }
    
    NSLog(@"%f", self.frame.size.width);
    [self.scrollView setContentSize:CGSizeMake(self.frame.size.width * 6, self.frame.size.height)];
    
    [self.scrollView setBounces:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) animated:NO];
}


-(void)addButtonAtPosition:(NSUInteger) position{
    
    
    UIView *btn = [[UIView alloc] initWithFrame:CGRectMake(position * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [btn setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1.0f]];
    [self.scrollView addSubview:btn];
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
}


@end
