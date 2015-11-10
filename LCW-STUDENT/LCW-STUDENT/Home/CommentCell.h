//
//  CommentCell.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/15.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopCommentInfo.h"

@interface CommentCell : UITableViewCell

+ (CGFloat)getCellHeight:(ShopCommentInfo *)info;
- (void)refreshCellByInfo:(ShopCommentInfo *)info;

@end
