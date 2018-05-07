//
//  TestView.m
//  RXCategoryExample
//
//  Created by Rush.D.Xzj on 02/01/2018.
//  Copyright © 2018 Rush.D.Xzj. All rights reserved.
//

#import "TestView.h"

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uiTextViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    NSLog(@"drawRect");
}



#pragma mark - Notification
- (void)uiTextViewTextDidChangeNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}


@end
