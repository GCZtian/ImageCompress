//
//  UIImage+ImageCompress.h
//  ImageCompress
//
//  Created by 龚潮中 on 2019/8/29.
//  Copyright © 2019 龚潮中. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageCompress)

+ (NSData *)compressImage:(UIImage *)image;//压缩图片
+ (NSData *)compressImage:(UIImage *)image maxSize:(NSInteger)maxSize;//指定图片大小压缩图片（单位是KB，图片指定过小会失真）
+ (NSData *)compressImage:(UIImage *)image withMask:(NSString *)maskName;//带水印文字压缩天
+ (NSData *)compressImage:(UIImage *)image withCustomImage:(NSString *)imageName;//添加水印图片压缩图片
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage;//自定义宽高尺寸压缩图片

@end
