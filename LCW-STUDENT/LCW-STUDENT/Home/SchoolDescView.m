//
//  SchoolDescView.m
//  LCW-STUDENT
//
//  Created by St.Pons.Mr.G on 15/9/16.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import "SchoolDescView.h"

#import "NALLabelsMatrix.h"

@interface SchoolDescView () {
    NALLabelsMatrix *_matrix;
    UILabel *_lblTitle;
}

@end

@implementation SchoolDescView

/**
 *  初始化表格详情内容
 *
 *  @param width     宽度
 *  @param originalY 起始坐标
 *  @param columns   表格列数
 *
 *  @return 返回详情内容视图
 */
- (instancetype)initWithWidth:(CGFloat)width
                    originalY:(CGFloat)originalY
                      columns:(NSInteger)columns {
    if (self = [super initWithFrame:CGRectMake(0, originalY, width, 20)]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 35)];
        view.backgroundColor = RGBA(0xee, 0xee, 0xee, 0);
        [self addSubview:view];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, view.width - 10, 35)];
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.font = [UIFont systemFontOfSize:15];
        [view addSubview:_lblTitle];
        
        [self addSubview:view];
        NSArray *columnWitdh = @[];
        if (columns == 4) {
            columnWitdh = @[@(self.width / 4.0), @(self.width / 4.0), @(self.width / 4.0), @(self.width / 4.0)];
        }
        
        if (columns == 5) {
            columnWitdh = @[@(self.width / 5.0), @(self.width / 5.0), @(self.width / 5.0), @(self.width / 5.0), @(self.width / 5.0)];
        }
        
        if (columns == 2) {
            columnWitdh = @[@(self.width / 4.0), @(self.width * 3 / 4.0)];
        }
        
        _matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 35, self.width, 20) andColumnsWidths:columnWitdh];
        [self addSubview:_matrix];
    }
    
    return self;
}

/**
 *  设置展示的内容
 *
 *  @param array 数组，格式为@[@[@"1", @"2"], @[@"3", @"4"]]
 */
- (void)setDataSource:(NSArray *)array title:(NSString *)title {
    _lblTitle.text = title;
    [_matrix removeRecords];
    for (NSDictionary *dic in array) {
        UIColor *color = dic[kTEXT_COLOR_KEY];
        NSArray *arrayContent = dic[kTEXT_ARRAY_KEY];
        [_matrix addRecord:arrayContent withTextColor:color];
    }
    
    [self setHeight:35 + _matrix.height];
}

@end
