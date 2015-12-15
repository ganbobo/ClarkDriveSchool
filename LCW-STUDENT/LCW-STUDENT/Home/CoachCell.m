//
//  CoachCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CoachCell.h"

#import "RTLabel.h"

#import <UIImageView+WebCache.h>

@interface CoachCell () {
    
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblPercentNiceComment;
    __weak IBOutlet UILabel *_lblCommentNum;
    __weak IBOutlet RTLabel *_lblStudentsNum; // 学生数
    __weak IBOutlet RTLabel *_lblResidueNum; // 余额
    __weak IBOutlet UILabel *_lblSchoolName;
}

@end

@implementation CoachCell

- (void)awakeFromNib {
    // Initialization code
    _imgView.layer.cornerRadius = _imgView.width / 2.0;
    _imgView.layer.masksToBounds = YES;
    
    _lblStudentsNum.textColor = RGBA(0x46, 0x46, 0x46, 1);
    _lblStudentsNum.font = [UIFont systemFontOfSize:14];
    _lblStudentsNum.text = @"目前学员：<font color='#FF440F' size=14>22</font>";
    
    _lblResidueNum.textColor = RGBA(0x46, 0x46, 0x46, 1);
    _lblResidueNum.font = [UIFont systemFontOfSize:14];
    _lblResidueNum.text = @"剩余名额：<font color='#FF440F' size=14>11111</font>";
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [line setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:line];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[L]-0-|" options:0 metrics:nil views:@{@"L": line}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[L(0.5)]-0-|" options:0 metrics:nil views:@{@"L": line}]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshCellByInfo:(CoachModel *)coachModel {
    [_imgView sd_setImageWithURL:getImageUrl(coachModel.resourceUrl) placeholderImage:[UIImage imageNamed:@"default_user_avatar"]];
    _lblName.text = [NSString stringWithFormat:@"%@(%@)", coachModel.trainerName, coachModel.typeName];
    _lblStudentsNum.text = [NSString stringWithFormat:@"目前学员：<font color='#FF440F' size=14>%ld</font>", (long)coachModel.currentlyTrainee];
    _lblResidueNum.text = [NSString stringWithFormat:@"剩余名额：<font color='#FF440F' size=14>%ld</font>", (long)coachModel.overplusTrainee];
    _lblPercentNiceComment.text = [NSString stringWithFormat:@"好评 %.1f%@", coachModel.percentages, @"%"];
    _lblCommentNum.text = [NSString stringWithFormat:@"%ld人评", (long)coachModel.comm];
    _lblSchoolName.text = coachModel.drivingName;
}

@end
