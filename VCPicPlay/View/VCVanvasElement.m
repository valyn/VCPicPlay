//
//  VCVanvasElement.m
//  VCPicPlay
//
//  Created by Valyn on 2018/7/6.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "VCVanvasElement.h"

@interface VCVanvasElement ()

@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, assign, getter=isEditing) BOOL editing;
@property (nonatomic, strong) UIButton *removeBtn;
@property (nonatomic, strong) UIButton *enlargeBtn;
@property (nonatomic, assign) CGPoint originCenter;
@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation VCVanvasElement

+ (instancetype)elementWithImage:(UIImage *)image
{
    VCVanvasElement *element = [[[self class] alloc] init];
    element.image = image;
    return element;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _editImageView = [[UIImageView alloc] init];
        [self addSubview:_editImageView];
        _editImageView.frame = self.bounds;
        
        _removeBtn = [VCButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_removeBtn];
        [_removeBtn setImage:[UIImage imageNamed:@"VCRemove"] forState:UIControlStateNormal];
        [_removeBtn addTarget:self action:@selector(removeBtnDidClick:) forControlEvents:UIControlEventTouchDown];
        
        _enlargeBtn = [VCButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_enlargeBtn];
        [_enlargeBtn setImage:[UIImage imageNamed:@"VCEnlarge"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.editImageView.backgroundColor = [UIColor redColor];
    self.editImageView.frame = CGRectMake(10, 10, self.width - 20, self.height - 20);
    self.removeBtn.frame = CGRectMake(0, self.height - 20, 20, 20);
    self.enlargeBtn.frame = CGRectMake(self.width - 20, 0, 20, 20);
}

- (void)dealloc
{
    NSLog(@" ------------------------------ %@ dealloc ------------------------------", [self class]);
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.editing = self.isEditing;
    self.originCenter = self.center;
    UITouch *touch = [touches anyObject];
    CGPoint lastPoint = [touch locationInView:self.superview];
    _lastPoint = lastPoint;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (touches.count == 2) {
        
    } else {
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.superview];
        
        float moveX = currentPoint.x - _lastPoint.x;
        float moveY = currentPoint.y - _lastPoint.y;
        self.center = CGPointMake(self.originCenter.x + moveX, self.originCenter.y + moveY);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.editing = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.editing = NO;
}

#pragma mark - Private Methods
- (void)removeBtnDidClick:(UIButton *)sender
{
    if (self.removeBlk) {
        self.removeBlk();
    }
}

#pragma mark - Setter && Getter
- (void)setImage:(UIImage *)image
{
    _image = image;
    _editImageView.image = image;
}

- (void)setEditing:(BOOL)editing
{
    _editing = editing;
    if (editing) {
        _removeBtn.hidden = NO;
        _enlargeBtn.hidden = NO;
        //        _removeBtn.hidden = NO;
    } else {
        _removeBtn.hidden = YES;
        _enlargeBtn.hidden = YES;
    }
}


@end
