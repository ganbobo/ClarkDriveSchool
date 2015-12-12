//
//  CoachDetailModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/9.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoachUserModel,Jd;
@interface CoachDetailModel : NSObject

@property (nonatomic, copy) NSString *resourceUrl;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *subjectName;

@property (nonatomic, copy) NSString *trainerName;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *drivingName;

@property (nonatomic, copy) NSString *trainerId;


@end

@interface CoachUserModel : NSObject

@property (nonatomic, assign) NSInteger totalNum;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *gcomment;

@property (nonatomic, assign) NSInteger currentNum;

@end

