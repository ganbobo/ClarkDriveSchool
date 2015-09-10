//
//  AdsView.h
//  Gtwy
//
//  Created by lion on 15/8/17.
//  Copyright (c) 2015年 lion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AdsInfo.h"

@protocol AdsViewDelegate <NSObject>

- (void)didSelectAdsInfo:(AdsInfo *)adsInfo;

@end

@interface AdsView : UIButton

@property(nonatomic, retain)AdsInfo *adsInfo;
@property(nonatomic, assign)id<AdsViewDelegate> delegate;

@end
