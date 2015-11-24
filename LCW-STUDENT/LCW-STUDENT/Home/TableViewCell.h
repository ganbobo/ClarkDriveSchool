//
//  TableViewCell.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/24.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopInfo.h"

@interface TableViewCell : UITableViewCell

+ (TableViewCell *)getTableViewCell;

- (void)refreshCellWithInfo:(ShopInfo *)shopInfo;

@end
