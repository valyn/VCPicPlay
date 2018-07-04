//
//  VCImagePickerController.h
//  VCPicPlay
//
//  Created by Valyn on 2018/6/21.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VCImagePickerControllerDelegate;

@interface VCImagePickerController : UIImagePickerController

//@property (nonatomic, readonly, copy) NSArray *images;
//@property (nonatomic, readwrite, strong) NSString *doneBtnTitle;

@property (nonatomic, nullable, weak) id <VCImagePickerControllerDelegate> vcDelegate;

@end

@protocol VCImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerController:(VCImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo;
- (void)imagePickerController:(VCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
- (void)imagePickerControllerDidCancel:(VCImagePickerController *)picker;

@end
