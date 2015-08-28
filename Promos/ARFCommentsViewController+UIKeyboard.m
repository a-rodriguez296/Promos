//
//  ARFCommentsViewController+UIKeyboard.m
//  Promos
//
//  Created by Alejandro Rodriguez on 8/31/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import "ARFCommentsViewController+UIKeyboard.h"

@implementation ARFCommentsViewController (UIKeyboard)

//UIKeyboardWillShowNotification
-(void)keyboardWillAppear:(NSNotification *) notification{
    
    NSDictionary *userInfo = notification.userInfo;
    
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSNumber *animationCurve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSNumber *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [self.containerViewBottomCst setConstant:endFrame.size.height];
    
    @weakify(self);
    [UIView animateKeyframesWithDuration:[animationDuration doubleValue] delay:0 options:[animationCurve intValue] animations:^{
        @strongify(self);
        
        [self.containerView layoutIfNeeded];
        
    } completion:nil];
}

//UIKeyboardWillHideNotification
-(void)keyboardWillHide:(NSNotification *) notification{
    NSDictionary *userInfo = notification.userInfo;
    
    NSNumber *animationCurve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSNumber *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [self.containerViewBottomCst setConstant:0];
    
    @weakify(self);
    [UIView animateKeyframesWithDuration:[animationDuration doubleValue] delay:0 options:[animationCurve intValue] animations:^{
        @strongify(self);
        
        
        [self.containerView layoutIfNeeded];
        
    } completion:nil];
    
}

@end
