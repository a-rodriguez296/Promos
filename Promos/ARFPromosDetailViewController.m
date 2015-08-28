//
//  ARFPromosDetailViewController.m
//  Promos
//
//  Created by Alejandro Rodriguez on 7/21/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPromosDetailViewController.h"
#import "ARFConstants.h"
#import "ARFPassApiClient.h"
#import "ARFCommentsViewController.h"


#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <PassKit/PassKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface ARFPromosDetailViewController () <PKAddPassesViewControllerDelegate>
@property (weak, nonatomic) IBOutlet PFImageView *imgDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;

@end

@implementation ARFPromosDetailViewController




-(id) initWithPromo:(PFObject *) promo{
    
    self = [super init];
    if (self) {
        _promo = promo;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setTitle:@"Detalle"];
    
    
    [self.lblTitle setText:[self.promo objectForKey:kPromosAttributeTitle]];
    [self.lblSubtitle setText:[self.promo objectForKey:kPromosAttributeSubtitle]];
    [self.imgDetail setFile:[self.promo objectForKey:kPromosAttributeLogo]];
    [self.imgDetail loadInBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions
- (IBAction)donwloadPass:(id)sender {
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Cargando";
    
    NSString *passURL = [self.promo objectForKey:kPromosAttributePassURL];
    ARFPassApiClient *passApiClient = [ARFPassApiClient sharedClient];
    
    @weakify(self, hud);
    [passApiClient downloadPassWithId:passURL withSuccess:^(NSData *passData) {
        
        @strongify(self, hud);
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
            
            addController.delegate = self;
            [self presentViewController:addController
                               animated:YES
                             completion:nil];
            
        }

        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
- (IBAction)showComments:(id)sender {
    
    ARFCommentsViewController * commentsVC = [[ARFCommentsViewController alloc] initWithObject:self.promo];
    [commentsVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:commentsVC animated:YES];
    
}

- (IBAction)shareOnTwitter:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:[NSString stringWithFormat:@"Con Promo's acabo de obtener un %@ en %@", [self.promo objectForKey:kPromosAttributeTitle],[self.promo objectForKey:kPromosAttributeSubtitle]]];
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultDone)
             {
                 //TODO poner tracker de evento que compartió en Twitter la promo
                 NSLog(@"The user sent the tweet");
             }
             else{
                 //TODO Poner tracker de evento que se arrepintió de compartir en Twitter
             }
         }];
        [self presentViewController:tweet animated:YES completion:nil];
        
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Para compartir en Twitter debes tener una cuenta instalada en tu celular" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alertView show];
    }
    
}
- (IBAction)shareOnFacebook:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *facebookPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookPost setInitialText:[NSString stringWithFormat:@"Con Promo's acabo de obtener un %@ en %@", [self.promo objectForKey:kPromosAttributeTitle],[self.promo objectForKey:kPromosAttributeSubtitle]]];
        [facebookPost setCompletionHandler:^(SLComposeViewControllerResult result){
           
            
            if (result == SLComposeViewControllerResultDone) {
                
                //TODO poner tracker de evento que compartió en Facebook la promo
                
            }
            else{
                //TODO Poner tracker de evento que se arrepintió de compartir en Facebook
            }
            
        }];
        [self presentViewController:facebookPost animated:YES completion:nil];
    
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Atención" message:@"Para compartir en Facebook debes tener una cuenta instalada en tu celular" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark - Pass controller delegate

-(void)addPassesViewControllerDidFinish: (PKAddPassesViewController*) controller
{
    //pass added
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
