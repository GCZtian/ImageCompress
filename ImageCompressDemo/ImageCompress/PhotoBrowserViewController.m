//
//  PhotoBrowserViewController.m
//  ImageCompress
//
//  Created by 龚潮中 on 2019/8/28.
//  Copyright © 2019 龚潮中. All rights reserved.
//

#import "PhotoBrowserViewController.h"

@interface PhotoBrowserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *browserImageView;

@end

@implementation PhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initSubViews];

}

- (void)initSubViews {
    
    [self.browserImageView setImage:self.imgBrowse];
}

- (IBAction)tapView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setImgBrowse:(UIImage *)imgBrowse {
    
    _imgBrowse = imgBrowse;
    
    if (imgBrowse) {
        self.view.backgroundColor = [UIColor blackColor];
    }
    else {
        self.view.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:216.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
