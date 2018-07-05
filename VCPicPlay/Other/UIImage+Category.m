//
//  UIImage+Category.m
//  VCPicPlay
//
//  Created by Valyn on 2018/7/5.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage(Category)

- (UIImage *)resizeImageToSize:(CGSize)size
{
    UIImage *newImage;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    
//    self 
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
