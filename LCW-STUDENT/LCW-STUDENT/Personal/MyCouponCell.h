//
//  MyCouponCell.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/20.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyCouponInfo.h"

@interface MyCouponCell : UITableViewCell

- (void)refreshCellByInfo:(MyCouponInfo *)info;

@end
