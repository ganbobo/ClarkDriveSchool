//
//  UserInfo.h
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/26.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "STDbObject.h"

@interface UserInfo : STDbObject

@property (nonatomic, copy) NSString *identification;
@property (nonatomic, copy) NSString *login_name;
@property (nonatomic, copy) NSString *resource_id;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, assign) NSInteger training_flag;
@property (nonatomic, copy) NSString *cn_name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) NSInteger create_time;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *pass_word;

@end
