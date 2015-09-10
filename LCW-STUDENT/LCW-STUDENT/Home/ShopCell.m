//
//  ShopCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/8/29.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "ShopCell.h"
#import <UIImageView+AFNetworking.h>


@interface ShopCell () {
    
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblPrice;
    __weak IBOutlet UIButton *_btnTip;
    __weak IBOutlet UILabel *_lblSaleCount;
    __weak IBOutlet UILabel *_lblDistance;
    __weak IBOutlet UIView *_commentView;// 评价视图
}
@end

@implementation ShopCell

- (void)awakeFromNib {
    // Initialization code
    [_imgView setImageWithURL:getImageUrl(@"http://img11.360buyimg.com/da/jfs/t1828/282/1045058672/182151/a4bc083a/55e005fbNb4e59acd.jpg")];
    
    [_btnTip setBackgroundImage:nil forState:UIControlStateNormal];
    _btnTip.layer.borderColor = RGBA(0xfb, 0x4b, 0x00, 1).CGColor;
    _btnTip.layer.borderWidth = 0.5;
    _btnTip.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
