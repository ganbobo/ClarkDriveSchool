//
//  HomeController.m
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/26.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "HomeController.h"

#import "AdsView.h"
#import "ADScrollView.h"
#import "AdsInfo.h"

#import "FeedBackController.h"
#import "LocationManager.h"

#define kHeaderViewHeight        (1 / 2.2 * ScreenWidth)
#define kFooterViewHeight        ((568 - 160 - 64 - 49.0) / 320 * ScreenWidth)

@interface HomeController ()<AdsViewDelegate> {
    ADScrollView *_adsScrollView;// 广告视图
    UIButton *_btnLeftNav;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIView *_footerView;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 开启定位
    [self startLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    if ([LocationManager sharedLocationManager].addressInfo) {
        [_btnLeftNav setTitle:[NSString stringWithFormat:@" %@", [LocationManager sharedLocationManager].addressInfo.c_name] forState:UIControlStateNormal];
    }
}

- (void)loadView {
    [super loadView];
    [self loadNav];
    [self loadAdsHeaderView];
    [self loadFooterView];
    [self loadAdsData];
}

#pragma - mark 加载广告数据

- (void)loadAdsData {
    AdsInfo *info1 = [[AdsInfo alloc] init];
    info1.imagePath = @"1.png";
    
    AdsInfo *info2 = [[AdsInfo alloc] init];
    info2.imagePath = @"2.png";
    
    AdsInfo *info3 = [[AdsInfo alloc] init];
    info3.imagePath = @"3.png";
    
    AdsInfo *info4 = [[AdsInfo alloc] init];
    info4.imagePath = @"4.png";
    
    [self setAdsScrollView:@[info1, info2, info3, info4]];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationBarRightButton:self withBtnNormalImg:[UIImage imageNamed:@"nav_phone"] withAction:@selector(clickPhone)];
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_nav_title"]];
    self.navigationItem.titleView = titleView;
    
    // 左边按钮
    _btnLeftNav = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 33)];
    [_btnLeftNav setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnLeftNav setTitle:@" 定位中" forState:UIControlStateNormal];
    [_btnLeftNav setImage:[UIImage imageNamed:@"home_location"] forState:UIControlStateNormal];
    _btnLeftNav.titleLabel.font = [UIFont systemFontOfSize:15];
    _btnLeftNav.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnLeftNav.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_btnLeftNav addTarget:self action:@selector(clickSelectAddress) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:_btnLeftNav];
    self.navigationItem.leftBarButtonItem = left;
}

// 加载头部广告视图
- (void)loadAdsHeaderView {
    _adsScrollView = [[ADScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kHeaderViewHeight)];
    _adsScrollView.backgroundColor = [UIColor clearColor];
    [_tableView setTableHeaderView:_adsScrollView];
}

- (void)loadFooterView {
    [_footerView setHeight:kFooterViewHeight];
    [_tableView setTableFooterView:_footerView];
}

#pragma - mark 按钮点击事件

- (void)clickPhone {
    if (!checkUserLogin(self)) {
        return;
    }
    FeedBackController *controller = [[FeedBackController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)clickSelectAddress {
    UINavigationController *controller = [UIStoryboard storyboardWithName:@"Address" bundle:nil].instantiateInitialViewController;
    [self presentViewController:controller animated:YES completion:nil];
}

// 约车
- (IBAction)clickAppointCar:(id)sender {
    if (!checkUserLogin(self)) {
        return;
    }
    [self performSegueWithIdentifier:@"CarOrder" sender:sender];
}

// 约考
- (IBAction)clickAppointPaper:(id)sender {
    [self showMiddleToastWithContent:@"该功能暂未开放，敬请期待"];
//    [self performSegueWithIdentifier:@"TestOrder" sender:sender];
}

// 购车，驾校
- (IBAction)clickShoppingCar:(id)sender {
    [self performSegueWithIdentifier:@"Filter" sender:sender];
}

#pragma - mark 设置轮播视图

- (void)setAdsScrollView:(NSArray *)list {
    
    if (list.count == 0) {
        [_tableView setTableHeaderView:nil];
        return;
    } else {
        [_tableView setTableHeaderView:_adsScrollView];
    }
    
    // 刷新广告
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    
    if (list.count > 1) { // 超过两个广告
        // 添加最后一个到广告位
        AdsView *btnFirst = [[AdsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _adsScrollView.height)];
        [btnFirst setAdsInfo:list[list.count - 1]];
        btnFirst.delegate = self;
        [dataSource addObject:btnFirst];
        
        for (NSInteger i = 0; i < list.count; i ++) {
            AdsView *btn = [[AdsView alloc] initWithFrame:CGRectMake((i + 1) * ScreenWidth, 0, ScreenWidth, _adsScrollView.height)];
            [btn setAdsInfo:list[i]];
            btn.delegate = self;
            [dataSource addObject:btn];
        }
        
        // 添加第一个到末尾
        AdsView *btnLast = [[AdsView alloc] initWithFrame:CGRectMake(ScreenWidth * (list.count + 1), 0, ScreenWidth, _adsScrollView.height)];
        btnLast.delegate = self;
        [btnLast setAdsInfo:list[0]];
        [dataSource addObject:btnLast];
    } else {
        // 添加第一个到广告位
        AdsView *btnFirst = [[AdsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _adsScrollView.height)];
        [btnFirst setAdsInfo:list[0]];
        [btnFirst setDelegate:self];
        [dataSource addObject:btnFirst];
    }
    
    [_adsScrollView addViewFromList:dataSource];
}


#pragma - mark AdsViewDelegate 代理

- (void)didSelectAdsInfo:(AdsInfo *)adsInfo {
    
}

#pragma - mark 开始定位

- (void)startLocation {
    [[LocationManager sharedLocationManager] startLocation:^(NSString *city) {
        if (city == nil) {
            [_btnLeftNav setTitle:@" 定位失败" forState:UIControlStateNormal];
        } else {
            [_btnLeftNav setTitle:[NSString stringWithFormat:@" %@", city] forState:UIControlStateNormal];
        }
    }];
    
}

@end
