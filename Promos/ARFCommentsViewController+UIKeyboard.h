//
//  ARFCommentsViewController+UIKeyboard.h
//  Promos
//
//  Created by Alejandro Rodriguez on 8/31/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommentsViewController.h"

@interface ARFCommentsViewController (UIKeyboard)

-(void)keyboardWillAppear:(NSNotification *) notification;
-(void)keyboardWillHide:(NSNotification *) notification;


@end
