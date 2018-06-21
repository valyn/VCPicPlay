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

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
    }
    UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
    imgPickerController.allowsEditing = YES;
    imgPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imgPickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    imgPickerController.delegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (![self.navigationController.topViewController isKindOfClass:[UIImagePickerController class]]) {
//            [self.navigationController pushViewController:imgPickerController animated:YES];
//        }
        [self presentViewController:imgPickerController animated:YES completion:^{

        }];
//        [self.view addSubview:imgPickerController.view];
    });
}
#pragma mark - Delegate
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"pick image");
}

#pragma mark - Private Method
- (void)injected
{
    NSLog(@"I've been injected : %@", self);
}



@end
