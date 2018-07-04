//
//  VCImagesPickerController.h
//  VCPicPlay
//
//  Created by Valyn on 2018/7/3.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, VCImagePickerControllerPickMode){
    VCImagePickerControllerPickModeDefault,
    VCImagePickerControllerPickModeMultiply,
};

@protocol VCImagesPickerControllerDelegate;

@interface VCImagesPickerController : UIViewController

@property (nonatomic, assign) VCImagePickerControllerPickMode pickMode; //default value is VCImagePickerControllerPickModeDefault.

/**
 * UIImagePickerControllerSourceTypePhotoLibrary,     图库
 * UIImagePickerControllerSourceTypeCamera,           相机
 * UIImagePickerControllerSourceTypeSavedPhotosAlbum  相机胶卷
 */
@property(nonatomic) UIImagePickerControllerSourceType sourceType;  // default value is UIImagePickerControllerSourceTypePhotoLibrary.

@property (nonatomic, weak) id<VCImagesPickerControllerDelegate> vcDelegate;



@end




@protocol VCImagesPickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(VCImagesPickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo;
- (void)imagePickerController:(VCImagesPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
- (void)imagePickerControllerDidCancel:(VCImagesPickerController *)picker;

@end




