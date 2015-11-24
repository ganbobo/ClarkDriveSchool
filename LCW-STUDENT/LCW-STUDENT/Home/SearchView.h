//
//  SearchView.h
//  V2gogo
//
//  Created by ClarkGan on 15/7/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopViewModel.h"
#import "ShopInfo.h"

@protocol SearchViewDelegate <NSObject>

- (void)didSelectShopInfo:(ShopInfo *)shopInfo;

@end

@interface SearchView : UIView
@property(nonatomic, assign)id<SearchViewDelegate> delegate;
#pragma - mark 显示
@property(nonatomic, retain)ShopViewModel *viewModel;
@property(nonatomic, retain)NSString *topicId;
- (void)show;

@end
