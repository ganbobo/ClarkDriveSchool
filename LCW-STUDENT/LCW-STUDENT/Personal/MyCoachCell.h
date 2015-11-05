//
//  MyCoachCell.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyCoachInfo.h"

@interface MyCoachCell : UITableViewCell

- (void)refreshCellByInfo:(MyCoachInfo *)coachInfo;

@end
