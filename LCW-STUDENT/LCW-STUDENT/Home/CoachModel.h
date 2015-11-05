//
//  CoachModel.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachModel : NSObject

@property (nonatomic, copy) NSString *resourceUrl;

@property (nonatomic, assign) NSInteger maxTrainee;

@property (nonatomic, assign) NSInteger currentlyTrainee;

@property (nonatomic, assign) CGFloat percentages;

@property (nonatomic, assign) NSInteger comm;

@property (nonatomic, assign) NSInteger sumLevel;

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, assign) NSInteger overplusTrainee;

@property (nonatomic, copy) NSString *trainerName;

@property (nonatomic, copy) NSString *drivingName;

@property (nonatomic, copy) NSString *trainerId;

@end
