//
//  ShopCommentInfo.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/10.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCommentInfo : NSObject

@property (nonatomic, assign) long createTime;

@property (nonatomic, copy) NSString *cnName;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger isComm;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, copy) NSString *resourceUrl;

@end
