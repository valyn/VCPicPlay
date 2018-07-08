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
@property (nonatomic, assign) float originWidth;
@property (nonatomic, assign) float originHeight;


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
        
        
        UIPanGestureRecognizer *panImageGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImageGesture:)];
        [self addGestureRecognizer:panImageGesture];
        
        UIPanGestureRecognizer *rotationGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGesture:)];
        [self.enlargeBtn addGestureRecognizer:rotationGesture];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
        [self addGestureRecognizer:pinchGesture];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = 26;
    self.editImageView.backgroundColor = [UIColor redColor];
    self.editImageView.frame = CGRectMake(btnW * 0.5, btnW * 0.5, self.width - btnW, self.height - btnW);
    self.removeBtn.frame = CGRectMake(0, self.height - btnW, btnW, btnW);
    self.enlargeBtn.frame = CGRectMake(self.width - btnW, 0, btnW, btnW);
}

- (void)dealloc
{
    NSLog(@" ------------------------------ %@ dealloc ------------------------------", [self class]);
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.editing = !self.isEditing;
    if (touches.count == 2) {
        
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    if (touches.count == 2) {
//
//    } else {
//        UITouch *touch = [touches anyObject];
//        CGPoint currentPoint = [touch locationInView:self.superview];
//
//        float moveX = currentPoint.x - _lastPoint.x;
//        float moveY = currentPoint.y - _lastPoint.y;
//        self.center = CGPointMake(self.originCenter.x + moveX, self.originCenter.y + moveY);
//    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.editing = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.editing = NO;
}

#pragma mark - Private Methods
- (void)removeBtnDidClick:(UIButton *)sender
{
    if (self.removeBlk) {
        self.removeBlk();
    }
}

- (void)rotationGesture:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.originCenter = self.center;
            _lastPoint = [pan locationInView:self.superview];
            self.originWidth = self.width;
            self.originHeight = self.height;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint = [pan locationInView:self.superview];
            
            float orginDistance = [self distanceBetweenPointA:_originCenter pointB:_lastPoint];
            float distance = [self distanceBetweenPointA:_originCenter pointB:currentPoint];
            float scale =  distance / orginDistance;
            NSLog(@"%f", scale);
            
            
            float moveX = currentPoint.x - _lastPoint.x;
            float moveY = currentPoint.y - _lastPoint.y;
//            self.center = CGPointMake(self.originCenter.x + moveX, self.originCenter.y + moveY);
            self.transform = CGAffineTransformMakeScale(scale, scale);
            self.bounds = CGRectMake(0, 0, self.originWidth * scale, self.originHeight * scale);
            self.center = self.center;
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            self.originWidth = self.width;
            self.originHeight = self.height;
        }
            break;
        default:
            break;
    }
}

- (float)distanceBetweenPointA:(CGPoint)pointA pointB:(CGPoint)pointB
{
    float x = pointA.x -  pointB.x;
    float y = pointA.y - pointB.y;

    float result = sqrtf(fabs(pow(x, 2) - pow(y, 2)));
    return result;
}

- (void)panImageGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint lastPoint = [pan locationInView:self.superview];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.originCenter = self.center;
            _lastPoint = lastPoint;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint currentPoint = [pan locationInView:self.superview];
            float moveX = currentPoint.x - _lastPoint.x;
            float moveY = currentPoint.y - _lastPoint.y;
            self.center = CGPointMake(self.originCenter.x + moveX, self.originCenter.y + moveY);
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)pinch
{
    switch (pinch.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.originWidth = self.width;
            self.originHeight = self.height;
//            NSLog(@" ------------------------------ began :%@", NSStringFromCGRect(self.frame));
//            self.frame = self.frame;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
//            NSLog(@" %f", pinch.scale);
//            self.transform = CGAffineTransformMakeScale(pinch.scale, pinch.scale);
            self.bounds = CGRectMake(0, 0, self.originWidth * pinch.scale, self.originHeight * pinch.scale);
            self.center = self.center;
        }
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"  cancel  ");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"  fail  ");
            break;
        case UIGestureRecognizerStateEnded:
//            NSLog(@" -------------------------- end befoghre :%@", NSStringFromCGRect(self.frame));
            self.originWidth = self.width;// * pinch.scale;
            self.originHeight = self.height;// * pinch.scale;
//            NSLog(@" -------------------------- end after  :%@", NSStringFromCGRect(self.frame));
            break;
        default:
            break;
    }
    NSLog(@"%d" ,pinch.state);
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
