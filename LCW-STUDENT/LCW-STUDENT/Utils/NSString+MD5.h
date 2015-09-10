//
//  NSString+MD5.h
//  OrderingFood
//
//  Created by St.Pons Mr.G on 14-6-26.
//  Copyright (c) 2014年 PooMoo. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@interface NSString(MD5)

/**
 *  MD5 加密算法
 *
 *  @return MD5加密的字符串
 */
-(NSString *) md5HexDigest;

@end
