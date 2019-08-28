//
//  UIImage+WXImageCompress.m
//  ImageCompress
//
//  Created by 龚潮中 on 2019/8/28.
//  Copyright © 2019 龚潮中. All rights reserved.
//

#import "UIImage+WXImageCompress.h"

@implementation UIImage (WXImageCompress)

+ (NSData *)wxImageSize:(UIImage *)image
{
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    CGFloat boundary = 1280;
    
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    
    // width, height <= 1280, Size remains the same
    if (imageWidth <= boundary && imageHeight <= boundary) {
        UIImage* reImage = [self resizedImage:imageWidth withHeight:imageHeight withImage:image];
        data = UIImageJPEGRepresentation(reImage, 0.5);
        return data;
    }
    
    // aspect ratio
    CGFloat s = MAX(imageWidth, imageHeight) / MIN(imageWidth, imageHeight);
    
    if (s <= 2) {
        // Set the larger value to the boundary, the smaller the value of the compression
        CGFloat x = MAX(imageWidth, imageHeight) / boundary;
        if (imageWidth > imageHeight) {
            imageWidth = boundary ;
            imageHeight = imageHeight / x;
        }else{
            imageHeight = boundary;
            imageWidth = imageWidth / x;
        }
    }else{
        if (MIN(imageWidth, imageHeight) >= boundary) {
            //- parameter type: session image boundary is 800, timeline is 1280
            // boundary = type == .session ? 800 : 1280
            CGFloat x = MIN(imageWidth, imageHeight) / boundary;
            if (imageWidth < imageHeight) {
                imageWidth = boundary;
                imageHeight = imageHeight / x;
            } else {
                imageHeight = boundary;
                imageWidth = imageWidth / x;
            }
        }
    }
    UIImage* reImage = [self resizedImage:imageWidth withHeight:imageHeight withImage:image];
    data = UIImageJPEGRepresentation(reImage, 0.5);
    return data;
}

+ (UIImage *)resizedImage:(CGFloat)imageWidth withHeight:(CGFloat)imageHeight withImage:(UIImage *)sourceImage {
    CGRect newRect = CGRectMake(0, 0, imageWidth, imageHeight);
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 1);
    [sourceImage drawInRect:newRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
