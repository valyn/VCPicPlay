//
//  ViewController.m
//  VCPicPlay
//
//  Created by Valyn on 2018/6/21.
//  Copyright © 2018年 Valyn. All rights reserved.
//
#import "VCButton.h"
#import "VCHeader.h"
#import "ViewController.h"
#import "VCImagePickerController.h"

@interface ViewController ()<VCImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    VCButton *btn = [VCButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"拼图" forState:UIControlStateNormal];
    btn.layer.borderWidth = 0.5f;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn setTitleColor:[UIColor blackColor] forState:normal];
    btn.frame = CGRectMake(Half(VCViewW - 200), 200, 200, 50);
    [btn addTarget:self action:@selector(pickPhoto) forControlEvents:UIControlEventTouchDown];
}

- (void)pickPhoto
{
    VCImagePickerController *imgPickerController = [[VCImagePickerController alloc] init];
    imgPickerController.doneBtnTitle = @"OK";
//    imgPickerController.allowsEditing = YES; //加了这句，点击照片就直接进入展示页
    imgPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPickerController.vcDelegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (![self.navigationController.topViewController isKindOfClass:[UIImagePickerController class]]) {
//            [self.navigationController pushViewController:imgPickerController animated:YES];
//        }
        [self.view addSubview:imgPickerController.view];
        [self presentViewController:imgPickerController animated:YES completion:^{

        }];
    });
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

#pragma mark - Delegate
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(VCImagePickerController *)picker
{
    
}

- (void)imagePickerControllerDidFinish:(VCImagePickerController *)picker
{
    
}

#pragma mark - Private Method
- (void)injected
{
//    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"I've been injected : %@", self);
}

- (void)authorized
{
//    [auth];
}


@end
