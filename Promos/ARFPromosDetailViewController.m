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
    
    PFFile *pass = [self.promo objectForKey:kPromosAttributePass];
    [pass getDataInBackgroundWithBlock:^(NSData * result, NSError * error){
        
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
        NSLog(@"%i", percentDone);
    }];
    
}


#pragma mark - Pass controller delegate

-(void)addPassesViewControllerDidFinish: (PKAddPassesViewController*) controller
{
    //pass added
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
