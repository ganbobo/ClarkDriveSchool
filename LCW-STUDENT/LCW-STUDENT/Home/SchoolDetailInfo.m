//
//  SchoolDetailInfo.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "SchoolDetailInfo.h"

@implementation SchoolDetailInfo


- (NSDictionary *)objectClassInArray{
    return @{@"price" : [PriceInfo class], @"sList" : [CarRecord class], @"pList" : [StudyProcessInfo class], @"csList" : [TimeInfo class], @"privilegeList" : [PrivilegeInfo class]};
}
@end
@implementation DrivingInfo

@end


@implementation PriceInfo

@end


@implementation CarRecord

@end


@implementation StudyProcessInfo

@end


@implementation TimeInfo

@end


@implementation PrivilegeInfo

@end


