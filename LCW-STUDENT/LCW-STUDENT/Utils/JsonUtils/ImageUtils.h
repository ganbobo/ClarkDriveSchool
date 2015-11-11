//
//  ImageUtils.h
//  V2gogo
//
//  Created by St.Pons Mr.G on 15/3/10.
//  Copyright (c) 2015年 Clark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject

/**
 *  指定宽高压缩
 *
 *  @param sourceImage 原图片
 *  @param size        压缩尺寸
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

/**
 *  按照给定的宽度进行等比例压缩
 *
 *  @param sourceImage 源于片
 *  @param defineWidth 指定宽度
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
