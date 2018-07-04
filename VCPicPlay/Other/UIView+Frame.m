//
//  UIView+Frame.m
//  VCPicPlay
//
//  Created by Valyn on 2018/6/21.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView(Frame)


- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}


- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setX:(CGFloat)x
{
    CGRect tmp = self.frame;
    tmp.origin.x = x;
    self.frame = tmp;
}

- (void)setY:(CGFloat)y
{
    CGRect tmp = self.frame;
    tmp.origin.y = y;
    self.frame = tmp;
}

- (void)setWidth:(CGFloat)width
{
    CGRect tmp = self.frame;
    tmp.size.width = width;
    self.frame = tmp;
}

- (void)setHeight:(CGFloat)height
{
    CGRect tmp = self.frame;
    tmp.size.height = height;
    self.frame = tmp;
}

- (void)setSize:(CGSize)size
{
    CGRect tmp = self.frame;
    tmp.size = size;
    self.frame = tmp;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect tmp = self.frame;
    tmp.origin = origin;
    self.frame = tmp;
}


@end
