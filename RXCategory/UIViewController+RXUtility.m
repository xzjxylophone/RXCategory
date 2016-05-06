//
//  UIViewController+RXUtility.m
//  RXCategoryExample
//
//  Created by ceshi on 16/5/6.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import "UIViewController+RXUtility.h"

@implementation UIViewController (RXUtility)
- (void)__private_tapAnywhereToHideKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}


- (void)rx_tapAnywhereToHideKeyboard
{
    __weak __typeof(self) weakSelf = self;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__private_tapAnywhereToHideKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        [weakSelf.view addGestureRecognizer:singleTapGR];
    }];
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        [weakSelf.view removeGestureRecognizer:singleTapGR];
    }];
}



@end
