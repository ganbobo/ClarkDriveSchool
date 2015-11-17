//
//  MySchoolController.m
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/2.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MySchoolController.h"

#import "MySchoolViewModel.h"
#import "SchoolCommentController.h"

@implementation ShowInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"";
        _subTitle = @"";
    }
    return self;
}

@end

@interface MySchoolController ()<UITableViewDelegate, UITableViewDataSource> {
    MySchoolViewModel *_mySchoolViewModel;
    
    NSMutableArray *_dataSource;
    
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIButton *_btnComment;
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
    _dataSource = [[NSMutableArray alloc] init];
    [self loadNav];
    _btnComment.layer.cornerRadius = 5;
    _btnComment.layer.masksToBounds = YES;
}

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"我的驾校"];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySchoolCell" forIndexPath:indexPath];
    
    if (indexPath.section == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ShowInfo *info = _dataSource[indexPath.section];
    cell.textLabel.text = info.title;
    cell.detailTextLabel.text = info.subTitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        [self callPhone:_mySchoolViewModel.mySchoolInfo.tel];
    }
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
        if (success) {
            ShowInfo *infoOne = [[ShowInfo alloc] init];
            infoOne.title = @"驾校";
            infoOne.subTitle = _mySchoolViewModel.mySchoolInfo.drivingName;
            [_dataSource addObject:infoOne];
            
            ShowInfo *infoTwo = [[ShowInfo alloc] init];
            infoTwo.title = @"地址";
            infoTwo.subTitle = _mySchoolViewModel.mySchoolInfo.drivingAddr;
            [_dataSource addObject:infoTwo];
            
            ShowInfo *infoThree = [[ShowInfo alloc] init];
            infoThree.title = @"电话";
            infoThree.subTitle = [NSString stringWithFormat:@"%@(科一、科四约考咨询)", _mySchoolViewModel.mySchoolInfo.tel];
            [_dataSource addObject:infoThree];
            
            [_tableView reloadData];
        }
    }];
}

- (void)callPhone:(NSString *)phone {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phone]]];
}

- (IBAction)clickComment:(id)sender {
    SchoolCommentController *controller = [[SchoolCommentController alloc] init];
    controller.mySchoolInfo = _mySchoolViewModel.mySchoolInfo;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
