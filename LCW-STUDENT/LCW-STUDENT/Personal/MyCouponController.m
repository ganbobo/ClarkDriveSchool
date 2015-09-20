//
//  MyCouponController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/20.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCouponController.h"

#import "MyCouponCell.h"

@interface MyCouponController () <UITableViewDelegate, UITableViewDataSource> {
    
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation MyCouponController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"我的优惠券"];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCouponCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
