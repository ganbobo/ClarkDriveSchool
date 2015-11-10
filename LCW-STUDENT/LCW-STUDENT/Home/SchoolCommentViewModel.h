//
//  SchoolCommentViewModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/10.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "ShopCommentInfo.h"
@interface SchoolCommentViewModel : NSObject

@property(nonatomic, retain)NSMutableArray *commentList;

/**
 *  获取评论列表
 *
 *  @param drivingId  驾校ID
 *  @param controller 控制器
 *  @param callBack   回调
 */
- (void)getCommentListFromServer:(NSString *)drivingId
                      controller:(BaseViewController *)controller
                        callBack:(void(^)(BOOL success))callBack;


@end
