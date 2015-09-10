//
//  NSString+MD5.m
//  OrderingFood
//
//  Created by St.Pons Mr.G on 14-6-26.
//  Copyright (c) 2014年 PooMoo. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString(MD5)


-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@end
