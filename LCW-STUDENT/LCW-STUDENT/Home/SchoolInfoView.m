//
//  SchoolInfoView.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/7.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "SchoolInfoView.h"

#import "SchoolInfoCell.h"

@interface SchoolInfoView()<UITableViewDataSource, UITableViewDelegate, SchoolInfoCellDelegate> {
    UITableView *_tableView;
    
    BOOL _hasSignUp;
}

@end

@implementation SchoolInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableView];
    }
    return self;
}

- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollsToTop = NO;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 50;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SchoolInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolInfoCell"];
    if (!cell) {
        cell = [[SchoolInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SchoolInfoCell"];
        cell.delegate = self;
    }
    
    [cell refreshCellWithIndex:indexPath.row withSignUp:_hasSignUp];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectCoach)]) {
            [_delegate didSelectCoach];
        }
    }
    
    if (indexPath.row == 2) {
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectCoach)]) {
            [_delegate didSelectCoach];
        }
    }
}

- (void)setDataSource:(BOOL)hasSignUp {
    _hasSignUp = hasSignUp;
    [_tableView reloadData];
    [_tableView setHeight:_tableView.contentSize.height];
    [self setHeight:_tableView.height];
}

#pragma - mark SchoolInfoCellDelegate 代理

- (void)didClickCoach {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectCoach)]) {
        [_delegate didSelectCoach];
    }
}

@end
