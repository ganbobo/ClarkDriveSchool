//
//  MyCoachCell.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCoachCell.h"

#import <UIImageView+AFNetworking.h>

@interface MyCoachCell () {
    
    __weak IBOutlet UILabel *_lblCourse;
    __weak IBOutlet UIImageView *_imgHead;
    __weak IBOutlet UILabel *_lblNameInfo;
    __weak IBOutlet UILabel *_lblCarNo;
    __weak IBOutlet UILabel *_lblSchoolName;
    __weak IBOutlet UILabel *_lblPhone;
    __weak IBOutlet UIButton *_btnComment;
    
    MyCoachInfo *_coachInfo;
}
@end

@implementation MyCoachCell

- (void)awakeFromNib {
    // Initialization code
    _imgHead.layer.borderColor = RGBA(0xee, 0xee, 0xee, 1).CGColor;
    _imgHead.layer.borderWidth = 0.5;
    _imgHead.layer.cornerRadius = _imgHead.width  / 2.0;
    _imgHead.layer.masksToBounds = YES;
    
    _lblCarNo.text = @"";
    _lblSchoolName.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickComment:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickComment:)]) {
        [_delegate didClickComment:_coachInfo];
    }
}

- (void)refreshCellByInfo:(MyCoachInfo *)coachInfo {
    _coachInfo = coachInfo;
    
    [_imgHead setImageWithURL:getImageUrl(@"") placeholderImage:[UIImage imageNamed:@"default_user_avatar"]];
    
    _lblNameInfo.text = coachInfo.cnName;
    _lblPhone.text = [NSString stringWithFormat:@"手机：%@", coachInfo.tel];
    _lblCourse.text = coachInfo.subjectName;
    _btnComment.enabled = YES;
    
    switch (coachInfo.flag) {
        case 0: {
            [_btnComment setTitle:@"评价" forState:UIControlStateNormal];
        }
            
            break;
        case 1: {
            [_btnComment setTitle:@"关闭" forState:UIControlStateNormal];
            _btnComment.enabled = NO;
        }
            
            break;
        case 2: {
            [_btnComment setTitle:@"完成" forState:UIControlStateNormal];
            _btnComment.enabled = NO;
        }
            
            break;
        case 3: {
            [_btnComment setTitle:@"去绑定" forState:UIControlStateNormal];
        }
            
            break;
        default:
            break;
    }
}

@end
