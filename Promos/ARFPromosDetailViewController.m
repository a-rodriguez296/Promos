//
//  ARFPromosDetailViewController.m
//  Promos
//
//  Created by Alejandro Rodriguez on 7/21/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFPromosDetailViewController.h"
#import "ARFConstants.h"

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

- (IBAction)donwloadPass:(id)sender {
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Cargando";
    
    @weakify(hud,self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        PFFile *pass = [self.promo objectForKey:kPromosAttributePass];
        [pass getDataInBackgroundWithBlock:^(NSData * result, NSError * error){
            @strongify(hud,self)
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
                PKPass *newPass = [[PKPass alloc] initWithData:result
                                                         error:&error];
                PKAddPassesViewController *addController =
                [[PKAddPassesViewController alloc] initWithPass:newPass];
                
                addController.delegate = self;
                [self presentViewController:addController
                                   animated:YES
                                 completion:nil];
                
            }
            
            
        }progressBlock:^(int percentDone){
            @strongify(hud)
            hud.progress = percentDone;
        }];
        
    });
    
    
}


#pragma mark - Pass controller delegate

-(void)addPassesViewControllerDidFinish: (PKAddPassesViewController*) controller
{
    //pass added
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
