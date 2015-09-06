//
//  ARFPromoDonwloaderHelper.m
//  Promos
//
//  Created by Alejandro Rodriguez on 9/5/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPromoDonwloaderHelper.h"
#import "ARFPassApiClient.h"
#import "ARFConstants.h"



#import <MBProgressHUD/MBProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation ARFPromoDonwloaderHelper

+(void) donwloadPassWithObject:(PFObject *) object aViewController:(UIViewController<PKAddPassesViewControllerDelegate> *) vc{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
    hud.labelText = @"Cargando";
    
    
    NSString *passURL = [object objectForKey:kPromosAttributePassURL];
    ARFPassApiClient *passApiClient = [ARFPassApiClient sharedClient];
    
    @weakify(vc, hud);
    [passApiClient downloadPassWithId:passURL withSuccess:^(NSData *passData) {
        
        @strongify(vc, hud);
        [hud hide:YES];
        if (![PKPassLibrary isPassLibraryAvailable]) {
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:@"PassKit not available"
                                       delegate:nil
                              cancelButtonTitle:@"Pitty"
                              otherButtonTitles: nil] show];
            return;
        }
        else{
            
            
            NSError* error = nil;
            PKPass *newPass = [[PKPass alloc] initWithData:passData
                                                     error:&error];
            PKAddPassesViewController *addController =
            [[PKAddPassesViewController alloc] initWithPass:newPass];
            
            addController.delegate = vc;
            [vc presentViewController:addController
                               animated:YES
                             completion:nil];
            
        }
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


@end
