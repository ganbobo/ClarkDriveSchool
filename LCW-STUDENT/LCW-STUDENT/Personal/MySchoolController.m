//
//  MySchoolController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MySchoolController.h"

#import "MySchoolViewModel.h"

@interface MySchoolController ()<UITableViewDelegate, UITableViewDataSource> {
    MySchoolViewModel *_mySchoolViewModel;
}

@end

@implementation MySchoolController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getSchoolInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _mySchoolViewModel = [[MySchoolViewModel alloc] init];
    [self loadNav];
}

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"我的驾校"];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySchoolCell" forIndexPath:indexPath];
    cell.textLabel.textColor = RGBA(0x32, 0x32, 0x32, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

#pragma - mark 获取数据

- (void)getSchoolInfo {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getSchoolInfo];
    }];
    
    [self getSchoolInfoFromServer];
}

- (void)getSchoolInfoFromServer {
    [_mySchoolViewModel getSchoolDetailFromSever:self callBack:^(BOOL success) {
        
    }];
}

@end
