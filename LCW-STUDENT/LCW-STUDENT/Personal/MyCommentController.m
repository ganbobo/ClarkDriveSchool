//
//  MyCommentController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/20.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "MyCommentController.h"

#import "MyCommentCell.h"

@interface MyCommentController ()<UITableViewDataSource, UITabBarDelegate> {
    
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation MyCommentController

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
    [PMCommon setNavigationTitle:self withTitle:@"我的评价"];
}

#pragma - mark UITableViewDataSource, UITableViewDelegate 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCommentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
