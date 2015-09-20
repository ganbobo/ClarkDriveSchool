//
//  MyCommentCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/20.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCommentCell.h"

#import "RTLabel.h"
#import <UIImageView+AFNetworking.h>

@interface MyCommentCell () {
    
    __weak IBOutlet UIImageView *_headImage;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet RTLabel *_lblContent;
}

@end

@implementation MyCommentCell

- (void)awakeFromNib {
    // Initialization code
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = _headImage.width / 2.0;
    _headImage.layer.borderColor = RGBA(0xee, 0xee, 0xee, 1).CGColor;
    _headImage.layer.borderWidth = 1;
    
    _lblContent.text = @"凭质保证书及京东商城发票，可享受全国联保服务（奢侈品、钟表除外；奢侈品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。京东商城还为您提供具有竞争力的商品价格和运费政策，请您放心购买！";
    _lblContent.font = [UIFont systemFontOfSize:14];
    _lblContent.textColor = [UIColor colorWithWhite:0.721 alpha:1.000];
    
    [_headImage setImageWithURL:getImageUrl(@"http://img12.360buyimg.com/n7/jfs/t1789/136/862828904/173824/2dcf5883/55dc53a0Nd70a9509.jpg")];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
