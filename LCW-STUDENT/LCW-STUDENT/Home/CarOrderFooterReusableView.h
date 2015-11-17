//
//  CarOrderFooterReusableView.h
//  LCW-STUDENT
//
//  Created by Clark.Gan on 15/11/6.
//  Copyright © 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarOrderFooterReusableViewDelegate <NSObject>

- (void)didClickSubmit;

@end

@interface CarOrderFooterReusableView : UICollectionReusableView

@property(nonatomic, assign)id<CarOrderFooterReusableViewDelegate> delegate;

@end
