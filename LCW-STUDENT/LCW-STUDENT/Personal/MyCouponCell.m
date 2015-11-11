//
//  MyCouponCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/20.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCouponCell.h"

#import "RTLabel.h"

@interface MyCouponCell () {
    
    __weak IBOutlet RTLabel *_lblPrice;
    __weak IBOutlet UILabel *_lblTitle;
    __weak IBOutlet UILabel *_lblTimeLine;
    __weak IBOutlet UILabel *_lblCouponNO;
    __weak IBOutlet UILabel *_lblStatus;
}

@end

@implementation MyCouponCell

- (void)awakeFromNib {
    // Initialization code
    _lblPrice.textAlignment = RTTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshCellByInfo:(MyCouponInfo *)info {
    _lblTitle.text = [NSString stringWithFormat:@"%@-优惠券", info.drivingName];
    _lblCouponNO.text = [NSString stringWithFormat:@"优惠码：%@", info.promoCode];
    _lblTimeLine.text = [NSString stringWithFormat:@"有效期至：%@", [self getTimeLongValue:info.validityPeriod]];
    switch (info.isUse) {
        case 0:
            _lblStatus.text  = @"未使用";
            break;
        case 1:
            _lblStatus.text  = @"已使用";
            break;
        case 2:
            _lblStatus.text  = @"已过期";
            break;
        default:
            _lblStatus.text  = @"未使用";
            break;
    }
    
    _lblPrice.text = [NSString stringWithFormat:@"<font face='HelveticaNeue-Bold' color='#f76502' size=20>%ld</font><font color='#f76502' size=13>元</font>", (long)info.couponPrice];
    
}

- (NSString *)getTimeLongValue:(long)time {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    return [dateFormatter stringFromDate:date];
}

@end
