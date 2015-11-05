//
//  CoachFilterController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CoachFilterController.h"

#import "CarOrderViewModel.h"
#import "CoachFilterCell.h"
#import "CoachController.h"

@interface CoachFilterController ()<CoachFilterCellDelegate> {
    CarOrderViewModel *_viewModel;
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation CoachFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getSubject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _viewModel = [[CarOrderViewModel alloc] init];
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"筛选"];
}

#pragma - mark 点击事件

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoachFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoachFilterCell" forIndexPath:indexPath];
    if (!cell.delegate) {
        cell.delegate = self;
    }
    
    [cell refreshCellWithInfo:_viewModel.dataSource[indexPath.row]];
    
    return cell;
}

#pragma - mark CoachFilterCellDelegate

- (void)didSelectSubject:(SubjectInfo *)subjectInfo {
    [self performSegueWithIdentifier:@"CoachSelect" sender:subjectInfo];
}

#pragma - mark 界面跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CoachSelect"]) {
        SubjectInfo *subjectInfo = (SubjectInfo *)sender;
        CoachController *controller = [segue destinationViewController];
        controller.drivingId = _drivingId;
        controller.subjectInfo = subjectInfo;
    }
}
#pragma - mark 数据

- (void)getSubject {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getSubject];
    }];
    
    [self getSubjectFromServer];
}

- (void)getSubjectFromServer {
    [_viewModel getSubjectListFromServer:getUser().id controller:self callBack:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
        }
    }];
}

@end
