# ImageCompress
图片压缩
安装.Install

Via CocoaPods

在 Podfile 文件里添加
 pod 'ImageCompress',:git => 'https://github.com/GCZtian/ImageCompress.git'
然后在终端运行 pod install
使用.Usage

下载 Demo 试玩一下,看一下输出,点一下图片看压缩后的效果大图

导入 Category 头文件:

#import <ImageCompress/UIImage+ImageCopress.h>

方法调用

[UIImage compressImage:image] or

[UIImage compressImage:image maxSize:maxSize] or 

[UIImage compressImage:image withMask:maskName] or

[UIImage compressImage:image withCustomImage:imageName] or 

[UIImage newSizeImage:size image:sourceImage]

参数说明

/*
 image:    UIImage 对象
 maxSize: 指定压缩大小
 withMask: 添加水印名字 (NSString)
 withCustomImage: 水印图片名称
 newSizeImage: 自定义压缩尺寸
*/
