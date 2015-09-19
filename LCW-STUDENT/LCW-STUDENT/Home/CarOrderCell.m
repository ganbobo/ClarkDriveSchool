//
//  CarOrderCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/11.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CarOrderCell.h"
#import "CarOrderBtn.h"

#define kBtnTag 10020
#define kBtnSelectTag 10030

@interface CarOrderCell () {
    
    __weak IBOutlet CarOrderBtn *_btnOne;
    __weak IBOutlet CarOrderBtn *_btnTwo;
    __weak IBOutlet CarOrderBtn *_btnThree;
    __weak IBOutlet UIButton *_btnSelectOne;
    __weak IBOutlet UIButton *_btnSelectTwo;
    __weak IBOutlet UIButton *_btnSelectThree;
}

@end

@implementation CarOrderCell

- (void)awakeFromNib {
//    // Initialization code
//    [_btnOne setBackgroundImage:[[UIImage imageNamed:@"car_order_normal"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
//    [_btnTwo setBackgroundImage:[[UIImage imageNamed:@"car_order_select"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
//    [_btnThree setBackgroundImage:[[UIImage imageNamed:@"car_order_full"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    _btnOne.tag = kBtnTag + 0;
    _btnSelectOne.tag = kBtnSelectTag + 0;
    
    _btnTwo.tag = kBtnTag + 1;
    _btnSelectTwo.tag = kBtnSelectTag + 1;
    
    _btnThree.tag = kBtnTag + 2;
    _btnSelectThree.tag = kBtnSelectTag + 2;
    _btnSelectOne.titleLabel.font = _btnSelectTwo.titleLabel.font = _btnSelectThree.titleLabel.font = [UIFont systemFontOfSize:14];
    _btnOne.orderState = _btnTwo.orderState = _btnThree.orderState = OrderStateNormal;
    [self setOrderStateWithSelectBtn:_btnSelectOne orderState:OrderStateNormal];
    [self setOrderStateWithSelectBtn:_btnSelectTwo orderState:OrderStateNormal];
    [self setOrderStateWithSelectBtn:_btnSelectThree orderState:OrderStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshWithIndex:(NSInteger)index {
    for (NSLayoutConstraint* constraint in self.contentView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeTop) {
            if (index == 0) {
                constraint.constant = 0;
            } else {
                constraint.constant = -1;
            }
        }
    }
}

- (IBAction)clickSelectBtn:(id)sender {
    CarOrderBtn *btn = (CarOrderBtn *)sender;
    UIButton *btnSelect = (UIButton *)[self.contentView viewWithTag:(btn.tag - kBtnTag + kBtnSelectTag)];
    if (btn.orderState == OrderStateNormal) {
        btn.orderState = OrderStateSelect;
    } else if (btn.orderState == OrderStateSelect) {
        btn.orderState = OrderStateNormal;
    }
    [self setOrderStateWithSelectBtn:btnSelect orderState:btn.orderState];
}

- (void)setOrderStateWithSelectBtn:(UIButton *)selectBtn orderState:(OrderState)orderState {
    selectBtn.backgroundColor = [UIColor clearColor];
    [selectBtn setImage:nil forState:UIControlStateNormal];
    [selectBtn setTitle:@"" forState:UIControlStateNormal];
    selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    selectBtn.hidden = NO;
    switch (orderState) {
            
        case OrderStateNormal: {
            selectBtn.hidden = YES;
        }
            break;
        case OrderStateSelect: {
            [selectBtn setImage:[UIImage imageNamed:@"order_car_select"] forState:UIControlStateNormal];
            selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case OrderStateOrder: {
            selectBtn.backgroundColor = RGBA(0x11, 0xce, 0x6d, 1);
            [selectBtn setTitle:@"已满" forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case OrderStateFull: {
            selectBtn.backgroundColor = RGBA(0xaa, 0xaa, 0xaa, 1);
            [selectBtn setTitle:@"已满" forState:UIControlStateNormal];
            [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }

}

@end
