//
//  ADScrollView.m
//  
//
//  Created by St.Pons Mr.G on 15/02/20.
//  Copyright (c) 2014年 St.Pons Mr.G. All rights reserved.
//

#import "ADScrollView.h"
#import "PageControl.h"

#define kDuration   4 // 定义多少秒跳一次
#define kNotiHeight 35

@interface ADScrollView()<UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    NSInteger _pageIndex;
    NSInteger _pageCount;
    
    UIImageView *_noteView;
    PageControl *_pageControl;
    UILabel *_mesageLabel;
}

@end

@implementation ADScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        //说明文字层
        _noteView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height - kNotiHeight, self.width, kNotiHeight)];
        _noteView.backgroundColor = [UIColor clearColor];
        [self addSubview:_noteView];
        
        _mesageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, _noteView.width - 20, _noteView.height - 4)];
        _mesageLabel.backgroundColor = [UIColor clearColor];
        _mesageLabel.textColor = RGBA(0xff, 0xff, 0xff, 1);
        _mesageLabel.textAlignment = NSTextAlignmentLeft;
        _mesageLabel.font = [UIFont boldSystemFontOfSize:13];
        [_noteView addSubview:_mesageLabel];
    }
    return self;
}
- (void)addViewFromList:(NSArray *)list {
    for (UIView *view in _scrollView.subviews) {
        [view removeFromSuperview];
        [_scrollView setContentSize:CGSizeMake(_scrollView.width, _scrollView.height)];
    }
    
    for (UIView *view in list) {
        [_scrollView addSubview:view];
    }
    
    // 重置页码
    [self resetPage:list];
    
    // 添加下面的页码
    NSInteger page = 1;
    if (_pageCount > 1) {
        page = _pageCount - 2;
    }
    
    if ( !_pageControl) {
        _pageControl = [[PageControl alloc]initWithFrame:CGRectMake(0, _noteView.height - 25, _noteView.width, 15)];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.backgroundColor = RGBA(0x11, 0x11, 0x11, 0.2);
        _pageControl.layer.masksToBounds = YES;
        _pageControl.layer.cornerRadius = 8;
    }
    [_pageControl removeFromSuperview];
    [_noteView addSubview:_pageControl];
    _pageControl.numberOfPages = page;
    _pageControl.currentPage = 0;
    
    [_pageControl setWidth:_pageControl.pageControlWidth];
    _pageControl.centerX = _noteView.width / 2.0;
    
}

- (void)setMessage:(NSString *)message {
    _mesageLabel.text = message;
}

#pragma - mark UIScrollViewDelegate 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 取消自动计时跳转
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollToNextPage) object:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 取消自动计时跳转
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollToNextPage) object:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageIndex = scrollView.contentOffset.x / _scrollView.width;
    [self scrollToPage:_pageIndex];
}

#pragma - mark 跳转

/**
 *  跳转到下一页
 */
- (void)scrollToNextPage {
    _pageIndex ++;
    [UIView animateWithDuration:0.25 animations:^{
        // 动画跳转到下一页
        [_scrollView setContentOffset:CGPointMake(_pageIndex * _scrollView.width, 0)];
    } completion:^(BOOL finished) {
        if (_pageIndex == _pageCount - 1) {
            _pageIndex = 1;
            [_scrollView setContentOffset:CGPointMake(_pageIndex * _scrollView.width, 0)];
        }
        
        if (_pageIndex == 0) {
            _pageIndex = _pageCount - 2;
            [_scrollView setContentOffset:CGPointMake(_pageIndex * _scrollView.width, 0)];
        }
        
        _pageControl.currentPage = _pageIndex - 1;
        
        if (_delegate && [_delegate respondsToSelector:@selector(scrollToPageIndex:)]) {
            [_delegate scrollToPageIndex:_pageControl.currentPage];
        }
    }];
    
    if (_pageCount > 0)
        // 开启自动跳转
        [self performSelector:@selector(scrollToNextPage) withObject:nil afterDelay:kDuration];
}


- (void)scrollToPage:(NSInteger)pageIndex {
    // 赋值当前页码
    _pageIndex = pageIndex;
    [UIView animateWithDuration:0.25 animations:^{
        // 动画跳转到下一页
        [_scrollView setContentOffset:CGPointMake(_pageIndex * _scrollView.width, 0)];
    } completion:^(BOOL finished) {
        if (_pageIndex == _pageCount - 1) {
            _pageIndex = 1;
            [_scrollView setContentOffset:CGPointMake(_pageIndex * _scrollView.width, 0)];
        }
        
        if (_pageIndex == 0) {
            _pageIndex = _pageCount - 2;
            [_scrollView setContentOffset:CGPointMake(_pageIndex * _scrollView.width, 0)];
        }
        
        _pageControl.currentPage = _pageIndex - 1;
        
        if (_delegate && [_delegate respondsToSelector:@selector(scrollToPageIndex:)]) {
            [_delegate scrollToPageIndex:_pageControl.currentPage];
        }
    }];
    
    if (_pageCount > 0)
        // 开启自动跳转
        [self performSelector:@selector(scrollToNextPage) withObject:nil afterDelay:kDuration];
}

/**
 *  重置到第一页
 */

- (void)resetPage:(NSArray *)list {
    _pageCount = list.count;
    // 取消自动计时跳转
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollToNextPage) object:nil];
    if (list.count > 1) { // 如果大于一页 调到索引为1的为第一页，因为在前面加了最后一个，在最后加了第一个
        _pageIndex = 1;
        [_scrollView setContentOffset:CGPointMake(_scrollView.width, 0)];
        _pageControl.currentPage = _pageIndex - 1;
        // 开启跳转到下-页
        [self performSelector:@selector(scrollToNextPage) withObject:nil afterDelay:kDuration];
    } else {
        _pageIndex = 0;
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.width * list.count, _scrollView.height)];
    
    if (_delegate && [_delegate respondsToSelector:@selector(scrollToPageIndex:)]) {
        [_delegate scrollToPageIndex:_pageControl.currentPage];
    }
}

/**
 *  跳转到第一页
 */

- (void)resetFirstPage {
    if (_pageCount > 1) {
        _pageIndex = 1;
        [_scrollView setContentOffset:CGPointMake(_scrollView.width, 0)];
        _pageControl.currentPage = _pageIndex - 1;
        if (_delegate && [_delegate respondsToSelector:@selector(scrollToPageIndex:)]) {
            [_delegate scrollToPageIndex:_pageControl.currentPage];
        }
        // 开启跳转到下-页
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollToNextPage) object:nil];
        [self performSelector:@selector(scrollToNextPage) withObject:nil afterDelay:kDuration];
    } else {
        _pageIndex = 0;
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

@end
