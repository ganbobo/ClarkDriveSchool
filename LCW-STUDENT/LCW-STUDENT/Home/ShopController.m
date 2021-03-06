//
//  ShopController.m
//  LCW
//
//  Created by St.Pons.Mr.G on 15/8/29.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "ShopController.h"

#import "ShopCell.h"
#import "SchoolDetailController.h"

#import "MXPullDownMenu.h"
#import "ShopViewModel.h"
#import "AddressViewModel.h"
#import "AddressModel.h"
#import "MySchoolViewModel.h"
#import "MySchoolInfo.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import "LocationManager.h"
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import "ShopAnnotation.h"
#import "SearchView.h"


#define kListTag  100001
#define kMapTag   100002

@implementation FilterInfo

@end

@interface ShopController ()<UITableViewDataSource, UITableViewDelegate, MXPullDownMenuDelegate, BMKMapViewDelegate, SearchViewDelegate> {
    @private
    UIView *_titleView;
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_dataMenu;
    MXPullDownMenu *_pullDownMenu;
    
    NSArray *_priceList;
    
    BMKMapView *_mapView;
    
    // 数据管理
    ShopViewModel *_shopViewModel;
    
    FilterInfo *_filterInfo;
}

@end

@implementation ShopController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _shopViewModel = [[ShopViewModel alloc] init];
    [self loadNav];
    [self loadMapView];
    [self loadTableView];
    if (!_hasSignUp) {
        [self loadPullDownMenuView];
    } else {
        [self getMySchool];
    }
}

- (void)loadTableView {
    if (!_hasSignUp) {
        UIEdgeInsets edge = _tableView.contentInset;
        edge.top = 45;
        _tableView.contentInset = edge;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma - mark 界面加载

- (void)loadNav {
    if (!_hasSignUp) {
        [PMCommon setNavigationBarRightButton:self withBtnNormalImg:[UIImage imageNamed:@"nav_search"] withAction:@selector(clickSearch)];
        
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.layer.borderColor = kGreenColor.CGColor;
        _titleView.layer.borderWidth = 1.5;
        self.navigationItem.titleView = _titleView;
        
        UIButton *btnList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _titleView.width / 2.0, _titleView.height)];
        [btnList setTitleColor:kGreenColor forState:UIControlStateNormal];
        [btnList setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btnList setBackgroundImage:[UIImage imageNamed:@"btn_common_white"] forState:UIControlStateNormal];
        [btnList setBackgroundImage:[self createImageWithColor:kGreenColor] forState:UIControlStateSelected];
        [btnList setTitle:@"列表版" forState:UIControlStateNormal];
        btnList.titleLabel.font = [UIFont systemFontOfSize:15];
        btnList.tag = kListTag;
        [btnList addTarget:self action:@selector(clickSwich:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btnList];
        
        UIButton *btnMap = [[UIButton alloc] initWithFrame:CGRectMake(_titleView.width / 2.0, 0, _titleView.width / 2.0, _titleView.height)];
        [btnMap setTitleColor:kGreenColor forState:UIControlStateNormal];
        [btnMap setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btnMap setBackgroundImage:[UIImage imageNamed:@"btn_common_white"] forState:UIControlStateNormal];
        [btnMap setBackgroundImage:[self createImageWithColor:kGreenColor] forState:UIControlStateSelected];
        [btnMap setTitle:@"地图版" forState:UIControlStateNormal];
        btnMap.titleLabel.font = [UIFont systemFontOfSize:15];
        btnMap.tag = kMapTag;
        [btnMap addTarget:self action:@selector(clickSwich:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btnMap];
        
        [self clickSwich:btnList];
    } else {
        [PMCommon setNavigationTitle:self withTitle:@"我的驾校"];
    }
}

- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)loadMapView {
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - NavBarHeight - StatusBarHeight)];
    [_mapView setMapType:BMKMapTypeStandard];
    _mapView.showsUserLocation = YES;
    _mapView.zoomEnabled= YES;
    _mapView.scrollEnabled = YES;
    _mapView.zoomLevel = 12;
    _mapView.hidden = YES;
    [self.view addSubview:_mapView];
    
    [self getLocation];
}

- (void)loadPullDownMenuView {
    [self getAddress];
}

#pragma - mark 导航按钮点击

- (void)clickSwich:(UIButton *)button {
    UIButton *btnList = (UIButton *)[_titleView viewWithTag:kListTag];
    UIButton *btnMap = (UIButton *)[_titleView viewWithTag:kMapTag];
    
    // 点选列表
    if (button.tag == kListTag) {
        btnList.selected = YES;
        btnList.userInteractionEnabled = NO;
        btnMap.selected = NO;
        btnMap.userInteractionEnabled = YES;
        
        _mapView.hidden = YES;
        _pullDownMenu.hidden = NO;
    }
    
    // 点选地图
    if (button.tag == kMapTag) {
        btnList.selected = NO;
        btnList.userInteractionEnabled = YES;
        btnMap.selected = YES;
        btnMap.userInteractionEnabled = NO;
        _mapView.hidden = NO;
        _pullDownMenu.hidden = YES;
        [_pullDownMenu dismiss];
    }
}

- (void)clickSearch {
    SearchView *searchView = [[SearchView alloc] init];
    searchView.viewModel = _shopViewModel;
    searchView.delegate = self;
    [searchView show];
}

#pragma - mark SearchViewDelegate

- (void)didSelectShopInfo:(ShopInfo *)shopInfo {
    [self performSegueWithIdentifier:@"SchoolDetail" sender:shopInfo];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _shopViewModel.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopCell *cell
    = [tableView dequeueReusableCellWithIdentifier:@"ShopCell" forIndexPath:indexPath];
    [cell refreshCellWithInfo:_shopViewModel.dataSource[indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"SchoolDetail" sender:indexPath];
}

#pragma - mark 界面跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SchoolDetail"]) {
        SchoolDetailController *controller = [segue destinationViewController];
        if ([sender isKindOfClass:[ShopInfo class]]) {
            ShopInfo *info = (ShopInfo *)sender;
            controller.shopInfo = info;
        } else {
            NSIndexPath *indexPath = (NSIndexPath *)sender;
            ShopInfo *info = _shopViewModel.dataSource[indexPath.section];
            controller.shopInfo = info;

        }
        
        controller.hasSignUp = _hasSignUp;
    }
}

#pragma - mark BMKMapViewDelegate 代理

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    if ([annotation isKindOfClass:[ShopAnnotation class]]) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = YES;
        }
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[ShopAnnotation class]]) {
        ShopAnnotation *annotatiion = (ShopAnnotation *)view.annotation;
        [self performSegueWithIdentifier:@"SchoolDetail" sender:annotatiion.shopInfo];
    }
}

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
    switch (column) {
        case 0: {
            switch (row) {
                case 0:
                    _filterInfo.toDate = @"asc";
                    break;
                case 1:
                    _filterInfo.toDate = @"asc";
                    break;
                case 2:
                    _filterInfo.toDate = @"desc";
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1: {
            switch (row) {
                case 0:
                    _filterInfo.toDate = @"asc";
                    break;
                
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    } 
    
    [self getDataFromServer];
}

#pragma - mark 获取数据

- (void)getAddress {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getAddress];
    }];
    
    [self getAddressFromServer];
}

- (void)getAddressFromServer {
    // 初始化筛选条件
    _filterInfo = [[FilterInfo alloc] init];
    if ([LocationManager sharedLocationManager].addressInfo) {
        _filterInfo.cityId = [NSString stringWithFormat:@"%ld", (long)[LocationManager sharedLocationManager].addressInfo.c_id];
    } else {
        _filterInfo.cityId = @"";
    }
    _filterInfo.toDate = @"asc";
    _filterInfo.startPrice = 0;
    _filterInfo.endPrice = 100000;
    
    _dataMenu = @[@[@"综合排序", @"距离近到远", @"评分高到低", @"人气高到低"], @[@"价格", @"价格低到高", @"价格高到低"]];
            
    _pullDownMenu = [[MXPullDownMenu alloc] initWithArray:_dataMenu selectedColor:[UIColor colorWithRed:0.180 green:0.635 blue:0.353 alpha:1.000]];
    _pullDownMenu.delegate = self;
    _pullDownMenu.frame = CGRectMake(0, 64, ScreenWidth, 45);
    [_pullDownMenu setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_pullDownMenu];
    
    [_pullDownMenu setSelectRow:0];
}

- (void)getData {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getData];
    }];
    
    [self getDataFromServer];
}

- (void)getDataFromServer {
    [_shopViewModel getShopListFromServer:_filterInfo.cityId date:_filterInfo.toDate startPrice:_filterInfo.startPrice endPrice:_filterInfo.endPrice controller:self callBack:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
            
            [_mapView removeAnnotations:_mapView.annotations];
            for (ShopInfo *info in _shopViewModel.dataSource) {
                ShopAnnotation *annotation = [[ShopAnnotation alloc]init];
                annotation.shopInfo = info;
                [_mapView addAnnotation:annotation];
            }
        }
    }];
}

- (void)getMySchool {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getMySchoolFromServer];
    }];
    
    [self getMySchoolFromServer];

}

- (void)getMySchoolFromServer {
    MySchoolViewModel *viewModel = [[MySchoolViewModel alloc] init];
    [viewModel getSchoolDetailFromSever:self callBack:^(BOOL success) {
        if (success) {
            ShopInfo *info = [[ShopInfo alloc] init];
            MySchoolInfo *schoolInfo = viewModel.mySchoolInfo;
            info.driving_name = schoolInfo.drivingName;
            info.id = schoolInfo.drivingId;
            info.driving_price = schoolInfo.drivingPrice;
            info.level = schoolInfo.level;
//            info.driving_comm_num = schoolInfo.drivingCommNum;
//            info.resource_url = schoolInfo.resourseUrl;
//            info.scole = schoolInfo.scole;
         
            [_shopViewModel.dataSource removeAllObjects];
            [_shopViewModel.dataSource addObject:info];
            [_tableView reloadData];
        }
    }];
}

- (void)getLocation {
    if ([LocationManager sharedLocationManager].location) {
        [_mapView updateLocationData:[LocationManager sharedLocationManager].location];
        if (_mapView) {
            [_mapView setCenterCoordinate:[LocationManager sharedLocationManager].location.location.coordinate animated:YES];
        }
    } else {
        [[LocationManager sharedLocationManager] startLocation:^(NSString *city) {
            if (city == nil) {
                [self showMiddleToastWithContent:@"定位失败"];
            } else {
                [_mapView updateLocationData:[LocationManager sharedLocationManager].location];
                if (_mapView) {
                    [_mapView setCenterCoordinate:[LocationManager sharedLocationManager].location.location.coordinate animated:YES];
                }            }
        }];
    }
}

@end
