//
//  CoachFilterCell.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/3.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CoachFilterCell.h"


@interface CoachFilterCell () {
    
    __weak IBOutlet UIButton *_btnSelect;
    SubjectInfo *_subjectInfo;
}

@end
@implementation CoachFilterCell

- (void)awakeFromNib {
    // Initialization code
    _btnSelect.layer.cornerRadius = 2;
    _btnSelect.layer.masksToBounds = YES;
    _btnSelect.layer.borderWidth = 0.5;
    [_btnSelect setTitleColor:[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000] forState:UIControlStateNormal];
    _btnSelect.layer.borderColor =[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickSelect:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectSubject:)]) {
        [_delegate didSelectSubject:_subjectInfo];
    }
}

- (void)refreshCellWithInfo:(SubjectInfo *)subjectInfo {
    _subjectInfo = subjectInfo;
    [_btnSelect setTitle:subjectInfo.subject_name forState:UIControlStateNormal];
}

@end
