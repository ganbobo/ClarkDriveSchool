//
//  MyCoachCell.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCoachCell.h"

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickComment:(id)sender {
}

@end
