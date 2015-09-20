//
//  SyncProcessCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/20.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import "SyncProcessCell.h"

@interface SyncProcessCell () {
    
    __weak IBOutlet UILabel *_lblTitle;
    __weak IBOutlet UIButton *_btnProgress;
}

@end

@implementation SyncProcessCell

- (void)awakeFromNib {
    // Initialization code
    [_btnProgress setBackgroundImage:[[UIImage imageNamed:@"personal_sync_progress_btn"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_btnProgress setBackgroundImage:[[UIImage imageNamed:@"personal_sync_progress_btn_select"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateSelected];
    
    [_btnProgress setTitleColor:RGBA(0x8a, 0x8a, 0x8a, 1) forState:UIControlStateNormal];
    [_btnProgress setTitleColor:RGBA(0x56, 0xab, 0xe4, 1) forState:UIControlStateNormal];
    
    _btnProgress.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
