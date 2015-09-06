//
//  ARFPromoDonwloaderHelper.h
//  Promos
//
//  Created by Alejandro Rodriguez on 9/5/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

#import <Parse/Parse.h>

@interface ARFPromoDonwloaderHelper : NSObject

+(void) donwloadPassWithObject:(PFObject *) object aViewController:(UIViewController<PKAddPassesViewControllerDelegate> *) vc;



@end
