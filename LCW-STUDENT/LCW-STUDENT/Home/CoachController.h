//
//  CoachController.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/9.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "BaseViewController.h"

#import "SubjectInfo.h"
#import "MyCoachInfo.h"

/**
 *  选择教练
 */

@interface CoachFilterInfo : NSObject

@property(nonatomic, retain)NSString *desc;// 排序
@property(nonatomic, retain)NSString *sex;
@property(nonatomic, retain)NSString *type;

@end

@interface CoachController : BaseViewController

@property(nonatomic, retain)NSString *drivingId;
@property(nonatomic, retain)SubjectInfo *subjectInfo;
@property(nonatomic, retain)MyCoachInfo *coachInfo;

@end
