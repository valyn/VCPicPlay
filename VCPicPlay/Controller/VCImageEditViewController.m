//
//  VCImageEditViewController.m
//  VCPicPlay
//
//  Created by Valyn on 2018/7/4.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "VCCanvas.h"
#import "VCImageEditViewController.h"

@interface VCImageEditViewController ()

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
    
}

- (void)drawInCanvas
{
    VCCanvas *subView = [[VCCanvas alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:subView];
    
    [subView drawImages:self.imgs];
    
//    return;
    UIGraphicsBeginImageContextWithOptions(subView.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:contextRef];
    float y = 64;
    for (UIImage *img in self.imgs) {
//        [self drawImage:img inRect:CGRectMake(0, 0, img.size.width, img.size.height) inContext:contextRef];
        [img drawInRect:CGRectMake(0, 0, img.size.width * 0.2, img.size.height * 0.2)];
        [img drawAtPoint:CGPointZero];
//        [@"TEXT" drawInRect:CGRectMake(0, 100, 200, 200) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
        
        
        
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width * 0.2, img.size.height * 0.2)];
        [subView addSubview:imgv];
        imgv.image = img;
        
        imgv.center = CGPointMake(400, y + imgv.height * 0.5);
        y += imgv.height;
        
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    subView.contentSize = CGSizeMake(self.view.width, y);
    UIGraphicsEndImageContext();
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
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
