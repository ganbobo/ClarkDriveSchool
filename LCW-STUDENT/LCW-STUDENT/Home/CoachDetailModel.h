//
//  CoachDetailModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/9.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachDetailModel : NSObject

@property (nonatomic, copy) NSString *identification;

@property (nonatomic, copy) NSString *cn_name;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *trainer_type;

@property (nonatomic, assign) NSInteger driving_age;

@property (nonatomic, copy) NSString *trainer_level;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *resource_url;

@end
