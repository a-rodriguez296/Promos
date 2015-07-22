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

@interface ARFPromosDetailViewController ()

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donwloadPass:(id)sender {
    
    PFFile *pass = [self.promo objectForKey:kPromosAttributePass];
    [pass getDataInBackgroundWithBlock:^(NSData * result, NSError * error){
        
    }progressBlock:^(int percentDone){
        NSLog(@"%i", percentDone);
    }];
    
}


@end
