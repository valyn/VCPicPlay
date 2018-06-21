//
//  VCButton.m
//  VCPicPlay
//
//  Created by Valyn on 2018/6/21.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "VCButton.h"

@implementation VCButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    VCButton *btn = [super buttonWithType:buttonType];
    btn.adjustsImageWhenHighlighted = NO;
    return btn;
}

@end
