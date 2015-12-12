//
//  OrderCourseInfo.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/21.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CarInfo;
@interface OrderCourseInfo : NSObject


@property (nonatomic, strong) NSMutableArray *trainerDayList;

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, assign) BOOL jiXun;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSMutableArray *courseList;


@end

@interface CourseModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property(nonatomic, assign)BOOL select;
@property (nonatomic, copy) NSString *timePeriod;
@property(nonatomic, assign)BOOL noPost;

@end

@interface CarInfo : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger isFull; // 0未满， 1已满
@property (nonatomic, assign) NSInteger isYue; // 0未满， 1已满
@property (nonatomic, copy) NSString *timePeriod;

@end

