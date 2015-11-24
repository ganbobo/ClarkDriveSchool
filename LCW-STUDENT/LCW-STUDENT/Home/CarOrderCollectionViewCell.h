//
//  CarOrderCollectionViewCell.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/6.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderCourseInfo.h"

@interface CarOrderCollectionViewCell : UICollectionViewCell

- (void)refreshCellByInfo:(CourseModel *)info;
- (void)refreshCellByIsFull:(NSInteger)isfull andYue:(NSInteger)yue;
- (void)refreshCellByType:(NSInteger)type;

@end
