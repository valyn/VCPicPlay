//
//  VCCanvas.m
//  VCPicPlay
//
//  Created by Valyn on 2018/7/4.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "VCCanvas.h"
#import "VCVanvasElement.h"

@implementation VCCanvas

#pragma mark - Life Cycle
- (void)dealloc
{
    NSLog(@" ------------------------------ %@ dealloc ------------------------------", [self class]);
}

#pragma mark - Public Methods
- (void)drawImage:(UIImage *)img
{
    VCVanvasElement *element = [VCVanvasElement elementWithImage:img];
    @WeakObj(element);
    element.removeBlk = ^{
        [elementWeak removeFromSuperview];
    };
    [self addSubview:element];
    element.bounds = CGRectMake(0, 0, 200, 200);
    element.center = self.center;
}

- (void)drawImages:(NSArray<UIImage *> *)imgs
{
    for (UIImage *img in imgs) {
        [self drawImage:img];
    }
}


@end
