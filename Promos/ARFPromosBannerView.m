//
//  ARFPromosVC.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/16/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPromosBannerView.h"
#import "ARFConstants.h"
#import "ARFPromosLoadingView.h"


#import "iCarousel.h"

@interface ARFPromosBannerView ()

@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@property (weak, nonatomic) IBOutlet ARFPromosLoadingView *loadingView;

@end


@implementation ARFPromosBannerView


-(void) setObjects:(NSArray *)objects{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(carouselMoveToNext)object: nil];
    
    _objects = objects;
    
    [self.loadingView stopLoading];
    [self.loadingView setHidden:YES];
    [self.carousel reloadData];
    [self carouselMoveToNext];
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self.loadingView addSubview:[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ARFPromosLoadingView class]) owner:nil options:nil] firstObject]];
    
}

-(void) carouselMoveToNext{
    
    NSInteger nextIndex = self.carousel.currentItemIndex;
    nextIndex++;
    
    [self.carousel scrollToItemAtIndex:nextIndex duration:kPromosBannerScrollTimeConstant];
    [self performSelector:@selector(carouselMoveToNext) withObject:nil afterDelay:kPromosBannerAnimationConstant];
}

@end
