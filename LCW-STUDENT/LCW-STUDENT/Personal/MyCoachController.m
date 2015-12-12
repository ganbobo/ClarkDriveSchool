//
//  MyCoachController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCoachController.h"

#import "MyCoachViewModel.h"
#import "MyCoachCell.h"
#import "CoachCommentController.h"

#import "CoachController.h"

@interface MyCoachController ()<UITableViewDataSource, UITableViewDelegate, MyCoachCellDelegate>{
    MyCoachViewModel *_myCoachViewModel;
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation MyCoachController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getMyCoachInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _myCoachViewModel = [[MyCoachViewModel alloc] init];
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"我的教练"];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _myCoachViewModel.coachList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCoachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCoachCell" forIndexPath:indexPath];
    
    [cell refreshCellByInfo:_myCoachViewModel.coachList[indexPath.section]];
    
    if (!cell.delegate) {
        cell.delegate = self;
    }
    
    return cell;
}

#pragma - mark MyCoachCellDelegate 

- (void)didClickComment:(MyCoachInfo *)coachInfo {
    if (coachInfo.flag == 3) {
        CoachController *controller = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CoachController"];
        controller.coachInfo = coachInfo;
        [self.navigationController pushViewController:controller animated:YES];
        
    } else {
        CoachCommentController *controller = [[CoachCommentController alloc] init];
        controller.coachInfo = coachInfo;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma - mark 获取数据

- (void)getMyCoachInfo {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getMyCoachInfo];
    }];
    
    [self getMyCoachFromServer];
}

- (void)getMyCoachFromServer {
    [_myCoachViewModel getMyCoachFromSever:self callBack:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
        }
    }];
}

@end
