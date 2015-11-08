//
//  CarOrderFooterReusableView.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/6.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CarOrderFooterReusableView.h"

@implementation CarOrderFooterReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(10, self.height - 70, ScreenWidth - 20, 40);
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor colorWithRed:0.074 green:0.715 blue:0.169 alpha:1.000];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"确定预约" forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    return self;
}

@end
