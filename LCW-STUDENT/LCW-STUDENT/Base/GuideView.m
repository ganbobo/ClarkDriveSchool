//
//  GuideView.m
//  V2gogo
//
//  Created by St.Pons Mr.G on 15/5/20.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "GuideView.h"

@interface GuideView()<UIScrollViewDelegate> {
    UIScrollView *_scrollView;
}

@end

@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadScrollView];
    }
    return self;
}

- (void)loadScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    [self loadImageView];
}

- (void)loadImageView {
    for (int i = 0; i < 3; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scrollView.width, 0, _scrollView.width, _scrollView.height)];
        NSString *imgName = [NSString stringWithFormat:@"%d-480h@2x.jpg", i + 1];
        if (IPHONE5 || IPHONE6 || IPHONE6PLUS) {
            imgName = [NSString stringWithFormat:@"%d@2x.jpg", i + 1];
        }
        
        imgView.image = [UIImage imageNamed:imgName];
        [_scrollView addSubview:imgView];
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.width * 4, _scrollView.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == scrollView.width * 3) {
//        [self removeFromSuperview];
        self.hidden = YES;
    }
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
}

@end
