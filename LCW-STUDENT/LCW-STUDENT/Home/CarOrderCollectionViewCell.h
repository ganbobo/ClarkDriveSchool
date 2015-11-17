//
//  CarOrderCollectionViewCell.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/6.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CarOrderController.h"

@interface CarOrderCollectionViewCell : UICollectionViewCell

- (void)refreshCellByInfo:(CarOrderInfo *)info;

@end
