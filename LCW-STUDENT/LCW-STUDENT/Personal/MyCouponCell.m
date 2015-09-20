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
    _lblPrice.text = @"<font face='HelveticaNeue-CondensedBold' color='#f76502' size=20>1000</font><font color='#f76502' size=13>元</font>";
    _lblPrice.textAlignment = RTTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
