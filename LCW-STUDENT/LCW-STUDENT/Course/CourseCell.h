//
//  CourseCell.h
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/29.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CourseInfo.h"

@protocol CourseCellDelegate <NSObject>

- (void)didClickCancel:(RecordInfo *)recordInfo;

@end

@interface CourseCell : UITableViewCell

@property(nonatomic, assign)id<CourseCellDelegate> delegate;

- (void)refreshCellByInfo:(RecordInfo *)recordInfo;

@end
