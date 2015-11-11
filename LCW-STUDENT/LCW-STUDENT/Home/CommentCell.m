//
//  CommentCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/15.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CommentCell.h"

#import "RTLabel.h"
#import <UIImageView+AFNetworking.h>

@interface CommentCell () {
    
    __weak IBOutlet UIImageView *_headImage;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet RTLabel *_lblContent;
}

@end

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = _headImage.width / 2.0;
    _headImage.layer.borderColor = RGBA(0xee, 0xee, 0xee, 1).CGColor;
    _headImage.layer.borderWidth = 1;
    
    _lblContent.font = [UIFont systemFontOfSize:14];
    _lblContent.textColor = [UIColor colorWithWhite:0.721 alpha:1.000];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshCellByInfo:(ShopCommentInfo *)info {
    [_headImage setImageWithURL:getImageUrl(info.resourceUrl) placeholderImage:[UIImage imageNamed:@"default_user_avatar"]];
    _lblName.text = info.cnName;
    _lblTime.text = [self getTimeLongValue:info.createTime];
    _lblContent.text = info.comments;
    [self setStarView:info.level];
}

- (NSString *)getTimeLongValue:(long)time {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000];
    return [dateFormatter stringFromDate:date];
}

+ (CGFloat)getCellHeight:(ShopCommentInfo *)info {
    RTLabel *lbl = [[RTLabel alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth - 10, 20)];
    lbl.text = info.comments;
    return lbl.optimumSize.height + 70;
}

- (void)setStarView:(NSInteger)score {
    for (NSInteger i = 0; i < 5; i ++) {
        UIImageView *imgView = (UIImageView *)[self.contentView viewWithTag:1000 + i];
        if (i + 1 <= score) {
            imgView.image = [UIImage imageNamed:@"shop_five_corner"];
        } else {
            imgView.image = [UIImage imageNamed:@"shop_five_corner_normal"];
        }
        
    }
}

@end
