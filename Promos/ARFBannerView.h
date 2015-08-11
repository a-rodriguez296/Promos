//
//  ARFBannerView.h
//  Promos
//
//  Created by Alejandro Rodriguez on 7/31/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ParseUI/ParseUI.h>

@protocol ARFBannerDelegate;

@interface ARFBannerView : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) id<ARFBannerDelegate> delegate;

-(id) initWithFrame:(CGRect)frame objects:(NSArray *) objects;


@end


@protocol ARFBannerDelegate <NSObject>

@required
-(void) ARFBannerView:(ARFBannerView *) bannerView didTouchBannerAtIndex:(NSUInteger) index object:(PFObject *) object;

@end