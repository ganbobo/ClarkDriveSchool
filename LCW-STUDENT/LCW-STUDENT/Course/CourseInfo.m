//
//  CourseInfo.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/17.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CourseInfo.h"

@implementation CourseInfo


- (NSDictionary *)objectClassInArray{
    return @{@"recordList" : [RecordInfo class]};
}

- (NSMutableArray *)getListByType:(NSInteger)type {
    NSMutableArray *list = [NSMutableArray array];
    switch (type) {
        case -1: {
            [list addObjectsFromArray:_recordList];
        }
            break;
        default: {
            for (RecordInfo *info in _recordList) {
                if (info.type == type) {
                    [list addObject:info];
                }
            }
        }
            break;
    }
    
    return list;
}

@end
@implementation CoutInfo

@end


@implementation RecordInfo

@end


