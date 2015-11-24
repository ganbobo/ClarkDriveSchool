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

#import "SchoolViewModel.h"
#import "BlindIDController.h"
#import "CoachFilterController.h"
#import "RTLabel.h"
#import "MapViewController.h"
#import <UIImageView+AFNetworking.h>

@interface SchoolDetailController ()<UITableViewDataSource, UITableViewDelegate, SchoolInfoViewDelegate> {
    NSMutableArray *_dataSource;
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet RTLabel *_lblName;
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
    // 学车流程
    SchoolDescView *_studyProcessView;
    // 驾校班车
    SchoolDescView *_schoolCarView;
    
    // 数据
    SchoolViewModel *_schoolViewModel;
}

@end

@implementation SchoolDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getSchoolInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _dataSource = [[NSMutableArray alloc] init];
    _schoolViewModel = [[SchoolViewModel alloc] init];
    [self loadNav];
    [self loadStretchView];
}

#pragma - mark 加载数据

- (void)loadData:(SchoolDetailInfo *)detailInfo {
    _infoView = [[SchoolInfoView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    _infoView.delegate = self;
    [_infoView setDataSource:_hasSignUp drivingInfo:detailInfo.driving];
    [_dataSource addObject:_infoView];
    _lblName.textColor = [UIColor colorWithRed:0.992 green:0.306 blue:0.024 alpha:1.000];
    _lblName.text = [NSString stringWithFormat:@"<font face='HelveticaNeue-CondensedBold' color='#eb4f38' size=14>￥</font><font face='HelveticaNeue-CondensedBold' color='#eb4f38' size=20>%ld</font> <font face='HelveticaNeue-CondensedBold' color='#eb4f38' size=14>%@</font> <font face='HelveticaNeue-CondensedBold' color='#eb4f38' size=14>C1周一到周日班</font>", (long)_shopInfo.driving_price, detailInfo.driving.drivingName];
    [_imgView setImageWithURL:getImageUrl(_shopInfo.resource_url) placeholderImage:[UIImage imageNamed:@"downlaod_picture_fail"]];
    
    if (detailInfo.privilegeList.count > 0) {
        _studentPrivilegeView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:2];
        NSMutableArray *list = [NSMutableArray array];
        for (PrivilegeInfo *info in detailInfo.privilegeList) {
            [list addObject:@{
                             kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                             kTEXT_ARRAY_KEY:@[info.privilege_name, info.privilege_text]
                             
                             }];
        }
        
        [_studentPrivilegeView setDataSource:list title:@"零从学员特权"];
        [_dataSource addObject:_studentPrivilegeView];
    }
    
    
    if (detailInfo.price.count > 0) {
        _costView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:5];
        
        NSMutableArray *list = [NSMutableArray array];
        [list addObject:@{
                         kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                         kTEXT_ARRAY_KEY:@[@"类型", @"总费用", @"考试费", @"培训费", @"其他"]
                         }];
        for (PriceInfo *info in detailInfo.price) {
            [list addObject:@{
                              kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                              kTEXT_ARRAY_KEY:@[info.class_type, [NSString stringWithFormat:@"%ld", (long)info.price], [NSString stringWithFormat:@"%ld", (long)info.examination_fee], [NSString stringWithFormat:@"%ld", (long)info.training_fee], [NSString stringWithFormat:@"%ld(%@)", (long)info.other_fee, info.text]]
                              }];
        }
        [_costView setDataSource:list title:@"费用说明"];
        
        [_dataSource addObject:_costView];

    }
    
    if (detailInfo.csList.count > 0) {
        _timeView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:detailInfo.csList.count];
        NSMutableArray *listTitle = [NSMutableArray array];
        NSMutableArray *listContent = [NSMutableArray array];
        for (TimeInfo *info in detailInfo.csList) {
            [listTitle addObject:info.subject_name];
            [listContent addObject:info.subject_message];
        }
        [_timeView setDataSource:@[@{
                                       kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                                       kTEXT_ARRAY_KEY:listTitle
                                       },
                                   @{
                                       kTEXT_COLOR_KEY:[UIColor orangeColor],
                                       kTEXT_ARRAY_KEY:listContent
                                       }
                                   ] title:@"时间分配"];
        [_dataSource addObject:_timeView];

    }
    
    if (detailInfo.pList.count > 0) {
        _studyProcessView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:2];
        
        NSMutableArray *list = [NSMutableArray array];
        for (StudyProcessInfo *info in detailInfo.pList) {
            [list addObject:@{
                              kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                              kTEXT_ARRAY_KEY:@[info.process_name, info.process_message]
                              
                              }];
        }
        [_studyProcessView setDataSource:list title:@"学车流程"];
        [_dataSource addObject:_studyProcessView];
    }
    
    if (detailInfo.sList.count > 0) {
        _schoolCarView = [[SchoolDescView alloc] initWithWidth:ScreenWidth originalY:0 columns:2];
        NSMutableArray *list = [NSMutableArray array];
        for (CarRecord *info in detailInfo.sList) {
            [list addObject:@{
                              kTEXT_COLOR_KEY:RGBA(0x69, 0x69, 0x69, 1),
                              kTEXT_ARRAY_KEY:@[[NSString stringWithFormat:@"%@", info.scheduled_name], [NSString stringWithFormat:@"%@", info.scheduled_text]]
                              
                              }];
        }
        
        [_schoolCarView setDataSource:list title:@"驾校班车"];
        [_dataSource addObject:_schoolCarView];
    }
    
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

#pragma - mark 跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BlindID"]) {
        NSString *drivingId = (NSString *)sender;
        BlindIDController *controller = [segue destinationViewController];
        controller.driveId = drivingId;
    }
    
    if ([segue.identifier isEqualToString:@"CoachFilter"]) {
        CoachFilterController *controller = [segue destinationViewController];
        controller.drivingId = _shopInfo.id;
    }
}

#pragma - mark SchoolInfoViewDelegate 代理

- (void)didSelectCoach {
    if (!checkUserLogin(self)) {
        return;
    }
    if (_hasSignUp) {
        [self performSegueWithIdentifier:@"CoachFilter" sender:nil];
    } else {
        if ([getUser().identification isEqualToString:@"未填写"]) {
            [self performSegueWithIdentifier:@"BlindID" sender:_shopInfo.id];
        } else {
            SchoolViewModel *viewModel = [[SchoolViewModel alloc] init];
            __weak typeof(self) safeSelf = self;
            [viewModel getCouponFromSever:self driveId:_shopInfo.id name:getUser().cn_name identifier:getUser().identification callBack:^(BOOL success) {
                if (success) {
                    [safeSelf performSegueWithIdentifier:@"Coupon" sender:_shopInfo.id];
                }
            }];
        }
    }
}

- (void)didSelectComment {
    CommentController *controller = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommentController"];
    controller.shopInfo = _shopInfo;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didShowMapLocation {
    MapViewController *controller = [[MapViewController alloc] init];
    controller.shopInfo = _shopInfo;
    [self.navigationController pushViewController:controller animated:YES];
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
    
    __weak typeof(self) safeSelf = self;
    [_schoolViewModel getSchoolDetailFromSever:self driveId:_shopInfo.id callBack:^(BOOL success) {
        if (success) {
            [safeSelf loadData:_schoolViewModel.schoolDetailInfo];
        }
    }];
}

@end
