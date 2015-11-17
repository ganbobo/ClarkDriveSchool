//
//  CarOrderController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CarOrderController.h"

#import "CarOrderViewModel.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CarOrderCollectionViewCell.h"
#import "CarOrderFooterReusableView.h"
#import "CarOrderBtn.h"
#import "SubjectInfo.h"
#import "CarCoachInfo.h"
#import "CarOrderDayBtn.h"

#define kBtnDayBaseTag 10000
#define kSelectViewHeight  50

@implementation CarOrderInfo

@end

@interface CarOrderController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, CarOrderFooterReusableViewDelegate> {
    
    @private
    __weak IBOutlet UICollectionView *_collectionView;
    
    UIButton *_btnSubjectTwo, *_btnSubjectThree;
    CHTCollectionViewWaterfallLayout *_layout;
    UIView *_titleVIew;
    UIView *_dayView;
    UIView *_selectView;
    
    CarCoachInfo *_coachInfo;
    // 数据
    CarOrderViewModel *_carOrderViewModel;
    
    NSMutableArray *_dataSource;
    
    // 时间
    long _publishedTime;
    SubjectInfo *_currentSubject;
}

@end

@implementation CarOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取数据
    [self getTimeFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _dataSource = [[NSMutableArray alloc] init];
    _carOrderViewModel = [[CarOrderViewModel alloc] init];
    [self loadData];
    [self loadNav];
    [self loadCollectionView];
    [self loadSwichView];
    [self loadDayView];
}

#pragma - mark 加载数据

- (void)loadData {
    CarOrderInfo *info0 = [[CarOrderInfo alloc] init];
    info0.titleName = @"08:00-09:00";
    info0.select = NO;
    info0.type = 0;
    [_dataSource addObject:info0];
    
    CarOrderInfo *info1 = [[CarOrderInfo alloc] init];
    info1.titleName = @"09:00-10:00";
    info1.select = NO;
    info1.type = 0;
    [_dataSource addObject:info1];
    
    CarOrderInfo *info2 = [[CarOrderInfo alloc] init];
    info2.titleName = @"10:00-11:00";
    info2.select = NO;
    info2.type = 0;
    [_dataSource addObject:info2];
    
    CarOrderInfo *info = [[CarOrderInfo alloc] init];
    info.titleName = @"10:00-11:00";
    info.select = NO;
    info.type = 0;
    [_dataSource addObject:info];
    
    CarOrderInfo *info3 = [[CarOrderInfo alloc] init];
    info3.titleName = @"13:00-14:00";
    info3.select = NO;
    info3.type = 0;
    [_dataSource addObject:info3];
    
    CarOrderInfo *info4 = [[CarOrderInfo alloc] init];
    info4.titleName = @"14:00-15:00";
    info4.select = NO;
    info4.type = 0;
    [_dataSource addObject:info4];
    
    CarOrderInfo *info5 = [[CarOrderInfo alloc] init];
    info5.titleName = @"15:00-16:00";
    info5.select = NO;
    info5.type = 0;
    [_dataSource addObject:info5];
    
    CarOrderInfo *info6 = [[CarOrderInfo alloc] init];
    info6.titleName = @"16:00-17:00";
    info6.select = NO;
    info6.type = 0;
    [_dataSource addObject:info6];
    
    CarOrderInfo *info7 = [[CarOrderInfo alloc] init];
    info7.titleName = @"17:00-18:00";
    info7.select = NO;
    info7.type = 0;
    [_dataSource addObject:info7];
    
    CarOrderInfo *info8 = [[CarOrderInfo alloc] init];
    info8.titleName = @"18:00-19:00";
    info8.select = NO;
    info8.type = 0;
    [_dataSource addObject:info8];
    
    CarOrderInfo *info9 = [[CarOrderInfo alloc] init];
    info9.titleName = @"19:00-20:00";
    info9.select = NO;
    info9.type = 0;
    [_dataSource addObject:info9];
    
    CarOrderInfo *info10 = [[CarOrderInfo alloc] init];
    info10.titleName = @"20:00-21:00";
    info10.select = NO;
    info10.type = 0;
    [_dataSource addObject:info9];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"一键约车"];
    [PMCommon setNavigationRight:self title:@"处罚" action:@selector(clickRules)];
}

- (void)loadCollectionView {
    
    _layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    _layout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    _layout.headerHeight = 0;
    _layout.footerHeight = 100;
    _layout.minimumColumnSpacing = 1;
    _layout.minimumInteritemSpacing = 1.5;
    _layout.columnCount = 3;

    [_collectionView setCollectionViewLayout:_layout];
    
     [_collectionView registerClass:[CarOrderFooterReusableView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    
    UIEdgeInsets edge = _collectionView.contentInset;
    edge.top = kSelectViewHeight * 2 + 20;
    _collectionView.contentInset = edge;
}

- (void)loadSwichView {
    _titleVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, kSelectViewHeight * 2 + 10)];
    _titleVIew.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_titleVIew];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, _titleVIew.height - 0.5, ScreenWidth - 10, 0.5)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_titleVIew addSubview:line];
    
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kSelectViewHeight)];
    _selectView.backgroundColor = [UIColor whiteColor];
    [_titleVIew addSubview:_selectView];
}

- (void)loadDayView {
    _dayView = [[UIView alloc] initWithFrame:CGRectMake(5, kSelectViewHeight + 10, ScreenWidth - 10, 50)];
    _dayView.backgroundColor = [UIColor whiteColor];
    [_titleVIew addSubview:_dayView];
}


#pragma - mark CarOrderFooterReusableViewDelegate

- (void)didClickSubmit {
    if (_coachInfo) {
        if (![_currentSubject.subject_name isEqualToString:_coachInfo.subjectName]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请对当前科目教练进行评价，确保关闭当前科目后，在进行约车" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    NSString *str = @"";
    for (CarOrderInfo *info in _dataSource) {
        if (info.select) {
            if ([str isEqualToString:@""]) {
                str = [NSString stringWithFormat:@"%@", info.titleName];
            } else {
                str = [NSString stringWithFormat:@"%@,%@", str,info.titleName];
            }
        }
    }
    
//    [_carOrderViewModel sendOrderCar:str publishTime:_publishedTime controller:self callBack:^(BOOL success) {
//        
//    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarOrderCollectionViewCell *cell =
    (CarOrderCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CarOrderCollectionViewCell"
                                                                     forIndexPath:indexPath];
    
    [cell refreshCellByInfo:_dataSource[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CarOrderInfo *info = _dataSource[indexPath.row];
    if (info.select) {
        info.select = NO;
    } else {
        NSInteger i = 0;
        
        for (CarOrderInfo *info in _dataSource) {
            if (info.select) {
                i += 1;
            }
        }
        
        if (i >= 2) {
            [self showMiddleToastWithContent:@"最多只能预约2s个小时的课程"];
            return;
        }
        info.select = YES;
    }
    
    [_collectionView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CarOrderFooterReusableView *reusableView = nil;
    if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = (CarOrderFooterReusableView*)[collectionView
                                                     dequeueReusableSupplementaryViewOfKind:kind
                                                     withReuseIdentifier:@"FooterView"
                                                     forIndexPath:indexPath];
        reusableView.delegate = self;
    }
    
    return reusableView;
}




#pragma - mark CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(1.5, 1);
}

#pragma - mark 点击日期

- (void)clickViewDayBtn:(CarOrderDayBtn *)btn {
    for (UIView *view in _dayView.subviews) {
        if ([view isKindOfClass:[CarOrderDayBtn class]]) {
            CarOrderDayBtn *button = (CarOrderDayBtn *)view;
            button.selected = NO;
        }
    }
    
    btn.selected = YES;
    _publishedTime = btn.time;
    [self getCourseFromServer:btn.time];
}

- (void)clickRules {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"约车违约处罚" message:@"* 1个月没约车权限：爽约或开练前2小时取消约车学员；\n* 15天没约车权限：开练前2-8小时取消约车学员；\n* 7天没约车权限：开练前8-24小时取消约车学员；\n* 无限制：开练前24小时取消约车及上课学员；" delegate:nil cancelButtonTitle:@"明白了" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)clickSubject:(CarOrderBtn *)btn {
    for (UIView *view in _selectView.subviews) {
        if ([view isKindOfClass:[CarOrderBtn class]]) {
            CarOrderBtn *button = (CarOrderBtn *)view;
            button.selected = NO;
        }
    }
    
    
    
    btn.selected = YES;
    
    
    _currentSubject = btn.subjectInfo;
    
    if (_coachInfo) {
        if (![btn.subjectInfo.subject_name isEqualToString:_coachInfo.subjectName]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请对当前科目教练进行评价，确保关闭当前科目后，在进行其他科目的约车" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
}

#pragma - mark 获取科目
// 获取科目
- (void)getSubjectFromServer {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getSubjectFromServer];
    }];
    [_carOrderViewModel getSubjectListFromServer:getUser().id controller:self callBack:^(BOOL success) {
        if (success) {
            [self loadSelectBtnView:_carOrderViewModel.dataSource];
        }
    }];
}

// 获取时间
- (void)getTimeFromServer {
    [_carOrderViewModel getTimeListFromServerController:self callBack:^(BOOL success) {
        if (success) {
            for (CarCoachInfo *info in _carOrderViewModel.coachList) {
                if ([info.subjectName isEqualToString:@"科目三"]) {
                    _coachInfo = info;
                    [PMCommon setNavigationTitle:self withTitle:[NSString stringWithFormat:@"教练-%@(%@)", info.cnName, info.subjectName]];
                    break;
                } else {
                    _coachInfo = info;
                    [PMCommon setNavigationTitle:self withTitle:[NSString stringWithFormat:@"教练-%@(%@)", info.cnName, info.subjectName]];
                }
            }
            
            // 先设置教练信息在获取课程
            [self loadDayView:_carOrderViewModel.timeList];
            
            [self getSubjectFromServer];
        }
    }];
}

// 获取课程
- (void)getCourseFromServer:(long)publishTime {
    [_carOrderViewModel getCourseListFromServer:_coachInfo.trainerId publishTime:publishTime controller:self callBack:^(BOOL success) {
        
    }];
}

#pragma - mark 生成顶部科目切换按钮

- (void)loadSelectBtnView:(NSArray *)list {
    for (UIView *view in _selectView.subviews) {
        [view removeFromSuperview];
    }
    
    for (NSInteger i = 0; i < list.count; i ++) {
        CarOrderBtn *btn = [[CarOrderBtn alloc] initWithFrame:CGRectMake(i * (ScreenWidth / list.count), 0, ScreenWidth / list.count, _selectView.height)];
        btn.subjectInfo = list[i];
        [_selectView addSubview:btn];
        [btn addTarget:self action:@selector(clickSubject:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        
        if (i < list.count - 1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 10, 0.5, btn.height - 20)];
            line.backgroundColor = RGBA(0xcc, 0xcc, 0xcc, 1);
            [_selectView addSubview:line];
        }
    }
    CarOrderBtn *btn = [(CarOrderBtn *)_selectView viewWithTag:1000];
    [self clickSubject:btn];
}

- (void)loadDayView:(NSMutableArray *)list {
    for (UIView *view in _dayView.subviews) {
        [view removeFromSuperview];
    }
    
    for (NSInteger i = 0; i < list.count; i ++) {
        CarOrderDayBtn *btn = [[CarOrderDayBtn alloc] initWithFrame:CGRectMake(i * (_dayView.width / list.count), 0, _dayView.width / list.count, _dayView.height + 3)];
        
        [_dayView addSubview:btn];
        [btn addTarget:self action:@selector(clickViewDayBtn:) forControlEvents:UIControlEventTouchUpInside];
        NSNumber *number = list[i];
        btn.time = number.longValue;
        btn.tag = 1000 + i;
        
        if (i < list.count - 1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 0, 0.5, _dayView.height)];
            line.backgroundColor = RGBA(0xcc, 0xcc, 0xcc, 1);
            [_dayView addSubview:line];
        }
    }
    CarOrderDayBtn *btn = [(CarOrderDayBtn *)_dayView viewWithTag:1000];
    [self clickViewDayBtn:btn];
}

@end
