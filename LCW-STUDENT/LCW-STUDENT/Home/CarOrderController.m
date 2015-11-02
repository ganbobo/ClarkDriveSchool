//
//  CarOrderController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CarOrderController.h"

#import "CarOrderCell.h"
#import "CarOrderViewModel.h"

#define kBtnDayBaseTag 10000

@interface CarOrderController ()<UITableViewDelegate, UITableViewDataSource> {
    
    @private
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIButton *_btnSelectCoach;
    __weak IBOutlet UIView *_dayView;
    __weak IBOutlet UIButton *_btnDayOne;
    __weak IBOutlet UIButton *_btnDayTwo;
    __weak IBOutlet UIButton *_btnDayThree;
    __weak IBOutlet UIButton *_btnDayFour;
    __weak IBOutlet UIButton *_btnDayFive;
    __weak IBOutlet UIButton *_btnDaySix;
    __weak IBOutlet UIButton *_btnDaySeven;
    
    // 数据
    CarOrderViewModel *_carOrderViewModel;
}

@end

@implementation CarOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取数据
    [self getSubjectFromServer];
    [self getTimeFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _carOrderViewModel = [[CarOrderViewModel alloc] init];
    [self loadNav];
    [self loadDayView];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"一键约车"];
}

- (void)loadDayView {
    _btnSelectCoach.layer.borderColor = RGBA(0x99, 0x99, 0x99, 1).CGColor;
    _btnSelectCoach.layer.borderWidth = 0.5;
    
    _dayView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineOne = [UIView new];
    lineOne.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [lineOne setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_dayView addSubview:lineOne];
    
    UIView *lineTwo = [UIView new];
    lineTwo.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [lineTwo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_dayView addSubview:lineTwo];
    
    UIView *lineThree = [UIView new];
    lineThree.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [lineThree setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_dayView addSubview:lineThree];
    
    UIView *lineFour = [UIView new];
    lineFour.backgroundColor = RGBA(0xee, 0xee, 0xee, 1);
    [lineFour setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_dayView addSubview:lineFour];
    [_dayView sendSubviewToBack:lineFour];
    
    // 添加约束
    [_dayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[LONE(0.5)]" options:0 metrics:nil views:@{@"LONE": lineOne}]];
    [_dayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[LONE]-0-|" options:0 metrics:nil views:@{@"LONE": lineOne}]];
    [_dayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[LTWO]-0-|" options:0 metrics:nil views:@{@"LTWO": lineTwo}]];
    [_dayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[LTWO(0.5)]" options:0 metrics:nil views:@{@"LTWO": lineTwo}]];
    [_dayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[LTHREE(0.5)]-0-|" options:0 metrics:nil views:@{@"LTHREE": lineThree}]];
    [_dayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[LTHREE]-0-|" options:0 metrics:nil views:@{@"LTHREE": lineThree}]];
    [_dayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[LFOUR]-0-|" options:0 metrics:nil views:@{@"LFOUR": lineFour}]];
    [_dayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[LFOUR(0.5)]-8-|" options:0 metrics:nil views:@{@"LFOUR": lineFour}]];
    [self setBtnTags];
}

- (void)setBtnTags {
    _btnDayOne.selected = YES;
    
    _btnDayOne.titleLabel.numberOfLines = _btnDayTwo.titleLabel.numberOfLines = _btnDayThree.titleLabel.numberOfLines =
    _btnDayFour.titleLabel.numberOfLines = _btnDayFive.titleLabel.numberOfLines = _btnDaySix.titleLabel.numberOfLines =
    _btnDaySeven.titleLabel.numberOfLines = 0;
}

#pragma - mark 点击日期

- (IBAction)clickViewDayBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    // 如果当前日期是选择的日期，则
    if (btn.selected) {
        return;
    }
    for (UIView *view in _dayView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *tempBtnDay = (UIButton *)view;
            tempBtnDay.selected = NO;
        }
    }
    
    btn.selected = YES;
}

- (IBAction)clickSelectCoach:(id)sender {
    [_carOrderViewModel getCoachListFromServer:@"53c71c54c769cc2fc987595416f6d30c" controller:self callBack:^(BOOL success) {
        
    }];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCarOrderCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarOrderCell" forIndexPath:indexPath];
    
    [cell refreshWithIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma - mark 获取科目

- (void)getSubjectFromServer {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getSubjectFromServer];
    }];
    [_carOrderViewModel getSubjectListFromServer:getUser().id controller:self callBack:^(BOOL success) {
        
    }];
}

- (void)getTimeFromServer {
    [_carOrderViewModel getTimeListFromServerController:self callBack:^(BOOL success) {
        
    }];
}

@end
