//
//  LocationManager.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(LocationManager);

- (void)startLocation;

@end
