# ImageCompress
图片压缩

压缩比如下表（苹果拍照格式为JPG）

机型	照片获取途径	原图大小.before	压缩后大小.after 压缩率

6s	拍照	5.87 Mb	112.8 Kb  0.98

7plus	拍照	8.05 Mb	229.1 Kb  0.97

6s	截屏	1.05 Mb	53.56 Kb  0.95

7plus	截屏	234.7 Kb	37.5 Kb  0.84

webp压缩比

原图类型 原图大小.before 压缩后大小.after 压缩率

.JPG   116Kb    89.1Kb  0.23

.PNG   2.62Mb   0.908Mb 0.65

.JPG   12.2Mb   8.54Mb  0.3

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
