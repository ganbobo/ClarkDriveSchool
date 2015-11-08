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

@interface CarOrderController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout> {
    
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
}

@end

@implementation CarOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取数据
    [self getSubjectFromServer];
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
    _dayView = [[UIView alloc] initWithFrame:CGRectMake(5, kSelectViewHeight + 10, ScreenWidth - 10, 50)];
    _dayView.backgroundColor = [UIColor whiteColor];
    [_titleVIew addSubview:_dayView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarOrderCollectionViewCell *cell =
    (CarOrderCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CarOrderCollectionViewCell"
                                                                     forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = (CarOrderFooterReusableView*)[collectionView
                                                     dequeueReusableSupplementaryViewOfKind:kind
                                                     withReuseIdentifier:@"FooterView"
                                                     forIndexPath:indexPath];
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
    
    [self getTimeFromServer];
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
//    [list removeLastObject];
//    [list removeLastObject];
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
