//
//  ShopCell.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/8/29.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopInfo.h"

@interface ShopCell : UITableViewCell

- (void)refreshCellWithInfo:(ShopInfo *)shopInfo;

@end
