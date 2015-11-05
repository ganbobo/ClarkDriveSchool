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
}
@end

@implementation MyCoachCell

- (void)awakeFromNib {
    // Initialization code
    _imgHead.layer.borderColor = RGBA(0xee, 0xee, 0xee, 1).CGColor;
    _imgHead.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickComment:(id)sender {
}

- (void)refreshCellByInfo:(MyCoachInfo *)coachInfo {
    [_imgHead setImageWithURL:getImageUrl(@"") placeholderImage:[UIImage imageNamed:@"downlaod_picture_fail"]];
    
    _lblNameInfo.text = coachInfo.cnName;
    _lblPhone.text = [NSString stringWithFormat:@"手机：%@", coachInfo.tel];
    _lblCourse.text = coachInfo.subjectName;
    
    if (coachInfo.cnName.length == 0 && coachInfo.tel.length == 0) {
        [_btnComment setTitle:@"去绑定" forState:UIControlStateNormal];
    } else {
        [_btnComment setTitle:@"评价" forState:UIControlStateNormal];
    }
}

@end
