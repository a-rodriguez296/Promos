//
//  ARFPromosVC.h
//  Promos
//
//  Created by Alejandro Rodriguez on 8/16/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <Parse/Parse.h>


@protocol ARFPromosBannerDelegate;

@interface ARFPromosBannerView : UIView 


@property (nonatomic, weak) id<ARFPromosBannerDelegate> delegate;
@property (nonatomic, strong) NSArray * objects;


-(void) carouselMoveToNext;


@end


@protocol ARFPromosBannerDelegate <NSObject>

@required
-(void) ARFBannerView:(ARFPromosBannerView *) bannerView didTouchBannerAtIndex:(NSUInteger) index object:(PFObject *) object;
@end
