//
//  CarOrderCollectionViewCell.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/6.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CarOrderCollectionViewCell.h"


@interface CarOrderCollectionViewCell () {
    
    __weak IBOutlet UILabel *_lblTitle;
    __weak IBOutlet UIButton *_btnSelect;
    __weak IBOutlet UILabel *_lblState;
}

@end

@implementation CarOrderCollectionViewCell

- (void)awakeFromNib {
    _btnSelect.userInteractionEnabled = NO;
    _lblState.hidden = YES;
    [_btnSelect setImage:[UIImage imageNamed:@"order_car_select"] forState:UIControlStateSelected];
    [_btnSelect setImage:[self createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
}


- (void)refreshCellByInfo:(CarOrderInfo *)info {
    _lblTitle.text = info.titleName;
    _btnSelect.selected = info.select;
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
