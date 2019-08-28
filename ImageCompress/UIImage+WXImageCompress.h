//
//  UIImage+WXImageCompress.h
//  ImageCompress
//
//  Created by 龚潮中 on 2019/8/28.
//  Copyright © 2019 龚潮中. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WXImageCompress)

+ (NSData *)wxImageSize:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
