//
//  PersonalController.m
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/26.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "PersonalController.h"

#import "HFStretchableTableHeaderView.h"
#import <UIImageView+AFNetworking.h>

@interface PersonalController ()<UITableViewDataSource, UITableViewDelegate> {
    
    @private
    __weak IBOutlet UITableView *_tableView;
    NSArray *_dataSource;
    __weak IBOutlet UIView *_headerView;
    HFStretchableTableHeaderView *_stretchView;
    __weak IBOutlet UIImageView *_avatarImage;
    __weak IBOutlet UILabel *_lblNickName;
}

@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 刷新用户
    [self refreshHeaderViewWithUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _dataSource = @[@[@"我的消息", @"我的驾校", @"我的教练"], @[@"我的优惠券"]];
    [self loadNav];
    [self loadHeaderView];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"我的驾考"];
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
    
    
    // 给头像和昵称添加点击手势
    UITapGestureRecognizer *tapAvatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatarAndNickName)];
//    [_avatarImage addGestureRecognizer:tapAvatar];
    
    UITapGestureRecognizer *tapNickName = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatarAndNickName)];
    [_lblNickName addGestureRecognizer:tapNickName];
    
    [_headerView addGestureRecognizer:tapAvatar];
}

#pragma - mark 刷新用户

- (void)refreshHeaderViewWithUser {
    if (hasUser()) {
        UserInfo *user = getUser();
        [_avatarImage setImageWithURL:getImageUrl(user.resource_url) placeholderImage:[UIImage imageNamed:@"default_user_avatar"]];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalCell" forIndexPath:indexPath];
    NSArray *list = _dataSource[indexPath.section];
    cell.textLabel.text = list[indexPath.row];
    cell.detailTextLabel.text = @"";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!checkUserLogin(self)) {
        return;
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
//                [self performSegueWithIdentifier:@"SyncProgress" sender:indexPath];
                break;
            case 1:
                [self performSegueWithIdentifier:@"MySchool" sender:indexPath];
                break;
            case 2:
                [self performSegueWithIdentifier:@"MyCoach" sender:indexPath];
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"MyCoupon" sender:indexPath];
                break;
            case 1:
                [self performSegueWithIdentifier:@"MyComment" sender:indexPath];
                break;
            default:
                break;
        }
    }
}

#pragma - mark 点击头像及昵称触发方法
- (IBAction)clickEdit:(id)sender {
    [self tapAvatarAndNickName];
}

- (void)tapAvatarAndNickName {
    if (!checkUserLogin(self)) {
        return;
    }
    
    // 到个人资料
    [self performSegueWithIdentifier:@"PersonalData" sender:nil];
}

@end
