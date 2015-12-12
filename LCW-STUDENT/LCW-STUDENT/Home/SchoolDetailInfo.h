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


@property (nonatomic, copy) NSString *driving_name;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, assign) NSInteger driving_price;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger coupon_price;

@property (nonatomic, copy) NSString *driving_addr;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *resource_url;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, assign) NSInteger scole;

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

