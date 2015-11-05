//
//  CoachFilterCell.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/3.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectInfo.h"

@protocol CoachFilterCellDelegate <NSObject>

- (void)didSelectSubject:(SubjectInfo *)subjectInfo;

@end

@interface CoachFilterCell : UITableViewCell

@property(nonatomic, assign)id<CoachFilterCellDelegate> delegate;

- (void)refreshCellWithInfo:(SubjectInfo *)subjectInfo;

@end
