//
//  ARFPromosBannerView+iCarousel.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/17/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPromosBannerView+iCarousel.h"
#import "ARFConstants.h"

#import <ParseUI/ParseUI.h>

@implementation ARFPromosBannerView (iCarousel)

#pragma mark iCarousel Delegate
-(UIView * __nonnull)carousel:(iCarousel * __nonnull)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable PFImageView *)view{
    
    PFImageView *imgView;
    PFObject *currentObject = self.objects[index];
    PFFile * file = [currentObject objectForKey:kPromosAttributeFeaturedImage];
    
    if (!view) {
        imgView = [[PFImageView alloc] initWithFrame:self.frame];
    }
    
    [imgView setFile:file];
    [imgView loadInBackground];
    
    return imgView;
}

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return self.objects.count;
}


#pragma mark iCarouselDelegate
-(void)carousel:(iCarousel * __nonnull)carousel didSelectItemAtIndex:(NSInteger)index{
    
    if (self.delegate) {
        [self.delegate ARFBannerView:self didTouchBannerAtIndex:index object:self.objects[index]];
    }
}


- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.0f;
        }
            
        default:
            return value;
    }
}


-(void)carouselWillBeginDragging:(iCarousel * __nonnull)carousel{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(carouselMoveToNext)object: nil];
}

-(void)carouselDidEndDecelerating:(iCarousel * __nonnull)carousel{

    [self performSelector:@selector(carouselMoveToNext) withObject:nil afterDelay:kPromosBannerAnimationConstant];
}

@end
