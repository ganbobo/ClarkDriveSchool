//
//  CarOrderCell.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/11.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "CarOrderCell.h"

@interface CarOrderCell () {
    
    __weak IBOutlet UIButton *_btnOne;
    __weak IBOutlet UIButton *_btnTwo;
    __weak IBOutlet UIButton *_btnThree;
}

@end

@implementation CarOrderCell

- (void)awakeFromNib {
    // Initialization code
    [_btnOne setBackgroundImage:[[UIImage imageNamed:@"car_order_normal"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [_btnTwo setBackgroundImage:[[UIImage imageNamed:@"car_order_select"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [_btnThree setBackgroundImage:[[UIImage imageNamed:@"car_order_full"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    
    [self.contentView bringSubviewToFront:_btnTwo];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshWithIndex:(NSInteger)index {
    for (NSLayoutConstraint* constraint in self.contentView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeTop) {
            if (index == 0) {
                constraint.constant = 0;
            } else {
                constraint.constant = -1;
            }
        }
    }
}

@end
