//
//  SchoolInfoCell.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/7.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SchoolInfoCellDelegate <NSObject>

- (void)didClickCoach;

@end

@interface SchoolInfoCell : UITableViewCell

@property(nonatomic, assign)id<SchoolInfoCellDelegate> delegate;

- (void)refreshCellWithIndex:(NSInteger)index withSignUp:(BOOL)signUp;

@end
