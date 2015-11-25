//
//  CourseInfo.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/17.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CourseInfo.h"

@implementation CourseInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _recordList = [[NSMutableArray alloc] init];
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSDictionary *)objectClassInArray{
    return @{@"recordList" : [RecordInfo class]};
}

- (NSMutableArray *)getListByType:(NSInteger)type {
    NSMutableArray *list = [NSMutableArray array];
    if (type == -1) {
        [list addObjectsFromArray:_dataSource];
    } else {
        for (RecordInfo *info in _dataSource) {
            if (info.type == type) {
                [list addObject:info];
            }
        }
    }
    
    return list;
}

@end
@implementation CoutInfo

@end


@implementation RecordInfo

@end


