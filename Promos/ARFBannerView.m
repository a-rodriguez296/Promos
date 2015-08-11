//
//  ARFBannerView.m
//  Promos
//
//  Created by Alejandro Rodriguez on 7/31/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBannerView.h"
#import "ARFConstants.h"

#import "PureLayout.h"
#import <ParseUI/ParseUI.h>

static NSUInteger const kNumberBannerAds = 4;
static float const kBannerInterval = 3.0;

@interface ARFBannerView ()

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (nonatomic, copy) UIScrollView *scrollView;


@property(nonatomic, copy) NSArray * bannerObjects;
@property (nonatomic, assign) NSUInteger currentPosition;





@end

@implementation ARFBannerView


-(id) initWithFrame:(CGRect)frame objects:(NSArray *) objects;{
    
    if (self = [super initWithFrame:frame]) {
        
        _bannerObjects = objects;
        
        //Crear scrollView
        [self createScrollView];
        
        
        //Crear botones
        [self populateScrollView];
    }
    
    return self;
}


#pragma mark Auxiliary Methods

-(void) createScrollView{
    
    //Inicialización del scroll
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setBounces:YES];
    [self.scrollView setDelegate:self];
    [self addSubview:self.scrollView];
    [self.scrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    
    //Inicialización del currentPosition
    _currentPosition = 1;
}


-(void) populateScrollView{
   
    [self addButtonAtPosition:0];
    
    for (int i = 1; i<(kNumberBannerAds+1); i++) {
        
        [self addButtonAtPosition:i];
    }
    
    [self addButtonAtPosition:(kNumberBannerAds +1)];
    
    [self.scrollView setContentSize:CGSizeMake(self.frame.size.width * (kNumberBannerAds +2), self.frame.size.height)];
    
    [self.scrollView setBounces:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    
    
    [self performSelector:@selector(moveToNext) withObject:nil afterDelay:kBannerInterval];
    
    
}

-(void) moveToNext{
    
    self.currentPosition++;

    [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * self.currentPosition, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    
    if (self.currentPosition == (kNumberBannerAds +1)) {
        self.currentPosition = 1;
    }

    
    [self performSelector:@selector(moveToNext) withObject:nil afterDelay:kBannerInterval];
}

-(void)addButtonAtPosition:(NSUInteger) position{
    
    
    PFFile *imageFile;
    
    PFImageView *imageView = [[PFImageView alloc] initWithFrame:CGRectMake(position * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];

    
    if (position==0) {
        imageFile = [self.bannerObjects[3] objectForKey:kPromosAttributeFeaturedImage];
    }
    else if (position == 5){
        imageFile = [self.bannerObjects[0] objectForKey:kPromosAttributeFeaturedImage];
    }
    else{
        imageFile = [self.bannerObjects[position-1] objectForKey:kPromosAttributeFeaturedImage];
        
    }
    
    [imageView setFile:imageFile];
    [imageView loadInBackground];
//    [btn addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:imageView];
}


#pragma mark UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveToNext) object:nil];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //Poner el current position donde cayó el scrollView
    self.currentPosition = (scrollView.contentOffset.x / self.frame.size.width);
    
    //Hacer el manejo del scrollView
    [self handleScrollWithScrollView:scrollView];
    
    //Reactivar el carrusel
    [self performSelector:@selector(moveToNext) withObject:nil afterDelay:kBannerInterval];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self handleScrollWithScrollView:scrollView];
}

-(void) handleScrollWithScrollView:(UIScrollView *) scrollView{
    
    if (scrollView.contentOffset.x == 0) {
        
        //Viene de la primera imagen a la última en dirección a la izquierda
        //Posicionar el scroll en la ultima imagen
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * kNumberBannerAds,0,320,416) animated:NO];
    }
    else if (scrollView.contentOffset.x == self.frame.size.width * (kNumberBannerAds +1)) {
        
        //El usuario llega de la última foto a la primera en dirección a la derecha.
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width,0,320,416) animated:NO];
    }
}

#pragma mark Btn Actions

-(void) didTapButton:(id) sender{
    
    //El usuario hizo tap en el botón.
    
    if (self.delegate) {
        [self.delegate ARFBannerView:self didTouchBannerAtIndex:self.currentPosition];
    }
    
}

@end
