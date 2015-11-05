//
//  CoachDetailController.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "BaseViewController.h"

#import "CoachModel.h"
#import "SubjectInfo.h"

@interface CoachDetailController : BaseViewController

@property(nonatomic, retain)CoachModel *coachInfo;
@property(nonatomic, retain)SubjectInfo *subjectInfo;

@end
