//
//  VCImageEditViewController.m
//  VCPicPlay
//
//  Created by Valyn on 2018/7/4.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "VCCanvas.h"
#import "VCImageEditViewController.h"
#import <PhotosUI/PHContentEditingController.h>

@interface VCImageEditViewController ()<PHContentEditingController>

@property (nonatomic, strong) UIView *toolBar;


@end

@implementation VCImageEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _toolBar = [UIView new];
    [self.view addSubview:_toolBar];
    _toolBar.frame = CGRectMake(0, self.view.height - 60, self.view.width, 60);
    
    _toolBar.layer.borderColor = VCImageBlueColor.CGColor;
    _toolBar.layer.borderWidth = 1.0f;
    
    UIButton *stripBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stripBtn setTitle:@"Strip" forState:UIControlStateNormal];
    [stripBtn setTitleColor:VCImageBlueColor forState:UIControlStateNormal];
    stripBtn.adjustsImageWhenHighlighted = NO;
    [_toolBar addSubview:stripBtn];
    stripBtn.frame = CGRectMake(10, 10, 60, 40);
    stripBtn.layer.cornerRadius = 10.f;
    stripBtn.layer.masksToBounds = YES;
    stripBtn.layer.borderColor = VCImageBlueColor.CGColor;
    stripBtn.layer.borderWidth = 1.0f;
    
    [self drawInCanvas];
}

- (void)drawInCanvas
{
    VCCanvas *subView = [[VCCanvas alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:subView];
    
    [subView drawImage:[UIImage imageNamed:@"VCEditImage1"]];
//    [subView drawImages:self.imgs];
    
    return;
    UIGraphicsBeginImageContextWithOptions(subView.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:contextRef];
    float y = 64;
    
    UIImage *im = [UIImage imageNamed:@"VCPickerChecked"];
    [im drawAtPoint:CGPointMake(100, 100)];
    
    for (UIImage *img in self.imgs) {
        
        float width = 0;
        float height = 0;
        float ratioW = img.size.width / self.view.width;
        float ratioH = img.size.height / self.view.height;
        
        if (img.size.width > img.size.height) {
            
            width = img.size.width / ratioW ;
            height = img.size.height / ratioW;
        } else {
            
            width = img.size.width / ratioH;
            height = img.size.height / ratioH;
        }
        
        
        
        [img drawInRect:CGRectMake(0, 0, width, height)];
        [img drawAtPoint:CGPointZero];
        y += img.size.height * 0.1;
        
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    subView.contentSize = CGSizeMake(self.view.width, y);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgv.image = img;
    [self.view addSubview:imgv];
}

- (void)drawImage:(UIImage *)img inRect:(CGRect)rect inContext:(CGContextRef)context
{
    [img drawInRect:rect];
}

- (void)setImgs:(NSArray *)imgs
{
    _imgs = imgs;
    [self drawInCanvas];
}

@end
