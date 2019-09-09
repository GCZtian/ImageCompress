//
//  ViewController.m
//  ImageCompress
//
//  Created by 龚潮中 on 2019/8/27.
//  Copyright © 2019 龚潮中. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageCopress/UIImage+ImageCompress.h"
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
    NSData *newImageData = [UIImage compressImage:self.imageView.image maxSize:25];
    NSUInteger sizeOriginKBN = newImageData.length / 1024;
    NSLog(@"二分法新图片降到的质量：%ld", (unsigned long)sizeOriginKBN);
    self.compressImageView.image = [UIImage imageWithData:newImageData];
    [self saveImageToPhotos:self.compressImageView.image];

}
- (IBAction)lubanCompress:(id)sender {

    NSData *newImageData = [UIImage compressImage:self.imageView.image];
    
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
- (IBAction)sourceImage:(id)sender {
    PhotoBrowserViewController *photoBrowseVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoBrowserViewController"];
    photoBrowseVC.imgBrowse = self.imageView.image;
    photoBrowseVC.transitioningDelegate = self;
    [self presentViewController:photoBrowseVC animated:YES completion:nil];
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
