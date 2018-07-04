//
//  UIView+Frame.h
//  VCPicPlay
//
//  Created by Valyn on 2018/6/21.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Frame)


- (CGFloat)minX;
- (CGFloat)minY;
- (CGFloat)maxX;
- (CGFloat)maxY;

- (CGFloat)centerX;
- (CGFloat)centerY;

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;

- (CGSize)size;
- (CGPoint)origin;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)origin;


@end
