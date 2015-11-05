//
//  CoachCell.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoachModel.h"

#define kCoachCellHeight  90

@interface CoachCell : UITableViewCell

- (void)refreshCellByInfo:(CoachModel *)coachModel;

@end
