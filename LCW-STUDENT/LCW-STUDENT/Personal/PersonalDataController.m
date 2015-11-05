//
//  PersonalDataController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/5.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "PersonalDataController.h"

#import "EditDataController.h"

@interface PersonalDataController ()<UITableViewDataSource, UITableViewDelegate> {
    NSArray *_dataSource;
    __weak IBOutlet UITableView *_tableView;
    
    UIImageView *_avatarImage;
}

@end

@implementation PersonalDataController

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
    _dataSource = @[@[@"我的头像"], @[@"用户名", @"手机", @"姓名", @"身份证"], @[@"设置"]];
    [self loadNav];
    [self loadAvatarView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];// 刷新数据
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"个人消息"];
}

- (void)loadAvatarView {
    _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _avatarImage.layer.cornerRadius = 25;
    _avatarImage.layer.masksToBounds = YES;
    _avatarImage.layer.borderColor = RGBA(0xee, 0xee, 0xee, 1).CGColor;
    _avatarImage.layer.borderWidth = 2;
    _avatarImage.image = [UIImage imageNamed:@"default_user_avatar"];
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
    if (indexPath.section == 0) {
        return 60;
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell" forIndexPath:indexPath];
    NSArray *list = _dataSource[indexPath.section];
    cell.textLabel.text = list[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = nil;
    if (indexPath.section == 0) {
        cell.detailTextLabel.text = @"";
        cell.accessoryView = _avatarImage;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else if (indexPath.section == 2) {
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = [self getPhoneNum:getUser().login_name];
                break;
            case 1:
                cell.detailTextLabel.text = [self getPhoneNum:getUser().login_name];
                break;
            case 2: {
                cell.detailTextLabel.text = getUser().cn_name;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
                break;
            case 3: {
                cell.detailTextLabel.text = getUser().identification;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 2:
                [self performSegueWithIdentifier:@"EditData" sender:@(YES)];
                break;
            case 3:
                [self performSegueWithIdentifier:@"EditData" sender:@(NO)];
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"Setting" sender:indexPath];
    }
}

#pragma - mark 界面跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditData"]) {
        BOOL isEditName = [(NSNumber *)sender boolValue];
        EditDataController *controller = segue.destinationViewController;
        controller.isEditName = isEditName;
    }
}

#pragma - mark 隐藏手机号中间四位

- (NSString *)getPhoneNum:(NSString *)phoneNum {
    NSString *tel = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return tel;
}

@end
