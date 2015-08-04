//
//  ARFBannerView.m
//  Promos
//
//  Created by Alejandro Rodriguez on 7/31/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFBannerView.h"

#import "PureLayout.h"
#include <stdlib.h>

static NSUInteger const kNumberBannerAds = 4;

@interface ARFBannerView ()

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, copy) UIScrollView *scrollView;
@property (nonatomic, assign) NSUInteger currentPosition;


@end

@implementation ARFBannerView


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
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
    
    NSLog(@"%f", self.frame.size.width);
    [self.scrollView setContentSize:CGSizeMake(self.frame.size.width * (kNumberBannerAds +2), self.frame.size.height)];
    
    [self.scrollView setBounces:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    
    [self moveToNext];
    
    
}

-(void) moveToNext{
    
    [self.scrollView scrollRectToVisible:CGRectMake(self.frame.size.width*(self.currentPosition +1), 0, self.frame.size.width, self.frame.size.height) animated:YES];
    if (self.currentPosition==kNumberBannerAds) {
        self.currentPosition = 0;
    }
    else{
      self.currentPosition++;
    }
    
    [self performSelector:@selector(moveToNext) withObject:nil afterDelay:4.0];
}

-(void)addButtonAtPosition:(NSUInteger) position{
    
    
    UIView *btn = [[UIView alloc] initWithFrame:CGRectMake(position * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [btn setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1.0f]];
//    if (position==0) {
//        [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"image4.jpg"]]];
//    }
//    else if (position == 5){
//        [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"image1.jpg"]]];
//    }
//    else{
//        [btn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%zu.jpg",position]]]];
//    }
    
    [self.scrollView addSubview:btn];
}


#pragma mark UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    

//
//    if (scrollView.contentOffset.x == 0) {
//        
//        //Viene de la primera imagen a la última
//        
//        //Posicionar el scroll en la ultima imagen
//        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * 4,0,self.frame.size.width,self.frame.size.height) animated:NO];
//    }
//    else if(scrollView.contentOffset.x == self.frame.size.width * 4){
//        
//        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width ,0,self.frame.size.width,self.frame.size.height) animated:NO];
//    }
    
    if (scrollView.contentOffset.x == 0) {
        // user is scrolling to the left from image 1 to image 4
        // reposition offset to show image 4 that is on the right in the scroll view
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width * kNumberBannerAds,0,320,416) animated:NO];
    }
    else if (scrollView.contentOffset.x == self.frame.size.width * (kNumberBannerAds +1)) {
        // user is scrolling to the right from image 4 to image 1
        // reposition offset to show image 1 that is on the left in the scroll view
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width,0,320,416) animated:NO];
    } 

    
}




//-(void)awakeFromNib{
//
//    [self addButtonAtPosition:0];
//
//    for (int i = 1; i<5; i++) {
//
//        [self addButtonAtPosition:i];
//    }
//
//    NSLog(@"%f", self.frame.size.width);
//    [self.scrollView setContentSize:CGSizeMake(self.frame.size.width * 6, self.frame.size.height)];
//
//    [self.scrollView setBounces:NO];
//    [self.scrollView setShowsHorizontalScrollIndicator:NO];
//
//    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) animated:NO];
//}



@end
