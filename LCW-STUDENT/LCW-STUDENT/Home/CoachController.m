//
//  CoachController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/9.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CoachController.h"

#import "CoachCell.h"

@interface CoachController ()<UITableViewDataSource, UITableViewDelegate> {
    
    __weak IBOutlet UITableView *_tableView;
    
    UITextField *_searchField;
}

@end

@implementation CoachController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 80, 30)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 2;
    self.navigationItem.titleView = searchView;
    
    UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, (searchView.height - 15) / 2.0, 15, 15)];
    searchIcon.image = [UIImage imageNamed:@"coach_search"];
    [searchView addSubview:searchIcon];
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(searchIcon.frame) + 5, 0, searchView.width - CGRectGetMaxX(searchIcon.frame) - 10, searchView.height)];
    _searchField.enablesReturnKeyAutomatically = YES;
    _searchField.returnKeyType = UIReturnKeySearch;
    _searchField.font = [UIFont systemFontOfSize:14];
    _searchField.placeholder = @"请输入教练姓名或姓";
    [searchView addSubview:_searchField];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kCoachCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoachCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
