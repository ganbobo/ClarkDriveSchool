//
//  CoachDetailModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/9.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachDetailModel : NSObject

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *resourceUrl;

@property (nonatomic, copy) NSString *trainerName;

@property (nonatomic, copy) NSString *trainerId;

@property (nonatomic, copy) NSString *subjectName;

@property (nonatomic, copy) NSString *drivingName;

@end

@interface CoachUserModel : NSObject

@property (nonatomic, assign) NSInteger totalNum;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *gcomment;

@property (nonatomic, assign) NSInteger currentNum;

@end
