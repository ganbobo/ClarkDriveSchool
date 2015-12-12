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
    
    @private
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblPrice;
    __weak IBOutlet UIButton *_btnTip;
    __weak IBOutlet UILabel *_lblSaleCount;
    __weak IBOutlet UILabel *_lblDistance;
    __weak IBOutlet UIView *_commentView;// 评价视图
    __weak IBOutlet UILabel *_lblCouponPrice;
    __weak IBOutlet UILabel *_lblScore;
}
@end

@implementation ShopCell

- (void)awakeFromNib {
    
    [_btnTip setBackgroundImage:nil forState:UIControlStateNormal];
    _btnTip.userInteractionEnabled = NO;
    
    _imgView.layer.borderColor = RGBA(0xee, 0xee, 0xee, 1).CGColor;
    _imgView.layer.borderWidth = 0.5;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [line setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:line];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[L]-0-|" options:0 metrics:nil views:@{@"L": line}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[L(0.5)]-0-|" options:0 metrics:nil views:@{@"L": line}]];
    
    _lblDistance.hidden = _lblSaleCount.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshCellWithInfo:(ShopInfo *)shopInfo {
    if (shopInfo.latitude != 0 && shopInfo.longitude != 0) {
        _lblDistance.hidden = NO;
        if (shopInfo.distance == 0) {
            _lblDistance.text = @"定位失败";
        } else {
            _lblDistance.text = [NSString stringWithFormat:@"约%.2fkm", shopInfo.distance / 1000];
        }
    } else {
        _lblDistance.hidden = YES;
    }
    _lblName.text = shopInfo.driving_name;
    _lblPrice.text = [NSString stringWithFormat:@"￥%ld", (long)shopInfo.driving_price];
    _lblScore.text = [NSString stringWithFormat:@"%.1f", (CGFloat)shopInfo.scole];
    NSInteger score = shopInfo.scole;
    _lblCouponPrice.text = [NSString stringWithFormat:@"券%@元", @(shopInfo.coupon_price)];
    [self setStarView:score];
    
    [_imgView setImageWithURL:getImageUrl(shopInfo.resource_url) placeholderImage:[UIImage imageNamed:@"downlaod_picture_fail"]];
}

- (void)setStarView:(NSInteger)score {
    for (NSInteger i = 0; i < 5; i ++) {
        UIImageView *imgView = (UIImageView *)[_commentView viewWithTag:10000 + i];
        if (i + 1 <= score) {
            imgView.image = [UIImage imageNamed:@"shop_five_corner"];
        } else {
            imgView.image = [UIImage imageNamed:@"shop_five_corner_normal"];
        }
        
    }
}

@end
