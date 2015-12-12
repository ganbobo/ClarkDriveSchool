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
#import <UIImageView+AFNetworking.h>
#import "CommentController.h"

@interface CoachDetailController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
@private
    __weak IBOutlet UITableView *_tableView;
    NSArray *_dataSource;
    __weak IBOutlet UIView *_headerView;
    HFStretchableTableHeaderView *_stretchView;
    __weak IBOutlet UIImageView *_avatarImage;
    __weak IBOutlet UILabel *_lblNickName;
    CoachViewModel *_viewModel;
}

@end

@implementation CoachDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshUser];
    [self getCoachDetailFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshUser {
    if (_coachInfo) {
        [_avatarImage setImageWithURL:getImageUrl(_coachInfo.resourceUrl) placeholderImage:[UIImage imageNamed:@"default_user_avatar"]];
        _lblNickName.text = [NSString stringWithFormat:@"%@", _coachInfo.trainerName];
    }
    
    if (_viewModel.coachDetailModel) {
        _lblNickName.text = [NSString stringWithFormat:@"%@ %@ %ld岁", _coachInfo.trainerName, _viewModel.coachDetailModel.sex == 1? @"男": @"女", (long)_viewModel.coachDetailModel.age];
    }
}

- (void)loadView {
    [super loadView];
    _viewModel = [[CoachViewModel alloc] init];
    _dataSource = @[@[@"驾校", @"科目"], @[@"目前学员", @"累积学员"], @[@"学员评价"]];
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
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = _coachInfo.drivingName;
                break;
            case 1:
                if (_viewModel.coachDetailModel) {
                     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", _viewModel.coachDetailModel.subjectName, _coachInfo.typeName];
                }
               
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld人", (long)_coachInfo.currentlyTrainee];
                break;
            case 1:
                if (_viewModel.coachUserModel) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld人", (long)_viewModel.coachUserModel.totalNum];
                } else {
                    cell.detailTextLabel.text = @"0人";
                }
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = [NSString stringWithFormat:@"好评%.0f%@ %ld人评", _coachInfo.percentages, @"%", (long)_coachInfo.comm];
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        CommentController *controller = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentController"];
        controller.coachInfo = _coachInfo;
        [self.navigationController pushViewController:controller animated:YES];
    }
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
        [_viewModel blindCoachToServer:_coachInfo.trainerId subjectId:_subjectId controller:self callBack:^(BOOL success) {
            
        }];
    }
}

#pragma - mark 获取教练详情

- (void)getCoachDetailFromServer {
    [_viewModel getCoachDetailInfoFromServer:_coachInfo.trainerId controller:self callBack:^(BOOL success) {
        if (success) {
            [self refreshUser];
            [_tableView reloadData];
        }
    }];
}

@end
