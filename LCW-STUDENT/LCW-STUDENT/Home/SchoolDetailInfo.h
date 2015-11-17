//
//  SchoolDetailInfo.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DrivingInfo,PriceInfo,CarRecord,StudyProcessInfo,TimeInfo,PrivilegeInfo;
@interface SchoolDetailInfo : NSObject

@property (nonatomic, strong) NSArray<TimeInfo *> *csList;

@property (nonatomic, strong) NSArray<PriceInfo *> *price;

@property (nonatomic, strong) NSArray<CarRecord *> *sList;

@property (nonatomic, strong) NSArray<StudyProcessInfo *> *pList;

@property (nonatomic, strong) DrivingInfo *driving;

@property (nonatomic, strong) NSArray<PrivilegeInfo *> *privilegeList;

@end

@interface DrivingInfo : NSObject

@property (nonatomic, assign) NSInteger drivingPrice;

@property (nonatomic, copy) NSString *drivingAddr;

@property (nonatomic, assign) NSInteger couponPrice;

@property (nonatomic, assign) NSInteger drivingCommNum;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *resourseUrl;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *scole;

@property (nonatomic, copy) NSString *drivingName;

@property (nonatomic, copy) NSString *drivingId;

@end

@interface PriceInfo : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger examination_fee;

@property (nonatomic, copy) NSString *class_type;

@property (nonatomic, assign) NSInteger training_fee;

@property (nonatomic, assign) NSInteger other_fee;

@end

@interface CarRecord : NSObject

@property (nonatomic, copy) NSString *scheduled_text;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *driving_id;

@property (nonatomic, copy) NSString *scheduled_name;

@end

@interface StudyProcessInfo : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *process_name;

@property (nonatomic, copy) NSString *process_message;

@end

@interface TimeInfo : NSObject

@property (nonatomic, copy) NSString *subject_message;

@property (nonatomic, copy) NSString *subject_name;

@end

@interface PrivilegeInfo : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *privilege_name;

@property (nonatomic, copy) NSString *privilege_text;

@end

