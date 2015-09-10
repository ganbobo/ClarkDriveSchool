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

@interface SchoolDetailController ()<UITableViewDataSource, UITableViewDelegate, SchoolInfoViewDelegate> {
    NSMutableArray *_dataSource;
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIView *_headerView;
    HFStretchableTableHeaderView *_stretchView;
    // 介绍
    SchoolInfoView *_infoView;
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
        
    }
}

@end
