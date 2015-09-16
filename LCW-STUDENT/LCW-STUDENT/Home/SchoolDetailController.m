//
//  SchoolDetailController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/7.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "SchoolDetailController.h"

#import "SchoolInfoView.h"
#import "HFStretchableTableHeaderView.h"

#import "CommentController.h"
#import "SchoolDescView.h"

@interface SchoolDetailController ()<UITableViewDataSource, UITableViewDelegate, SchoolInfoViewDelegate> {
    NSMutableArray *_dataSource;
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIView *_headerView;
    HFStretchableTableHeaderView *_stretchView;
    // 介绍
    SchoolInfoView *_infoView;
    // 学员特权
    SchoolDescView *_studentPrivilegeView;
    // 费用说明
    SchoolDescView *_costView;
    // 时间分配
    SchoolDescView *_timeView;
    // 学成流程
    SchoolDescView *_studyProcessView;
}

@end

@implementation SchoolDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _dataSource = [[NSMutableArray alloc] init];
    [self loadNav];
    [self loadStretchView];
}

#pragma - mark 加载数据

- (void)loadData {
    _infoView = [[SchoolInfoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    _infoView.delegate = self;
    [_infoView setDataSource:_hasSignUp];
    [_dataSource addObject:_infoView];
    
    _studentPrivilegeView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:2];
    [_studentPrivilegeView setDataSource:@[@{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"打赏教练", @"购买成功，自动获取教练奖金权限，学员根据教练教学优劣，决定教练奖金"]
                                           
                                           },
                                           @{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"网上约车", @"练车时间，听您的，零碎时间，轻松拿照"]
                                               
                                               }
                                           ] title:@"零从学员特权"];
    [_dataSource addObject:_studentPrivilegeView];
    
    _costView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:4];
    [_costView setDataSource:@[@{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"总费用", @"考试费", @"培训费", @"其他"]
                                               },
                                           @{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"2980元", @"560元", @"2320元", @"100元照片，书本，保险，体检"]
                                               }
                                           ] title:@"费用说明"];
    [_dataSource addObject:_costView];
    
    _timeView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:4];
    [_timeView setDataSource:@[@{
                                   kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                   kTEXT_ARRAY_KEY:@[@"科目一", @"科目二", @"科目三", @"科目四"]
                                   },
                               @{
                                   kTEXT_COLOR_KEY:[UIColor orangeColor],
                                   kTEXT_ARRAY_KEY:@[@"10-30天", @"练车8-15次", @"练车5-10次", @"2-15天"]
                                   }
                               ] title:@"时间分配"];
    [_dataSource addObject:_timeView];
    
    _studyProcessView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:2];
    [_studyProcessView setDataSource:@[@{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"报名", @"凭码消费→体检→照相→领书→报名完成"]
                                               
                                               },
                                           @{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"模拟考", @"理论学习→在驾校模拟考→连续3次92分以上→模拟考通过"]
                                               
                                               },
                                           @{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"科目一", @"模拟考通过，即可零从网预约科一考试，24小时内通知预约结果；"]
                                               
                                               },
                                           @{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"科目二", @"科二理论学时、模拟学时、实操学时各自挂满，可零从网预约科二考试，24小时内通知预约结果；"]
                                               
                                               },
                                           @{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"科目三", @"科三理论学时、模拟学时、实操学时各自挂满，可零从网预约科三考试，24小时内通知预约结果；"]
                                               
                                               },
                                           @{
                                               kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                               kTEXT_ARRAY_KEY:@[@"科目四", @"科目三通过后，即可零从网预约科四考试，24小时通知预约结果；"]
                                               
                                               }
                                           ] title:@"学成流程"];
    [_dataSource addObject:_studyProcessView];
    
    [_tableView reloadData];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"驾校详情"];
}

- (void)loadStretchView {
    _stretchView = [HFStretchableTableHeaderView new];
    [_stretchView stretchHeaderForTableView:_tableView withView:_headerView];
    [_stretchView resizeView];
}

#pragma - mark UIScrollViewDelegate 代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_stretchView scrollViewDidScroll:scrollView];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = _dataSource[indexPath.row];
    return view.height + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolDetailCell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [cell.contentView addSubview:_dataSource[indexPath.row]];
    
    return cell;
}

#pragma - mark SchoolInfoViewDelegate 代理

- (void)didSelectCoach {
    if (_hasSignUp) {
        [self performSegueWithIdentifier:@"CoachFilter" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"Coupon" sender:nil];
    }
}

- (void)didSelectComment {
    CommentController *controller = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didShowMapLocation {
    
}

@end
