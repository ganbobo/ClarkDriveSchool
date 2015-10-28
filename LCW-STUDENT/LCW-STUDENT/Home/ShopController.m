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

#define kListTag  100001
#define kMapTag   100002

@interface ShopController ()<UITableViewDataSource, UITableViewDelegate, MXPullDownMenuDelegate> {
    @private
    UIView *_titleView;
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_dataMenu;
    MXPullDownMenu *_pullDownMenu;
    
    // 数据管理
    ShopViewModel *_shopViewModel;
}

@end

@implementation ShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _shopViewModel = [[ShopViewModel alloc] init];
    [self loadNav];
    [self loadPullDownMenuView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma - mark 界面加载

- (void)loadNav {
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
}

- (void)loadPullDownMenuView {
    _dataMenu = @[ @[ @"广德", @"泾县", @"宣州区"], @[@"综合排序", @"由近到远"], @[@"价格", @"由低到高", @"由高到低"], @[@"评分", @"由低到高", @"由高到低"]];
    
    
    _pullDownMenu = [[MXPullDownMenu alloc] initWithArray:_dataMenu selectedColor:[UIColor colorWithRed:0.180 green:0.635 blue:0.353 alpha:1.000]];
    _pullDownMenu.delegate = self;
    _pullDownMenu.frame = CGRectMake(0, 64, ScreenWidth, 45);
    [_pullDownMenu setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_pullDownMenu];
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
    }
    
    // 点选地图
    if (button.tag == kMapTag) {
        btnList.selected = NO;
        btnList.userInteractionEnabled = YES;
        btnMap.selected = YES;
        btnMap.userInteractionEnabled = NO;
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
        controller.hasSignUp = _hasSignUp;
    }
}

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row {
    NSLog(@"%ld -- %ld", column, row);
}

#pragma - mark 获取数据

- (void)getDataFromServer {
    [_shopViewModel getShopListFromServer:@"123" controller:self callBack:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
        }
    }];
}

@end
