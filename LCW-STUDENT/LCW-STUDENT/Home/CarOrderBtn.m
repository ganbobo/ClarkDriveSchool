//
//  CarOrderBtn.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/19.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CarOrderBtn.h"

@implementation CarOrderBtn

- (void)setOrderState:(OrderState)orderState {
    _orderState = orderState;
    self.userInteractionEnabled = YES;
    switch (orderState) {
        case OrderStateNormal: {
            [self setBackgroundImage:[[UIImage imageNamed:@"car_order_normal"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [self setTitleColor:RGBA(0x00, 0x00, 0x00, 1) forState:UIControlStateNormal];

        }
            break;
        case OrderStateSelect: {
            [self setBackgroundImage:[[UIImage imageNamed:@"car_order_select"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [self setTitleColor:RGBA(0x00, 0x00, 0x00, 1) forState:UIControlStateNormal];
        }
            break;
        case OrderStateOrder: {
            self.userInteractionEnabled = NO;
            [self setBackgroundImage:[[UIImage imageNamed:@"car_order_order"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [self setTitleColor:RGBA(0xff, 0xff, 0xff, 1) forState:UIControlStateNormal];
        }
            break;
        case OrderStateFull: {
            self.userInteractionEnabled = NO;
            [self setBackgroundImage:[[UIImage imageNamed:@"car_order_full"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [self setTitleColor:RGBA(0x69, 0x69, 0x69, 1) forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

@end
