//
//  CarOrderBtn.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/7.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CarOrderBtn.h"

@implementation CarOrderBtn

- (void)setSubjectInfo:(SubjectInfo *)subjectInfo {
    _subjectInfo = subjectInfo;
    [self setTitle:subjectInfo.subject_name forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:0.074 green:0.715 blue:0.169 alpha:1.000] forState:UIControlStateSelected];
    [self setTitleColor:RGBA(0x32, 0x32, 0x32, 1) forState:UIControlStateNormal];
}

@end
