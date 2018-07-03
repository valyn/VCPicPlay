//
//  ViewController.m
//  VCPicPlay
//
//  Created by Valyn on 2018/6/21.
//  Copyright © 2018年 Valyn. All rights reserved.
//
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "VCButton.h"
#import "VCHeader.h"
#import "ViewController.h"
#import "VCImagePickerController.h"

@interface ViewController ()<VCImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imgView;


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
    btn.frame = CGRectMake(Half(VCViewW - 200), 150, 200, 50);
    [btn addTarget:self action:@selector(stitchingPhoto) forControlEvents:UIControlEventTouchDown];
    
    
    VCButton *pickBtn = [VCButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:pickBtn];
    [pickBtn setTitle:@"选图" forState:UIControlStateNormal];
    pickBtn.layer.borderWidth = 0.5f;
    pickBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [pickBtn setTitleColor:[UIColor blackColor] forState:normal];
    pickBtn.frame = CGRectMake(Half(VCViewW - 200), 230, 200, 50);
    [pickBtn addTarget:self action:@selector(pickPhoto) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [self.view addSubview:imgV];
    imgV.frame = CGRectMake(Half(VCViewW - 400), 300, 400, 400);
    _imgView = imgV;
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.backgroundColor = ColorWithRGBA(240, 240, 240, 1);
}

- (void)stitchingPhoto
{
    
    if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized) {
        return;
    }
    
    PHFetchOptions *option = [PHFetchOptions new];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];//PHAsset 的属性: creationDate......
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithOptions:option];
    
    [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //        NSLog(@"%@", obj);
        
        PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        [[PHImageManager defaultManager] requestImageForAsset:obj targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", info);
            NSString *filePath = [info valueForKey:@"PHImageFileSandboxExtensionTokenKey"];
            
        }];
    }];
    NSLog(@"%@", fetchResult);
    
    
    
    PHAsset *imgAsset = [PHAsset new];
    //[PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];
    //    [[PHImageManager defaultManager] requestPlayerItemForVideo:imgAsset options:nil resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
    //        NSLog(@"%@", info);
    //    }];
    //    [[PHImageManager defaultManager] requestImageDataForAsset:imgAsset options:[PHImageRequestOptions new] resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
    //        NSLog(@"%@", info);
    //
    //
    //
    //    }];

}

- (void)pickPhoto
{
    VCImagePickerController *imgPickerController = [[VCImagePickerController alloc] init];
//    imgPickerController.doneBtnTitle = @"OK";
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
- (void)imagePickerController:(VCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    _imgView.image = info[@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
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
