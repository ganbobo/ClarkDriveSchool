//
//  JsonUtils.h
//  Gtwy
//
//  Created by St.Pons.Mr.G on 15/9/22.
//  Copyright © 2015年 lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JsonUtils)

- (NSString *)JSONNSString;

@end

@interface NSString (JsonUtils)

- (id)objectFromJSONNSString;

@end