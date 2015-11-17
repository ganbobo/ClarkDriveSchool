//
//  PageControl.m
//  V2gogo
//
//  Created by ClarkGan on 15/7/11.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "PageControl.h"

#define kPageControlWidth  5
#define kPageControlHeight 5
#define kPageSpace         5

@implementation PageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat width = (kPageControlWidth + kPageSpace) * numberOfPages;
    _pageControlWidth = width + 5;
    CGFloat startX = 5;
    for (NSInteger i = 0; i < numberOfPages; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(startX + (kPageControlWidth + kPageSpace) * i, (self.height - kPageControlHeight) / 2.0, kPageControlWidth, kPageControlHeight)];
        view.layer.cornerRadius = kPageControlHeight / 2.0;
        if (i == _currentPage) {
            view.backgroundColor = [UIColor colorWithRed:0.149 green:0.655 blue:0.341 alpha:1.000];
        } else {
            view.backgroundColor = [UIColor whiteColor];
        }
        view.tag = i + 1;
        [self addSubview:view];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    for (NSInteger i = 0; i < _numberOfPages; i ++) {
        UIView *view = [self viewWithTag:i + 1];
        if (i == _currentPage) {
            view.backgroundColor = [UIColor colorWithRed:0.149 green:0.655 blue:0.341 alpha:1.000];
        } else {
            view.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
