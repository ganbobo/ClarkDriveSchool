//
//  CourseController.m
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/26.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CourseController.h"

#import "CourseCell.h"
#import "CourseViewModel.h"

@interface CourseController ()<UITableViewDataSource, UITableViewDelegate, CourseCellDelegate> {
    
    IBOutlet UIView *_headerView;
    __weak IBOutlet UITableView *_tableView;
    CourseViewModel *_viewModel;
    NSInteger _type;
    
    // 取消约车记录
    RecordInfo *_recordInfo;
}

@end

@implementation CourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [_headerView viewWithTag:999];
    [self clickSwich:btn];
    
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isFirstIn) {
        [self getDataFromServer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    UIEdgeInsets edge = _tableView.contentInset;
    edge.top = 55;
    _type = -1;
    _tableView.contentInset = edge;
    _viewModel = [[CourseViewModel alloc] init];
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"个人课表"];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count is %ld", [_viewModel.courseInfo getListByType:_type].count);
    return [_viewModel.courseInfo getListByType:_type].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell" forIndexPath:indexPath];
    if (!cell.delegate) {
        cell.delegate = self;
    }
    [cell refreshCellByInfo:[_viewModel.courseInfo getListByType:_type][indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma - mark 获取服务器数据

- (void)getData {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        if (checkUserLogin(self)) {
           [safeSelf getData];
        }
    }];
    
    
    if (!hasUser()) {
        [self finishedLodingWithTip:@"用户未登录" subTip:@"点击登录"];
        return;
    }
    
    [self getDataFromServer];
}

- (void)getDataFromServer {
    [_viewModel getCourseList:self callBack:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
            [self setHeaderView:_viewModel.courseInfo.jr];
        }
    }];
}

#pragma - mark 按钮点击事件

- (IBAction)clickSwich:(id)sender {
    UIButton *btn = (UIButton *)sender;
    _type = btn.tag - 1000;
    [_tableView reloadData];
    for (UIView *view in _headerView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.selected = NO;
        }
    }
    
    btn.selected = YES;
}

- (void)setHeaderView:(CoutInfo *)coutInfo {
    UIButton *btn_1 = [_headerView viewWithTag:999];
    UIButton *btn0 = [_headerView viewWithTag:1000];
    UIButton *btn1 = [_headerView viewWithTag:1001];
    UIButton *btn2 = [_headerView viewWithTag:1002];
    btn_1.titleLabel.numberOfLines = 2;
    btn0.titleLabel.numberOfLines = 2;
    btn1.titleLabel.numberOfLines = 2;
    btn2.titleLabel.numberOfLines = 2;
    
    btn_1.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn0.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [btn_1 setTitle:[NSString stringWithFormat:@"全部\n%ld", (long)coutInfo.all] forState:UIControlStateNormal];
    [btn0 setTitle:[NSString stringWithFormat:@"待练车\n%ld", (long)coutInfo.practicing] forState:UIControlStateNormal];
    [btn1 setTitle:[NSString stringWithFormat:@"已练车\n%ld", (long)coutInfo.practiced] forState:UIControlStateNormal];
    [btn2 setTitle:[NSString stringWithFormat:@"已缺课\n%ld", (long)coutInfo.absent] forState:UIControlStateNormal];
}

#pragma - mark CourseCellDelegate 代理

- (void)didClickCancel:(RecordInfo *)recordInfo {
    _recordInfo = recordInfo;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定取消此次约车吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [_viewModel cancelOrderCarUserDayId:_recordInfo.userDayId recordTime:[NSString stringWithFormat:@"%lld", _recordInfo.recordTime] controller:self callBack:^(BOOL success) {
            if (success) {
                for (RecordInfo *info in _viewModel.courseInfo.dataSource) {
                    if ([info.userDayId isEqualToString:_recordInfo.userDayId]) {
                        switch (info.type) {
                            case 0:
                                _viewModel.courseInfo.jr.practicing -= 1;
                                break;
                            case 1:
                                _viewModel.courseInfo.jr.practiced -= 1;
                                break;
                            case 2:
                                _viewModel.courseInfo.jr.absent -= 1;
                                break;
                            default:
                                break;
                        }
                        _viewModel.courseInfo.jr.all -= 1;
                        [_viewModel.courseInfo.dataSource removeObject:info];
                        break;
                    }
                    
                }
                [self setHeaderView:_viewModel.courseInfo.jr];
                [_tableView reloadData];
            }
        }];
    }
}

@end
