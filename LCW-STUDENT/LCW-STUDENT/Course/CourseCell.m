//
//  CourseCell.m
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/29.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CourseCell.h"

@interface CourseCell () {
    
    __weak IBOutlet UIButton *_btnHandle;
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UILabel *_lblTimeName;
    
    RecordInfo *_recordInfo;
}

@end

@implementation CourseCell

- (void)awakeFromNib {
    // Initialization code
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [line setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:line];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[L]-0-|" options:0 metrics:nil views:@{@"L": line}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[L(0.5)]-0-|" options:0 metrics:nil views:@{@"L": line}]];
    
    [_btnHandle setTitleColor:RGBA(0x3a, 0xa7, 0x57, 1) forState:UIControlStateNormal];
    [_btnHandle setTitleColor:RGBA(0x66, 0x66, 0x66, 1) forState:UIControlStateDisabled];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)refreshCellByInfo:(RecordInfo *)recordInfo {
    _recordInfo = recordInfo;
    _lblTimeName.text = [NSString stringWithFormat:@"%@      %@", [self getTime:recordInfo.recordTime], recordInfo.subjectName];
    _lblTime.text = recordInfo.timePeriod;
    
    switch (recordInfo.type) {
        case 0: {
            _btnHandle.enabled = YES;
            [_btnHandle setTitle:@"取消" forState:UIControlStateNormal];
        }
            break;
        case 1: {
            _btnHandle.enabled = NO;
            [_btnHandle setTitle:@"完成" forState:UIControlStateNormal];
        }
            break;
        case 2: {
            _btnHandle.enabled = NO;
            [_btnHandle setTitle:@"缺课" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (NSString *)getTime:(long long)value {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:value / 1000];
    return [formatter stringFromDate:date];
}


- (IBAction)clickCancel:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickCancel:)]) {
        [_delegate didClickCancel:_recordInfo];
    }
}

@end
