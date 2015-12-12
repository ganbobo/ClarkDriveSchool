//
//  AdsView.m
//  Gtwy
//
//  Created by lion on 15/8/17.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import "AdsView.h"

#import <UIButton+AFNetworking.h>

@implementation AdsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(clickSelf) forControlEvents:UIControlEventTouchUpInside];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setAdsInfo:(AdsInfo *)adsInfo {
    _adsInfo = adsInfo;
//    [self setBackgroundImageForState:UIControlStateNormal withURL:getImageUrl(adsInfo.imagePath) placeholderImage:[UIImage imageNamed:@"nav_home_title"]];
    [self setBackgroundImage:[UIImage imageNamed:adsInfo.imagePath] forState:UIControlStateNormal];
}

- (void)clickSelf {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectAdsInfo:)]) {
        [_delegate didSelectAdsInfo:_adsInfo];
    }
}

@end
