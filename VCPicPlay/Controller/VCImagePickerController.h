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

@property (nonatomic, readonly, copy) NSArray *images;
@property (nonatomic, readwrite, strong) NSString *doneBtnTitle;
@property (nonatomic, nullable, weak) id <VCImagePickerControllerDelegate> vcDelegate;



@end

@protocol VCImagePickerControllerDelegate <NSObject>

@optional
- (void)imagePickerControllerDidFinish:(VCImagePickerController *)picker;
- (void)imagePickerControllerDidCancel:(VCImagePickerController *)picker;
- (void)imagePickerController:(VCImagePickerController *)picker shouldSelectedImage:(UIImage *)image;

@end
