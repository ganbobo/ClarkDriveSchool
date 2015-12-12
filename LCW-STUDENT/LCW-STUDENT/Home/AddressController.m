//
//  AddressController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/6.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "AddressController.h"

#import "AddressViewModel.h"
#import "AddressModel.h"
#import "LocationManager.h"

@interface AddressController ()<UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate> {
    
    __weak IBOutlet UISearchBar *_searchBar;
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_filterData;
    
    // 数据
    AddressViewModel *_addressViewModel;
}

@end

@implementation AddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTintColor:RGBA(0x11, 0xcd, 0x6e, 1)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _filterData = [[NSMutableArray alloc] init];;
    _addressViewModel = [AddressViewModel sharedAddressViewModel];
    [self loadNav];
    
    [self getAddressList];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationBarLeftButton:self withBtnNormalImg:[UIImage imageNamed:@"nav_close"] withAction:@selector(clickClose)];
}

#pragma - mark 导航按钮点击触发

- (void)clickClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma - mark UISearchDisplayDelegate 代理

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    [_searchBar setShowsCancelButton:YES animated:NO];
    UIView *topView = controller.searchBar.subviews[0];
    
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *cancelButton = (UIButton*)subView;
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];  //@"取消"
        }
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@", _searchBar.text];
    _filterData =  [[NSArray alloc] initWithArray:[_addressViewModel.arrayDataSource filteredArrayUsingPredicate:predicate]];
    [controller.searchResultsTableView reloadData];
    
    if ([_filterData count] == 0) {
        UITableView *tableView1 = self.searchDisplayController.searchResultsTableView;
        for(UIView *subview in tableView1.subviews ) {
            if([subview class] == [UILabel class]) {
                UILabel *lbl = (UILabel*)subview; // sv changed to subview.
                lbl.text = @"没有结果";
            }
        }
    }
    
    return YES;
}

#pragma - mark UITableViewDelegate, UITableViewDataSource 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_tableView isEqual:tableView]) {
        return _addressViewModel.wordSortArray.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        NSString *key = _addressViewModel.wordSortArray[section];
        NSArray *list = _addressViewModel.addressDic[key];
        return list.count;
    }else{
        return _filterData.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:_tableView]) {
        NSString *key = _addressViewModel.wordSortArray[section];
        if ([key isEqualToString:@"#"]) {
            return @"定位城市";
        }
        return key;
    }
    return @"";
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([_tableView isEqual:tableView]) {
        return _addressViewModel.wordSortArray;
    }
    
    return @[];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"AddressCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.textColor = RGBA(0x66, 0x66, 0x66, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if ([tableView isEqual:_tableView]) {
        NSString *key = _addressViewModel.wordSortArray[indexPath.section];
        NSArray *list = _addressViewModel.addressDic[key];
        AddressModel *model = list[indexPath.row];
        cell.textLabel.text = model.c_name;
    }else{
        cell.textLabel.text = _filterData[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.title = cell.textLabel.text;
    
    if ([cell.textLabel.text isEqualToString:@"定位失败"]) {
        [[LocationManager sharedLocationManager] startLocation:^(NSString *city) {
            NSString *key = _addressViewModel.wordSortArray[indexPath.section];
            NSArray *list = _addressViewModel.addressDic[key];
            AddressModel *model = list[indexPath.row];
            model.c_name = city;
            [_tableView reloadData];
        }];
        
        return;
    }
    
    NSString *key = _addressViewModel.wordSortArray[indexPath.section];
    NSArray *list = _addressViewModel.addressDic[key];
    AddressModel *model = list[indexPath.row];
    [LocationManager sharedLocationManager].addressInfo = model;
    
    [self clickClose];
}

#pragma - mark 获取城市数据


- (void)getAddressList {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getAddressList];
    }];
    
    [self getAddressDataFromServer];
}

- (void)getAddressDataFromServer {
    [_addressViewModel getAddressDicFromServer:self callBack:^(BOOL success) {
        [_tableView reloadData];
    }];
}

@end
