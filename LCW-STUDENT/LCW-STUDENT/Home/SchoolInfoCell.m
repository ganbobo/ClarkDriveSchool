//
//  SchoolInfoCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/7.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "SchoolInfoCell.h"

#import "RTLabel.h"

#define kStartBeginTag 1000

#define kStartWidth    10

@interface SchoolInfoCell () {
    UIButton *_btnSelectCoach;
    UIView *_commentView;
    RTLabel *_lblCommentNum;
    UILabel *_lblCommentScore;
    
    UIButton *_btnAddress;
    UIView *_line;
}

@end

@implementation SchoolInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSelectCoachView];
        [self initCommentView];
        [self initBtnAddress];
        [self initLine];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initLine {
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenWidth, 0.5)];
    _line.backgroundColor = [UIColor colorWithWhite:0.808 alpha:1.000];
    [self.contentView addSubview:_line];
}

- (void)initSelectCoachView {
    _btnSelectCoach = [UIButton buttonWithType:UIButtonTypeSystem];
    _btnSelectCoach.frame = CGRectMake(5, 5, ScreenWidth - 10, 40);
    _btnSelectCoach.backgroundColor = [UIColor colorWithRed:0.992 green:0.306 blue:0.024 alpha:1.000];
    [_btnSelectCoach setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSelectCoach.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_btnSelectCoach setTitle:@"下一步，选教练" forState:UIControlStateNormal];
    [_btnSelectCoach addTarget:self action:@selector(clickSelectCoach) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btnSelectCoach];
}

- (void)initCommentView {
    _commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    _commentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_commentView];
    
    for (NSInteger i = 0; i < 5; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + kStartWidth * i, (_commentView.height - kStartWidth) / 2.0, kStartWidth, kStartWidth)];
        imgView.tag = kStartBeginTag + i;
        imgView.image = [UIImage imageNamed:@"shop_five_corner"];
        [_commentView addSubview:imgView];
    }
    
    _lblCommentScore = [[UILabel alloc] initWithFrame:CGRectMake(10 + kStartWidth * 5, 0, 30, _commentView.height)];
    _lblCommentScore.backgroundColor = [UIColor clearColor];
    _lblCommentScore.textColor = [UIColor colorWithRed:0.992 green:0.306 blue:0.024 alpha:1.000];
    _lblCommentScore.font = [UIFont systemFontOfSize:14];
    _lblCommentScore.text = @"5.0";
    [_commentView addSubview:_lblCommentScore];
    
    _lblCommentNum = [[RTLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lblCommentScore.frame), (_commentView.height - 16) / 2.0, ScreenWidth - CGRectGetMaxX(_lblCommentScore.frame) - 30, 16)];
    _lblCommentNum.backgroundColor = [UIColor clearColor];
    _lblCommentNum.textColor = RGBA(0x69, 0x69, 0x69, 1);
    _lblCommentNum.font = [UIFont systemFontOfSize:14];
    _lblCommentNum.textAlignment = RTTextAlignmentRight;
    _lblCommentNum.text = @"<font color='#FF440F' size=14>64</font>人评论";
    [_commentView addSubview:_lblCommentNum];
}

- (void)initBtnAddress {
    _btnAddress = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth - 20, 44)];
    _btnAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnAddress.userInteractionEnabled = NO;
    _btnAddress.titleLabel.font = [UIFont systemFontOfSize:13];
    _btnAddress.titleLabel.numberOfLines = 0;
    [_btnAddress setImage:[UIImage imageNamed:@"school_location"] forState:UIControlStateNormal];
    [_btnAddress setTitleColor:RGBA(0x69, 0x69, 0x69, 1) forState:UIControlStateNormal];
    
    UIEdgeInsets edge = _btnAddress.titleEdgeInsets;
    edge.left = 5;
    _btnAddress.titleEdgeInsets = edge;
    
    [_btnAddress setTitle:@"朝阳区和平里西街15号110大厦4256号（朝阳门店）" forState:UIControlStateNormal];
    [self.contentView addSubview:_btnAddress];
}

- (void)refreshCellWithIndex:(NSInteger)index withSignUp:(BOOL)signUp {
    if (signUp) {
        [_btnSelectCoach setTitle:@"下一步，选教练" forState:UIControlStateNormal];
    } else {
        [_btnSelectCoach setTitle:@"下一步，生成抵用券" forState:UIControlStateNormal];
    }
    _btnSelectCoach.hidden = _commentView.hidden = _btnAddress.hidden = YES;
    [_line setOrigin:CGPointMake(0, 44 - 0.5)];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    switch (index) {
        case 0: {
            _btnSelectCoach.hidden = NO;
            [_line setOrigin:CGPointMake(0, 50 - 0.5)];
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            break;
        case 1: {
            _commentView.hidden = NO;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 2: {
            _btnAddress.hidden = NO;
        }
            break;
        default:
            break;
    }
}


// 按钮点击方法
- (void)clickSelectCoach {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickCoach)]) {
        [_delegate didClickCoach];
    }
}

@end