//
//  ViewController.m
//  ImageCompress
//
//  Created by 龚潮中 on 2019/8/27.
//  Copyright © 2019 龚潮中. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Luban_iOS_Extension_h.h"
#import "PhotoBrowserViewController.h"
#import "UIImage+WXImageCompress.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *compressImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lubanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *WXImageView;

@property (strong, nonatomic) UIImagePickerController *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor greenColor];
    
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    
//    HH *hh = [[HH alloc] init];
    
//    UIImage *sourceImage = [UIImage imageNamed:@"IMG_9698.JPG"];
//    NSData *newImageData = [self resetSizeOfImageData:sourceImage maxSize:30];
//    NSUInteger sizeOriginKB = newImageData.length / 1024;

    
//    NSLog(@"新图片降到的质量：%ld", (unsigned long)sizeOriginKB);
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:newImageData]];
//    imageView.center = self.view.center;
//    imageView.frame = self.view.frame;
//    [self.view addSubview:imageView];

}
- (IBAction)photoButton:(UIButton *)sender {
    
    BOOL isPicker = NO;
    
    switch (sender.tag) {
        case 10000:
            //            打开相机
            isPicker = true;
            //            判断相机是否可用
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                isPicker = true;
            }
            break;
            
        case 10001:
            //            打开相册
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            isPicker = true;
            break;
            
        default:
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            isPicker = true;
            break;
    }
    
    if (isPicker) {
        [self presentViewController:self.picker animated:YES completion:nil];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"相机不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (IBAction)compressImage:(UIButton *)sender {
    NSData *newImageData = [self resetSizeOfImageData:self.imageView.image maxSize:10];
    NSData *finallImageData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
    NSInteger sizeOrigin = finallImageData.length;
    NSInteger sizeOriginKB = sizeOrigin/1024;
    NSLog(@"查看图片大小是否有变化：%lu", sizeOriginKB);
    
        NSUInteger sizeOriginKBN = newImageData.length / 1024;
    
    
        NSLog(@"二分法新图片降到的质量：%ld", (unsigned long)sizeOriginKBN);
    self.compressImageView.image = [UIImage imageWithData:newImageData];
    [self saveImageToPhotos:self.compressImageView.image];

}
- (IBAction)lubanCompress:(id)sender {
    
    NSData *finallImageData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
    NSInteger sizeOrigin = finallImageData.length;
    NSInteger sizeOriginKB = sizeOrigin/1024;
    NSLog(@"查看图片大小是否有变化：%lu", sizeOriginKB);

    NSData *newImageData = [UIImage lubanCompressImage:self.imageView.image];
    
    NSUInteger sizeOriginKBN = newImageData.length / 1024;
    
    
    NSLog(@"鲁班压缩图片降到的质量：%ld", (unsigned long)sizeOriginKBN);
    self.lubanImageView.image = [UIImage imageWithData:newImageData];
    [self saveImageToPhotos:self.lubanImageView.image];

}
- (IBAction)WXCompress:(id)sender {
    NSData *newImageData = [UIImage wxImageSize:self.imageView.image];
    
    NSUInteger sizeOriginKBN = newImageData.length / 1024;
    
    
    NSLog(@"微信压缩图片降到的质量：%ld", (unsigned long)sizeOriginKBN);
    self.WXImageView.image = [UIImage imageWithData:newImageData];
    [self saveImageToPhotos:self.WXImageView.image];
}
- (IBAction)erFenCompress:(id)sender {
    PhotoBrowserViewController *photoBrowseVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoBrowserViewController"];
    photoBrowseVC.imgBrowse = self.compressImageView.image;
    photoBrowseVC.transitioningDelegate = self;
    [self presentViewController:photoBrowseVC animated:YES completion:nil];
}
- (IBAction)lubanC:(id)sender {
    PhotoBrowserViewController *photoBrowseVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoBrowserViewController"];
    photoBrowseVC.imgBrowse = self.lubanImageView.image;
    photoBrowseVC.transitioningDelegate = self;
    [self presentViewController:photoBrowseVC animated:YES completion:nil];
}
- (IBAction)WXC:(id)sender {
    PhotoBrowserViewController *photoBrowseVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoBrowserViewController"];
    photoBrowseVC.imgBrowse = self.WXImageView.image;
    photoBrowseVC.transitioningDelegate = self;
    [self presentViewController:photoBrowseVC animated:YES completion:nil];
}

- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
    }
    return _picker;
}

- (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
  //先判断当前质量是否满足要求，不满足再压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage, 1.0);
    NSInteger sizeOrigin = finallImageData.length;
    NSInteger sizeOriginKB = sizeOrigin/1024;
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    //获取原图片的宽高比
    CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
    finallImageData = UIImageJPEGRepresentation(newImage, 1.0);
    
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i * avg;
        [compressionQualityArr addObject:@(value)];
    }
    /*
    调整大小
    说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length/1024 > maxSize) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width - reduceWidth <= 0 || defaultSize.height - reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width - reduceWidth, defaultSize.height - reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage, [[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image, 1.0) maxSize:maxSize];
    }
    return finallImageData;

}

//调整图片分辨率（等比例缩放）
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    CGFloat tempH = newSize.height / size.height;
    CGFloat tempW = newSize.width / size.width;
    if (tempW > 1.0 && tempW > tempH) {
        newSize = CGSizeMake(sourceImage.size.width/tempW, sourceImage.size.height/tempW);
    } else if (tempH > 1.0 && tempW < tempH) {
        newSize = CGSizeMake(sourceImage.size.width/tempH, sourceImage.size.height/tempH);
    }
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1);
    [sourceImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//二分法
- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    NSUInteger difference = NSIntegerMax;
    while (start <= end) {
        index = start + (end - start)/2;
        finallImageData = UIImageJPEGRepresentation(image, [arr[index] floatValue]);
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);

        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize - sizeOriginKB < difference) {
                difference = maxSize - sizeOriginKB;
                tempData = finallImageData;
            }
            if (index <= 0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    if (tempData.length == 0) {
        tempData = finallImageData;
    }
    return tempData;
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //    获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    NSData *finallImageData = UIImageJPEGRepresentation(image, 1.0);
    NSInteger sizeOrigin = finallImageData.length;
    NSInteger sizeOriginKB = sizeOrigin/1024;
    NSLog(@"拍照获得的图片大小：%lu", sizeOriginKB);
    self.imageView.image = image;
    //    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



//保存图片
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    if (!savedImage) {
        return;
    }
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
}

//回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error != NULL){
    }else{
        NSLog(@"保存图片到相册");
    }
}


@end
