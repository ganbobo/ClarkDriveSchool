//
//  SchoolInfoView.h
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/7.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SchoolInfoViewDelegate <NSObject>

- (void)didSelectCoach;

@end

@interface SchoolInfoView : UIView

@property(nonatomic, assign)id<SchoolInfoViewDelegate> delegate;

- (void)setDataSource:(BOOL)hasSignUp;

@end
