//
//  CommentController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/15.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CommentController.h"

#import "CommentCell.h"
#import "SchoolCommentViewModel.h"

@interface CommentController ()<UITableViewDataSource, UITabBarDelegate> {
    
    __weak IBOutlet UITableView *_tableView;
    SchoolCommentViewModel *_viewModel;
}

@end

@implementation CommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
    _viewModel = [[SchoolCommentViewModel alloc] init];
    [self loadNav];
}

#pragma - mark 加载界面

- (void)loadNav {
    if (_coachInfo) {
        [PMCommon setNavigationTitle:self withTitle:@"教练评价"];
    } else {
        [PMCommon setNavigationTitle:self withTitle:@"驾校评价"];
    }
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.commentList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [CommentCell getCellHeight:_viewModel.commentList[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell refreshCellByInfo:_viewModel.commentList[indexPath.row]];
    
    return cell;
}

#pragma - mark 获取评价列表

- (void)getData {
    __weak typeof(self) safeSelf = self;
    [self showLoading:^{
        [safeSelf getData];
    }];
    if (_shopInfo) {
        [self getDataFromServer];
    } else {
        [self getCoachCommentFromServer];
    }
    
}

- (void)getDataFromServer {
    [_viewModel getCommentListFromServer:_shopInfo.id controller:self callBack:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
        }
    }];
}

- (void)getCoachCommentFromServer {
    [_viewModel getCoachCommentListFromServer:_coachInfo.trainerId controller:self callBack:^(BOOL success) {
        if (success) {
            [_tableView reloadData];
        }
    }];
}


@end
