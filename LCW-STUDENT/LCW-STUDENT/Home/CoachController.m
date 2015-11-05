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
#import "CoachViewModel.h"

#import "CoachDetailController.h"

@implementation CoachFilterInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = @"";
        _sex = @"";
        _desc = @"ASC";
    }
    return self;
}

@end

@interface CoachController ()<UITableViewDataSource, UITableViewDelegate, MXPullDownMenuDelegate> {
    
    @private
    __weak IBOutlet UITableView *_tableView;
    UITextField *_searchField;
    
    NSArray *_dataMenu;
    MXPullDownMenu *_pullDownMenu;
    
    // 数据
    CoachViewModel *_coachViewModel;
    CoachFilterInfo *_filterInfo;
}

@end

@implementation CoachController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 发送请求
    [self getCoachList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _coachViewModel = [[CoachViewModel alloc] init];
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
    _dataMenu = @[@[@"类型", @"C1", @"C2"], @[@"性别", @"男教练", @"女教练"], @[@"筛选", @"剩余学员由多到少"]];
    _filterInfo = [[CoachFilterInfo alloc] init];
    
    
    _pullDownMenu = [[MXPullDownMenu alloc] initWithArray:_dataMenu selectedColor:[UIColor colorWithRed:0.180 green:0.635 blue:0.353 alpha:1.000]];
    _pullDownMenu.delegate = self;
    _pullDownMenu.frame = CGRectMake(0, 64, ScreenWidth, 45);
    [_pullDownMenu setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_pullDownMenu];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _coachViewModel.coachList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kCoachCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CoachCell" forIndexPath:indexPath];
    [cell refreshCellByInfo:_coachViewModel.coachList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"CoachDetail" sender:indexPath];
}

#pragma - mark 界面跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CoachDetail"]) {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        CoachModel *info = _coachViewModel.coachList[indexPath.row];
        CoachDetailController *controller = [segue destinationViewController];
        controller.coachInfo = info;
        controller.subjectInfo = _subjectInfo;
    }
}

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
    switch (column) {
        case 0: { // 驾照类型
            switch (row) {
                case 0:
                    _filterInfo.type = @"";
                    break;
                case 1:
                    _filterInfo.type = @"C1";
                    break;
                case 2:
                    _filterInfo.type = @"C2";
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: { // 性别
            switch (row) {
                case 0:
                    _filterInfo.sex = @"";
                    break;
                case 1:
                    _filterInfo.sex = @"1";
                    break;
                case 2:
                    _filterInfo.sex = @"0";
                    break;
                default:
                    break;
            }
        }
            break;
        case 2: { // 剩余人数
            switch (row) {
                case 0:
                    _filterInfo.desc = @"ASC";
                    break;
                    
                default:
                    _filterInfo.desc = @"DESC";
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    [self getCoachList];
}

#pragma - mark 获取数据

- (void)getCoachList {
    __weak typeof(self) safeSelf = self;
    
    [self showLoading:^{
        [safeSelf getCoachList];
    }];
    
    [self getCoachListFromServer];
}

- (void)getCoachListFromServer {
    [_coachViewModel getCoachListFromServer:_subjectInfo.id sex:_filterInfo.sex typeName:_filterInfo.type overplusTrainee:_filterInfo.desc controller:self callBack:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
        }
    }];
}

@end
