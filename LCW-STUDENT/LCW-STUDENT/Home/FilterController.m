//
//  FilterController.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/7.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "FilterController.h"

#import "ShopController.h"

@interface FilterController () {
    
    __weak IBOutlet UIButton *_btnSignUp;
    __weak IBOutlet UIButton *_btnCoach;
}

@end

@implementation FilterController

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
    _btnSignUp.layer.cornerRadius = 2;
    _btnSignUp.layer.masksToBounds = YES;
    _btnSignUp.layer.borderWidth = 0.5;
    [_btnSignUp setTitleColor:[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000] forState:UIControlStateNormal];
    _btnSignUp.layer.borderColor =[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000].CGColor;
    
    _btnCoach.layer.cornerRadius = 2;
    _btnCoach.layer.masksToBounds = YES;
    _btnCoach.layer.borderWidth = 0.5;
    [_btnCoach setTitleColor:[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000] forState:UIControlStateNormal];
    _btnCoach.layer.borderColor =[UIColor colorWithRed:0.200 green:0.635 blue:0.365 alpha:1.000].CGColor;
}

#pragma - mark 点击事件

- (IBAction)clickSignUp:(id)sender {
    [self performSegueWithIdentifier:@"Shop" sender:[NSNumber numberWithBool:NO]];
}

- (IBAction)clickCourch:(id)sender {
    [self performSegueWithIdentifier:@"Shop" sender:[NSNumber numberWithBool:YES]];
}

#pragma - mark 界面跳转

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Shop"]) {
        ShopController *controller = [segue destinationViewController];
        NSNumber *boolNumber = (NSNumber *)sender;
        controller.hasSignUp = boolNumber.boolValue;
    }
}

@end
