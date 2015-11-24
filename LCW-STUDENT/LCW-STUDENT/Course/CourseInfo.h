//
//  CourseInfo.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/17.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoutInfo,RecordInfo;
@interface CourseInfo : NSObject

@property (nonatomic, strong) NSMutableArray *recordList;

@property (nonatomic, strong) CoutInfo *jr;

- (NSMutableArray *)getListByType:(NSInteger)type;

@end
@interface CoutInfo : NSObject

@property (nonatomic, assign) NSInteger practicing;

@property (nonatomic, assign) NSInteger all;

@property (nonatomic, assign) NSInteger absent;

@property (nonatomic, assign) NSInteger practiced;

@end

@interface RecordInfo : NSObject

@property (nonatomic, copy) NSString *timePeriod;

@property (nonatomic, assign) long long recordTime;

@property (nonatomic, copy) NSString *subjectName;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *userDayId;

@end

