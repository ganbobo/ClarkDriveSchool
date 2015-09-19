//
//  CarOrderCell.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/11.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OrderStateNormal = 1,  // 可选
    OrderStateSelect = 2,   // 选择
    OrderStateOrder = 3, // 预约
    OrderStateFull = 4 // 已满
} OrderState;

#define kCarOrderCellHeight  65

@interface CarOrderCell : UITableViewCell

- (void)refreshWithIndex:(NSInteger)index;

@end
