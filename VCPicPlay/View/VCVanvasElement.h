//
//  VCVanvasElement.h
//  VCPicPlay
//
//  Created by Valyn on 2018/7/6.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VCVanvasElement : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) EventBlock removeBlk;

+ (instancetype)elementWithImage:(UIImage *)image;


@end
