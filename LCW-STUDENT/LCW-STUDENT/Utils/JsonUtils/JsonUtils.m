//
//  JsonUtils.m
//  Gtwy
//
//  Created by St.Pons.Mr.G on 15/9/22.
//  Copyright © 2015年 lion. All rights reserved.
//

#import "JsonUtils.h"

@implementation NSDictionary (JsonUtils)

- (NSString *)JSONNSString {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError) {
        return @"";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



@end


@implementation NSString (JsonUtils)

- (id)objectFromJSONNSString {
    if (self == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

@end