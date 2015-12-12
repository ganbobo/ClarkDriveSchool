//
//  SearchView.m
//  V2gogo
//
//  Created by ClarkGan on 15/7/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "SearchView.h"

#import "TableViewCell.h"
#define kNavViewHeight   64

@interface SearchView()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    UIView *_navView;
    UITextField *_searchField;
    UIView *_searchView, *_searchBackView;
    UIButton *_btnCancel;
    UITableView *_tableView;

    
    NSMutableArray *_dataSource;
    
    UIView *_backView;
    UILabel *_lblNoData;
    
    UIView *_loadView;
    UIActivityIndicatorView *_activityIndicator;
}

@end

@implementation SearchView

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor clearColor];
        [self initBackView];
        [self initSearchField];
        [self loadCollectionView];
        [self initNoDataView];
        [self initLoadingView];
        [self initSearchBackView];
    }
    return self;
}

- (void)initBackView {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _backView.backgroundColor = RGBA(0x00, 0x00, 0x00, 0);
    [self addSubview:_backView];
}

- (void)initSearchField {
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, -kNavViewHeight, ScreenWidth, kNavViewHeight)];
    _navView.backgroundColor = RGBA(0x40, 0x40, 0x40, 1);
    [self addSubview:_navView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNavViewHeight - 0.5, ScreenWidth, 0.5)];
    line.backgroundColor = RGBA(0xcc, 0xcc, 0xcc, 1);
    [_navView addSubview:line];
    
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(5, _navView.height - 7 - 30, ScreenWidth - 10 - 50, 30)];
    _searchView.backgroundColor = [UIColor whiteColor];
    _searchView.layer.borderColor = RGBA(0xcc, 0xcc, 0xcc, 1).CGColor;
    _searchView.layer.borderWidth = 0.5;
    _searchView.layer.masksToBounds = YES;
    _searchView.layer.cornerRadius = 3;
    [_navView addSubview:_searchView];
    
    _btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchView.frame) + 5, _navView.height - 7 - 30, 45, 30)];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    _btnCancel.titleLabel.font = [UIFont systemFontOfSize:16];
    [_btnCancel setTitleColor:RGBA(0xff, 0xff, 0xff, 1) forState:UIControlStateNormal];
    [_btnCancel setTitleColor:RGBA(0xee, 0xee, 0xee, 1) forState:UIControlStateHighlighted];
    [_btnCancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_btnCancel];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(7.5, (_searchView.height - 15) / 2.0, 15, 15)];
    imgView.image = [UIImage imageNamed:@"photo_search_logo"];
    [_searchView addSubview:imgView];
    
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 5, 0, _searchView.width - CGRectGetMaxX(imgView.frame) - 5, _searchView.height)];
    _searchField.font = [UIFont systemFontOfSize:14];
    _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchField.placeholder = @"输入驾校名称";
    _searchField.delegate = self;
    _searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _searchField.returnKeyType = UIReturnKeySearch;
    if (IOS7) {
        _searchField.tintColor = RGBA(0x40, 0x40, 0x40, 1);
    }
    
    _searchField.enablesReturnKeyAutomatically = YES;
    _searchField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_searchView addSubview:_searchField];
}


- (void)loadCollectionView {
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavViewHeight, ScreenWidth, ScreenHeight - kNavViewHeight)];
    _tableView.backgroundColor = RGBA(0xee, 0xee, 0xee, 0);
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.alwaysBounceVertical = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollsToTop = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
}

- (void)initNoDataView {
    _lblNoData = [[UILabel alloc] initWithFrame:_backView.frame];
    _lblNoData.backgroundColor = [UIColor clearColor];
    _lblNoData.textColor = RGBA(0x69, 0x69, 0x69, 1);
    _lblNoData.font = [UIFont systemFontOfSize:16];
    _lblNoData.text = @"没有找到到你搜索的信息\n\n";
    _lblNoData.numberOfLines = 0;
    _lblNoData.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lblNoData];
    
    _lblNoData.hidden = YES;
    [self bringSubviewToFront:_navView];
}

- (void)initLoadingView {
    _loadView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavViewHeight, ScreenWidth, 300)];
    _loadView.backgroundColor = [UIColor clearColor];
    [self addSubview:_loadView];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.color = RGBA(0xf5, 0x50, 0x00, 1);
    
    _activityIndicator.center = CGPointMake(_loadView.width / 2.0, _loadView.height / 2.0);
    [_loadView addSubview:_activityIndicator];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_activityIndicator.frame) + 5, _loadView.width, 30)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = RGBA(0x69, 0x69, 0x69, 1);
    loadingLabel.font = [UIFont systemFontOfSize:16];
    loadingLabel.text = @"正在搜索";
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    [_loadView addSubview:loadingLabel];
    _loadView.hidden = YES;
}

- (void)initSearchBackView {
    _searchBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavViewHeight, _backView.width, _backView.height - kNavViewHeight)];
    _searchBackView.backgroundColor = [UIColor clearColor];
    [self addSubview:_searchBackView];
    UIPanGestureRecognizer *swipeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInputKeyboard)];
    [_searchBackView addGestureRecognizer:swipeGesture];
}

- (void)dismissInputKeyboard {
    [_searchField resignFirstResponder];
}

- (void)startAnimation {
    _loadView.hidden = NO;
    [_activityIndicator startAnimating];
}

- (void)stopAnimation {
    _loadView.hidden = YES;
    [_activityIndicator stopAnimating];
}

#pragma - mark UISearchBarDelegate 代理

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _lblNoData.hidden = YES;
    _searchBackView.hidden = NO;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    _searchBackView.hidden = YES;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_searchField resignFirstResponder];
    [self sendSearchReqeust];
    
    return YES;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [TableViewCell getTableViewCell];
    }
    
    [cell refreshCellWithInfo:_dataSource[indexPath.row]];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismiss];
    ShopInfo *info = _dataSource[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectShopInfo:)]) {
        [_delegate didSelectShopInfo:info];
    }
}

#pragma - MARK 发送搜索请求

- (void)sendSearchReqeust {
    _searchField.text = [_searchField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self startAnimation];
    
    [_viewModel getSearchList:_searchField.text callBack:^(NSArray *dataList) {
        [self stopAnimation];
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:dataList];
        [_tableView reloadData];
        
        if (_dataSource.count == 0) {
            _lblNoData.text = @"没有找到到你搜索的信息\n\n";
            _lblNoData.hidden = NO;
        } else {
            _lblNoData.hidden = YES;
        }

    }];
}


#pragma - mark 显示
- (void)show {
    [self removeFromSuperview];
    [appDelegate.window addSubview:self];
    [_searchField becomeFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        [_navView setOrigin:CGPointMake(0, 0)];
        _backView.backgroundColor = RGBA(0xff, 0xff, 0xff, 0.9);
    }];
}

- (void)dismiss {
    [_searchField resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        [_navView setOrigin:CGPointMake(0, -kNavViewHeight)];
        self.alpha = 0;
        _backView.backgroundColor = RGBA(0xff, 0xff, 0xff, 0.0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
