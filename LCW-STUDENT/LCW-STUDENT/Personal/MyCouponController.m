//
//  MyCouponController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/20.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCouponController.h"

#import "MyCouponCell.h"
#import "MyCouponViewModel.h"
#import "CouponController.h"

@interface MyCouponController () <UITableViewDelegate, UITableViewDataSource> {
    
    __weak IBOutlet UITableView *_tableView;
    
    MyCouponViewModel *_viewModel;
}

@end

@implementation MyCouponController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _viewModel = [[MyCouponViewModel alloc] init];
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"我的优惠券"];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCouponCell" forIndexPath:indexPath];
    [cell refreshCellByInfo:_viewModel.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CouponController *controller = [CouponController getCouponController];
    controller.couponInfo = _viewModel.dataSource[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma - mark 获取数据

- (void)getData {
    __weak typeof(self) safeSelf = self;
    
    [self showLoading:^{
        [safeSelf getData];
    }];
    
    [self getDataFromServer];
}

- (void)getDataFromServer {
    [_viewModel getMyCouponListFromServer:self callback:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
        }
    }];
}

@end
