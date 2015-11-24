//
//  OrderCourseInfo.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/21.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "OrderCourseInfo.h"

@implementation OrderCourseInfo

- (NSDictionary *)objectClassInArray{
    return @{@"courseList" : [CourseModel class], @"trainerDayList" : [CarInfo class]};
}
@end

@implementation CourseModel

@end

@implementation CarInfo

@end


