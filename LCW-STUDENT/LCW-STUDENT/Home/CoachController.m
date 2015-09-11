//
//  CoachController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/9.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CoachController.h"

#import "CoachCell.h"
#import "MXPullDownMenu.h"

@interface CoachController ()<UITableViewDataSource, UITableViewDelegate, MXPullDownMenuDelegate> {
    
    @private
    __weak IBOutlet UITableView *_tableView;
    UITextField *_searchField;
    
    NSArray *_dataMenu;
    MXPullDownMenu *_pullDownMenu;
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
    [self loadPullDownMenuView];
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

- (void)loadPullDownMenuView {
    _dataMenu = @[ @[ @"广德", @"泾县", @"宣州区"], @[@"综合排序", @"由近到远"], @[@"价格", @"由低到高", @"由高到低"], @[@"筛选", @"全部", @"男教练", @"女教练", @"剩余名额教练"]];
    
    
    _pullDownMenu = [[MXPullDownMenu alloc] initWithArray:_dataMenu selectedColor:[UIColor colorWithRed:0.180 green:0.635 blue:0.353 alpha:1.000]];
    _pullDownMenu.delegate = self;
    _pullDownMenu.frame = CGRectMake(0, 64, ScreenWidth, 45);
    [_pullDownMenu setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_pullDownMenu];
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

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
    NSLog(@"%ld -- %ld", column, row);
}

@end
