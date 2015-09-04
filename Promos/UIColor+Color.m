//
//  UIColor+Color.m
//  Promos
//
//  Created by Alejandro Rodriguez on 9/4/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "UIColor+Color.h"

@implementation UIColor (Color)

+(UIColor *) generateColorWithRed:(double)red green:(double) green blue:(double) blue alpha:(double) alpha{
    
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:alpha];
    
}

@end
