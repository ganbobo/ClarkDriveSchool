//
//  CarOrderFooterReusableView.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/6.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CarOrderFooterReusableView.h"

@interface CarOrderFooterReusableView () {
    UIButton *_btnSubmit;
}

@end

@implementation CarOrderFooterReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnSubmit.frame = CGRectMake(10, self.height - 70, ScreenWidth - 20, 40);
        _btnSubmit.layer.cornerRadius = 5;
        _btnSubmit.layer.masksToBounds = YES;
        [_btnSubmit setBackgroundImage:[self createImageWithColor:RGBA(0x3a, 0xa7, 0x57, 1)] forState:UIControlStateNormal];
        [_btnSubmit setBackgroundImage:[self createImageWithColor:RGBA(0x99, 0x99, 0x99, 1)] forState:UIControlStateDisabled];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit setTitle:@"确定预约" forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnSubmit];
    }
    return self;
}

- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)clickSubmit {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickSubmit)]) {
        [_delegate didClickSubmit];
    }
}

- (void)enableBtnSubmit:(BOOL)enabled {
    _btnSubmit.enabled = enabled;
}

@end
