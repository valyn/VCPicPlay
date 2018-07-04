//
//  VCCanvas.m
//  VCPicPlay
//
//  Created by Valyn on 2018/7/4.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "VCCanvas.h"

@implementation VCCanvas

- (void)drawImages:(NSArray<UIImage *> *)imgs
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    for (UIImage *img in imgs) {
        UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
        //        [self drawImage:img inRect:CGRectMake(0, 0, img.size.width, img.size.height) inContext:contextRef];
        [img drawInRect:CGRectMake(0, 0, img.size.width * 0.2, img.size.height * 0.2)];
        [imgV.layer renderInContext:contextRef];
    }
    //    CGContextRelease(contextRef);
    UIGraphicsEndImageContext();
    
}

@end
