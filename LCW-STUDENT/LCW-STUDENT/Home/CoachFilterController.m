//
//  CoachFilterController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CoachFilterController.h"

@interface CoachFilterController () {
    
    __weak IBOutlet UIButton *_btnCourseTwo;
    __weak IBOutlet UIButton *_btnCourseThree;
}

@end

@implementation CoachFilterController

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
    [self loadBtns];
}

#pragma - mark 加载界面

- (void)loadNav {
    [PMCommon setNavigationTitle:self withTitle:@"筛选"];
}

- (void)loadBtns {
    _btnCourseTwo.layer.cornerRadius = 2;
    _btnCourseTwo.layer.masksToBounds = YES;
    _btnCourseTwo.layer.borderWidth = 0.5;
    [_btnCourseTwo setTitleColor:[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000] forState:UIControlStateNormal];
    _btnCourseTwo.layer.borderColor =[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000].CGColor;
    
    _btnCourseThree.layer.cornerRadius = 2;
    _btnCourseThree.layer.masksToBounds = YES;
    _btnCourseThree.layer.borderWidth = 0.5;
    [_btnCourseThree setTitleColor:[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000] forState:UIControlStateNormal];
    _btnCourseThree.layer.borderColor =[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000].CGColor;
}

#pragma - mark 点击事件

- (IBAction)clickCourseTwo:(id)sender {
    [self performSegueWithIdentifier:@"CoachSelect" sender:nil];
}
- (IBAction)clickCourseThree:(id)sender {
    [self performSegueWithIdentifier:@"CoachSelect" sender:nil];
}

@end
