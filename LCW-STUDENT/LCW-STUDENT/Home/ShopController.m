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


#define kListTag  100001
#define kMapTag   100002

@implementation FilterInfo

@end

@interface ShopController ()<UITableViewDataSource, UITableViewDelegate, MXPullDownMenuDelegate, BMKMapViewDelegate> {
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
        _titleView.layer.borderColor = [UIColor colorWithRed:0.145 green:0.655 blue:0.341 alpha:1.000].CGColor;
        _titleView.layer.borderWidth = 1.5;
        self.navigationItem.titleView = _titleView;
        
        UIButton *btnList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _titleView.width / 2.0, _titleView.height)];
        [btnList setTitleColor:[UIColor colorWithRed:0.145 green:0.655 blue:0.341 alpha:1.000] forState:UIControlStateNormal];
        [btnList setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btnList setBackgroundImage:[UIImage imageNamed:@"btn_common_white"] forState:UIControlStateNormal];
        [btnList setBackgroundImage:[UIImage imageNamed:@"btn_common"] forState:UIControlStateSelected];
        [btnList setTitle:@"列表版" forState:UIControlStateNormal];
        btnList.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        btnList.tag = kListTag;
        [btnList addTarget:self action:@selector(clickSwich:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btnList];
        
        UIButton *btnMap = [[UIButton alloc] initWithFrame:CGRectMake(_titleView.width / 2.0, 0, _titleView.width / 2.0, _titleView.height)];
        [btnMap setTitleColor:[UIColor colorWithRed:0.145 green:0.655 blue:0.341 alpha:1.000] forState:UIControlStateNormal];
        [btnMap setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btnMap setBackgroundImage:[UIImage imageNamed:@"btn_common_white"] forState:UIControlStateNormal];
        [btnMap setBackgroundImage:[UIImage imageNamed:@"btn_common"] forState:UIControlStateSelected];
        [btnMap setTitle:@"地图版" forState:UIControlStateNormal];
        btnMap.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        btnMap.tag = kMapTag;
        [btnMap addTarget:self action:@selector(clickSwich:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btnMap];
        
        [self clickSwich:btnList];
    } else {
        [PMCommon setNavigationTitle:self withTitle:@"我的驾校"];
    }
}

- (void)loadMapView {
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - NavBarHeight - StatusBarHeight)];
    [_mapView setMapType:BMKMapTypeStandard];
    _mapView.showsUserLocation = YES;
    _mapView.zoomEnabled= YES;
    _mapView.scrollEnabled = YES;
    _mapView.zoomLevel = 15;
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
    }
}

- (void)clickSearch {
    
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shopViewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopCell *cell
    = [tableView dequeueReusableCellWithIdentifier:@"ShopCell" forIndexPath:indexPath];
    [cell refreshCellWithInfo:_shopViewModel.dataSource[indexPath.row]];
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
            ShopInfo *info = _shopViewModel.dataSource[indexPath.row];
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
    ShopAnnotation *annotatiion = (ShopAnnotation *)view.annotation;
    [self performSegueWithIdentifier:@"SchoolDetail" sender:annotatiion.shopInfo];
}

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
    switch (column) {
        case 0: {
            if (row == 0) {
                _filterInfo.cityId = @"";
            } else {
                AddressModel *addressInfo = [AddressViewModel sharedAddressViewModel].arrayDataSource[row - 1];
                _filterInfo.cityId = [NSString stringWithFormat:@"%ld", (long)addressInfo.c_id];
            }
        }
            break;
        case 1: {
            
        }
            break;
        case 2: {
            NSString *string = _priceList[row];
            if ([string rangeOfString:@"-"].location != NSNotFound) {
                NSArray *array = [string componentsSeparatedByString:@"-"];
                NSString *first = array.firstObject;
                NSString *last = array.lastObject;
                _filterInfo.startPrice = first.floatValue;
                _filterInfo.endPrice = last.floatValue;
            } else {
                if ([string isEqualToString:@"价格"]) {
                    _filterInfo.startPrice = 0;
                    _filterInfo.endPrice = 100000;
                } else {
                    _filterInfo.startPrice = 8000;
                    _filterInfo.endPrice = 100000;
                }
            }
        }
            break;
        case 3: {
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
    [[AddressViewModel sharedAddressViewModel] getAddressDicFromServer:self callBack:^(BOOL success) {
        if (success) {
            // 初始化筛选条件
            _filterInfo = [[FilterInfo alloc] init];
            _filterInfo.cityId = @"";
            _filterInfo.toDate = @"asc";
            _filterInfo.startPrice = 0;
            _filterInfo.endPrice = 100000;
            
            NSMutableArray *cityList = [[NSMutableArray alloc] init];
            [cityList addObject:@"所有城市"];
            
            NSInteger citySelectRow = 0;// 默认0
            
            for (NSInteger i = 0; i < [AddressViewModel sharedAddressViewModel].arrayDataSource.count; i++) {
                AddressModel *model = [AddressViewModel sharedAddressViewModel].arrayDataSource[i];
                if ([LocationManager sharedLocationManager].addressInfo &&
                    model.c_id == [LocationManager sharedLocationManager].addressInfo.c_id) {
                    _filterInfo.cityId = [NSString stringWithFormat:@"%ld", (long)model.c_id];
                    // 因为手动加入一个在最前面，所以需要+1
                    citySelectRow = i + 1;
                }
                
                [cityList addObject:model.c_name];
            }
            
            _priceList = @[@"价格", @"0-2000", @"2000-4000", @"4000-6000", @"6000-8000", @"8000以上"];
            _dataMenu = @[cityList, @[@"综合排序", @"由近到远"], _priceList, @[@"评分", @"由低到高", @"由高到低"]];
            
            _pullDownMenu = [[MXPullDownMenu alloc] initWithArray:_dataMenu selectedColor:[UIColor colorWithRed:0.180 green:0.635 blue:0.353 alpha:1.000]];
            _pullDownMenu.delegate = self;
            _pullDownMenu.frame = CGRectMake(0, 64, ScreenWidth, 45);
            [_pullDownMenu setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.view addSubview:_pullDownMenu];
            
            [_pullDownMenu setSelectRow:citySelectRow];
        }
    }];
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
            info.driving_comm_num = schoolInfo.drivingCommNum;
            info.resource_url = schoolInfo.resourseUrl;
            info.scole = schoolInfo.scole;
         
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
