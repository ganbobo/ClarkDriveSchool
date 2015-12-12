//
//  CarOrderCollectionViewCell.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/6.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CarOrderCollectionViewCell.h"


@interface CarOrderCollectionViewCell () {
    
    __weak IBOutlet UILabel *_lblTopic;
    __weak IBOutlet UILabel *_lblTitle;
    __weak IBOutlet UIImageView *_imgSelect;
    __weak IBOutlet UILabel *_lblState;
}

@end

@implementation CarOrderCollectionViewCell

- (void)awakeFromNib {

    _lblState.hidden = YES;
    _imgSelect.hidden = YES;
}


- (void)refreshCellByInfo:(CourseModel *)info {
    _lblTitle.text = info.timePeriod;
    _imgSelect.hidden = !info.select;
    _lblState.text = info.noPost ? @"未发布" : @"";
}

- (void)refreshCellByIsFull:(NSInteger)isfull andYue:(NSInteger)yue {
    if (isfull) {
        _lblState.hidden = NO;
        _lblState.text = @"已满";
        _lblState.textColor = RGBA(0x69, 0x69, 0x69, 1);
        _lblState.backgroundColor = RGBA(0xbb, 0xbb, 0xbb, 1);
    } else {
        _lblState.hidden = YES;
    }
    
    if (yue) {
        _lblState.text = @"已约";
        _lblState.backgroundColor = RGBA(0x3a, 0xa7, 0x57, 1);
        _lblState.textColor = RGBA(0xff, 0xff, 0xff, 1);
        _lblState.hidden = NO;
    }
}

- (void)refreshCellByType:(NSInteger)type {
    if (type == 1) {
        _lblTopic.hidden = NO;
    } else {
        _lblTopic.hidden = YES;
    }
    
    if (type == 2) {
        _lblState.hidden = NO;
        _lblState.text = @"休息";
        _lblState.textColor = RGBA(0x69, 0x69, 0x69, 1);
        _lblState.backgroundColor = RGBA(0xbb, 0xbb, 0xbb, 1);
    }
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

@end
