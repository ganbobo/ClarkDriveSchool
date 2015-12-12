//
//  SettingController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "SettingController.h"
#import "MyCoachViewModel.h"
#import "AboutUsController.h"

@interface SettingController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate> {
    NSArray *_dataSource;
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _dataSource = @[@[@"关于网上学车"]];
    [self loadNav];
}
#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"设置"];
}

- (void)loadFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.window.bounds.size.width, ScreenHeight - NavBarHeight - StatusBarHeight - 4 * 44 - 30)];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
    
    UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLogout.backgroundColor = [UIColor whiteColor];
    btnLogout.frame = CGRectMake(0, view.height - 90, ScreenWidth, 40);
    [btnLogout setTitle:@"退出" forState:UIControlStateNormal];
    [btnLogout setTitleColor:RGBA(0x32, 0x32, 0x32, 1) forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(clickLogout) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLogout];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list = _dataSource[section];
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    cell.textLabel.textColor = RGBA(0x32, 0x32, 0x32, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    NSArray *list = _dataSource[indexPath.section];
    cell.textLabel.text = list[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AboutUsController *controller = [[AboutUsController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)clickLogout {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确定退出登录吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定退出" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        MyCoachViewModel *model = [[MyCoachViewModel alloc] init];
        [model logoutToServer:self callBack:^(BOOL success) {
            if (success) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}

@end
