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

#import "DIDatepicker.h"

@interface CarOrderController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, CarOrderFooterReusableViewDelegate> {
    
    @private
    __weak IBOutlet UICollectionView *_collectionView;
    
    UIButton *_btnSubjectTwo, *_btnSubjectThree;
    CHTCollectionViewWaterfallLayout *_layout;
    UIView *_titleVIew;
    DIDatepicker *_dayView;
    UIView *_selectView;
    
    CarCoachInfo *_coachInfo;
    // 数据
    CarOrderViewModel *_carOrderViewModel;
    
    // 时间
    long _publishedTime;
    SubjectInfo *_currentSubject;
    
    CarOrderFooterReusableView *_reusableView;
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
    _carOrderViewModel = [[CarOrderViewModel alloc] init];
    [self loadNav];
    [self loadCollectionView];
    [self loadSwichView];
    [self loadDayView];
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
    _dayView = [[DIDatepicker alloc] initWithFrame:CGRectMake(5, kSelectViewHeight + 10, ScreenWidth - 10, 50)];
    _dayView.backgroundColor = [UIColor whiteColor];
    [_titleVIew addSubview:_dayView];
    [_dayView addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
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

    NSMutableArray *list = [NSMutableArray array];
    for (CourseModel *info in _carOrderViewModel.orderCourseInfo.courseList) {
        if (info.select) {
            [list addObject:info.timePeriod];
        }
    }
    
    [_carOrderViewModel sendOrderCar:_coachInfo.trainerId timePeriod:list publishedTime:[NSString stringWithFormat:@"%ld", _publishedTime] tpye:_carOrderViewModel.orderCourseInfo.type controller:self callBack:^(BOOL success) {
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _carOrderViewModel.orderCourseInfo.courseList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarOrderCollectionViewCell *cell =
    (CarOrderCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CarOrderCollectionViewCell"
                                                                     forIndexPath:indexPath];
    CourseModel *tempModel = _carOrderViewModel.orderCourseInfo.courseList[indexPath.row];
    [cell refreshCellByInfo:tempModel];
    for (CarInfo *info in _carOrderViewModel.orderCourseInfo.trainerDayList) {
        if (info.id == tempModel.id) {
            [cell refreshCellByIsFull:info.isFull andYue:info.isYue];
            break;
        }
    }
    
    [cell refreshCellByType:_carOrderViewModel.orderCourseInfo.type];
    [self enableFooterBtn];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_carOrderViewModel.orderCourseInfo.type == 2) { // 休息不让约车
        return;
    }
    
    if (_carOrderViewModel.orderCourseInfo.type == 1 &&
        _carOrderViewModel.orderCourseInfo.jiXun == NO) {
        [self showMiddleToastWithContent:@"您不在急训学员名单中"];
        return;
    }
    
    CourseModel *info = _carOrderViewModel.orderCourseInfo.courseList[indexPath.row];
    
    for (CarInfo *tempInfo in _carOrderViewModel.orderCourseInfo.trainerDayList) {
        if (info.id == tempInfo.id) {
            if (tempInfo.isFull == 1 || tempInfo.isYue == 1) { // 已满和已约不让约车
                return;
            }
            break;
        }
    }

    
    if (info.select) {
        info.select = NO;
    } else {
        NSInteger i = 0;
        
        for (CourseModel *tempInfo in _carOrderViewModel.orderCourseInfo.courseList) {
            if (tempInfo.select) {
                i += 1;
            }
        }
        
        if (i >= 2) {
            [self showMiddleToastWithContent:@"每人每天最多只能预约2个小时的课程"];
            return;
        }
        info.select = YES;
    }
    
    [_collectionView reloadData];
    
    [self enableFooterBtn];
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
        _reusableView = reusableView;
    }
    
    return reusableView;
}




#pragma - mark CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(1.5, 1);
}

#pragma - mark 点击日期

- (void)updateSelectedDate {
    
    _publishedTime = [_dayView.selectedDate timeIntervalSince1970] * 1000;
    [self getCourseFromServer:_publishedTime];
}

- (void)clickRules {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"约车违约处罚" message:@"* 1个月没约车权限：爽约或开练前2小时取消约车学员；\n* 15天没约车权限：开练前2-8小时取消约车学员；\n* 7天没约车权限：开练前8-24小时取消约车学员；\n* 无限制：开练前24小时取消约车及上课学员；" delegate:nil cancelButtonTitle:@"明白了" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)clickSubject:(CarOrderBtn *)btn {
    if (_coachInfo) {
        if (![btn.subjectInfo.subject_name isEqualToString:_coachInfo.subjectName]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请对当前科目教练进行评价，确保关闭当前科目后，在进行其他科目的约车" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    for (UIView *view in _selectView.subviews) {
        if ([view isKindOfClass:[CarOrderBtn class]]) {
            CarOrderBtn *button = (CarOrderBtn *)view;
            button.selected = NO;
        }
    }
    
    btn.selected = YES;
    _currentSubject = btn.subjectInfo;
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
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getTimeFromServer];
    }];
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
        if (success) {
            [_collectionView reloadData];
        }
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
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < list.count; i ++) {
        NSNumber *number = list[i];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:number.longValue / 1000];
        [dates addObject:date];
    }
    
    
    [_dayView setDates:dates];
    [_dayView selectDateAtIndex:0];
}

- (void)enableFooterBtn {
    if (_carOrderViewModel.orderCourseInfo.type == 2) { // 休息
        [_reusableView enableBtnSubmit:NO];
        return;
    }
    BOOL enable = NO;
    for (CourseModel *info in _carOrderViewModel.orderCourseInfo.courseList) {
        if (info.select) {
            enable = YES;
            break;
        }
    }
    
    [_reusableView enableBtnSubmit:enable];
}

@end
