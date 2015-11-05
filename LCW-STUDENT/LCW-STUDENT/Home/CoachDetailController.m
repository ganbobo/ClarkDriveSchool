//
//  CoachDetailController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "CoachDetailController.h"

#import "HFStretchableTableHeaderView.h"
#import "CoachViewModel.h"

@interface CoachDetailController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
@private
    __weak IBOutlet UITableView *_tableView;
    NSArray *_dataSource;
    __weak IBOutlet UIView *_headerView;
    HFStretchableTableHeaderView *_stretchView;
    __weak IBOutlet UIImageView *_avatarImage;
    __weak IBOutlet UILabel *_lblNickName;
}

@end

@implementation CoachDetailController

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
    _dataSource = @[@[@"车牌", @"驾校", @"科目"], @[@"目前学员", @"累积学员"], @[@"学员评价"]];
    [self loadNav];
    [self loadHeaderView];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"教练详情"];
}

- (void)loadHeaderView {
    _stretchView = [HFStretchableTableHeaderView new];
    [_stretchView stretchHeaderForTableView:_tableView withView:_headerView];
    [_stretchView resizeView];
    
    // 设置头像
    _avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarImage.layer.cornerRadius = _avatarImage.width / 2.0;
    _avatarImage.layer.masksToBounds = YES;
    _avatarImage.layer.borderWidth = 1.0;
    
    _avatarImage.userInteractionEnabled = YES;
    _lblNickName.userInteractionEnabled = YES;
}

#pragma - mark 刷新用户

- (void)refreshHeaderViewWithUser {
    if (hasUser()) {
        UserInfo *user = getUser();
        _avatarImage.image = [UIImage imageNamed:@"default_user_avatar"];
        _lblNickName.text = user.cn_name;
    } else {
        _avatarImage.image = [UIImage imageNamed:@"default_user_avatar"];
        _lblNickName.text = @"未登录";
    }
}

#pragma - mark UIScrollViewDelegate 代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_stretchView scrollViewDidScroll:scrollView];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoachDetailCell" forIndexPath:indexPath];
    NSArray *list = _dataSource[indexPath.section];
    cell.textLabel.text = list[indexPath.row];
    
    if (indexPath.section == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma - mark 刷新用户昵称

- (void)refreshUserInfo {
    
}

#pragma - mark 按钮点击事件

- (IBAction)clickBlindCoach:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定绑定该教练?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        CoachViewModel *viewModel = [[CoachViewModel alloc] init];
        [viewModel blindCoachToServer:_coachInfo.trainerId subjectId:_subjectInfo.id controller:self callBack:^(BOOL success) {
            
        }];
    }
}

@end
