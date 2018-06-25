//
//  VCImagePickerController.m
//  VCPicPlay
//
//  Created by Valyn on 2018/6/21.
//  Copyright © 2018年 Valyn. All rights reserved.
//
#import <objc/runtime.h>
#import "VCImagePickerController.h"

static char attachSelfKey;

@interface VCImagePickerController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, readwrite, strong) NSMutableArray *selectedImgs;

@property (nonatomic, readonly, strong) Class PUCollectionView;
@property (nonatomic, readonly, strong) Class PUPhotoView;
@property (nonatomic, strong) UIBarButtonItem *doneBtn;
@property (nonatomic, strong) UIBarButtonItem *lastDoneBtn;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) NSMutableArray *indexPaths;

@property (nonatomic, strong) id lastdDelegate;
@property (nonatomic, readwrite, strong) UICollectionView *collectionView;



@end

@implementation VCImagePickerController

- (instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.doneBtnTitle = @"Done";
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class targetClass = [NSClassFromString(@"PUPhotoPickerHostViewController") class];
            SEL replaceSelector = @selector(override_collectionView:cellForItemAtIndexPath:);
            Method m1 = class_getInstanceMethod([self class], replaceSelector);
            class_addMethod(targetClass, replaceSelector, method_getImplementation(m1), method_getTypeEncoding(m1));
            Method m3 = class_getInstanceMethod(targetClass, @selector(collectionView:cellForItemAtIndexPath:));
            method_exchangeImplementations(m1, m3);
            
            //            Method m2 = class_getInstanceMethod(targetClass, replaceSelector);
            
//            SEL replaceSelector2 = @selector(override_collectionView:didSelectItemAtIndexPath:);
//            Method m2 = class_getInstanceMethod([self class], replaceSelector);
//            class_addMethod(targetClass, replaceSelector2, method_getImplementation(m2), method_getTypeEncoding(m2));
//            Method m4 = class_getInstanceMethod(targetClass, @selector(collectionView:didSelectItemAtIndexPath:));
//            method_exchangeImplementations(m2, m4);

        });
    }
    return self;
}

- (UIBarButtonItem *)doneBtn
{
    if (!_doneBtn) {
        _doneBtn = [[UIBarButtonItem alloc] initWithTitle:self.doneBtnTitle style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    }
    return _doneBtn;
}

- (void)done:(UIBarButtonItem *) sender
{
    if ([self.vcDelegate respondsToSelector:@selector(imagePickerControllerDidFinish:)]) {
        [self.vcDelegate imagePickerControllerDidFinish:self];
    }
}

- (UIView *)getPUCollectionView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:self.PUCollectionView]) {
            return subview;
        }
    }
    return nil;
}

- (UIButton *)getIndicatorButton:(UIView *)targetView
{
    for (UIView *subview in targetView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            return (UIButton *)subview;
        }
    }
    return nil;
}

- (void)removeIndicatorBtnFromView:(UIView *)targetView
{
    [[self getIndicatorButton:targetView] removeFromSuperview];
}

- (void)addIndicatorBtnToView:(UIView *)targetView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 15.0f;
    [btn setImage:[UIImage imageNamed:@"VCPickerChecked"] forState:UIControlStateNormal];
    [targetView addSubview:btn];
    [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray * constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[btn(30)]-1-}" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn)];
    NSArray * constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn(30)]-1-}" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn)];
    [targetView addConstraints:constraint1];
    [targetView addConstraints:constraint2];
    btn.selected = YES;
    btn.hidden = NO;
    [targetView updateConstraintsIfNeeded];
}

- (void)addCurrentImage:(UIImage *)img;
{
    if ([self isIndexPathExist]) {
        [self.selectedImgs addObject:img];
        [self.indexPaths addObject:self.currentIndexPath];
        UIView *cell = [self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
        [self addIndicatorBtnToView:cell];
    }
}

- (void)removeCurrentImage:(UIImage *)img
{
    if ([self isIndexPathExist]) {
        [self.selectedImgs removeObject:img];
        int idx = 0;
        for (NSIndexPath *temp in self.indexPaths) {
            if (temp.row == self.currentIndexPath.row && temp.section == self.currentIndexPath.section) {
                break;
            }
            idx ++;
        }
        [self.indexPaths removeObjectAtIndex:idx];
        UIView *cell = [self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
        [self removeIndicatorBtnFromView:cell];
    }
}

- (BOOL)isIndexPathExist
{
    BOOL result = NO;
    for (NSIndexPath *temp in self.indexPaths) {
        if (temp.row == self.currentIndexPath.row && temp.section == self.currentIndexPath.section) {
            result = YES;
            return result;
        }
    }
    return NO;
}

- (void)clearStatus
{
    self.lastdDelegate = nil;
    self.collectionView = nil;
    self.currentIndexPath = nil;
    [self.selectedImgs removeAllObjects];
    [self.indexPaths removeAllObjects];
}

#pragma mark - Delegate
#pragma mark - UICollectionViewDelegate
- (void)override_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did selected");
    VCImagePickerController *picker = (VCImagePickerController *)objc_getAssociatedObject(self, &attachSelfKey);
    
    UICollectionViewCell *cell = [self performSelector:@selector(override_collectionView:cellForItemAtIndexPath:) withObject:collectionView withObject:indexPath];
    
    if (picker) {
        picker.currentIndexPath = indexPath;
        if ([self isIndexPathExist]) {
            [self addIndicatorBtnToView:cell];
        } else {
            [self removeIndicatorBtnFromView:cell];
        }
    }
}

- (void)override_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    VCImagePickerController *picker = (VCImagePickerController *)objc_getAssociatedObject(self, &attachSelfKey);
    
    [self performSelector:@selector(override_collectionView:didSelectItemAtIndexPath:) withObject:collectionView withObject:indexPath];
    self.currentIndexPath = indexPath;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"should selected");
    self.collectionView = collectionView;
    
    
    
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%s", sel_getName(_cmd)]);
    if ([self.lastdDelegate respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.lastdDelegate performSelector:sel withObject:collectionView withObject:indexPath];
#pragma clang diagnostic pop
    }
    return YES;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIView *collectionView = [self getPUCollectionView:viewController.view];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([viewController class], &count);
    for (int index = 0; index < count; index++) {
        Ivar ivar = ivars[index];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [viewController valueForKey:key];
        
        NSLog(@"%@ - %@ —— %@", key, value, [value class]);
        if ([value isKindOfClass:[UIView class]]) {
            NSLog(@"%@" , [value superview]);
        }
    }
    free(ivars);
    
    
    self.interactivePopGestureRecognizer.enabled = NO;
 
    if (!collectionView) {
        return;
    }
    [self clearStatus];
    
    self.lastdDelegate = [collectionView valueForKey:@"delegate"];
    [collectionView setValue:self forKey:@"delegate"];
    objc_setAssociatedObject(self.lastdDelegate, &attachSelfKey, self, OBJC_ASSOCIATION_ASSIGN);//object, key, value, policy
    self.lastDoneBtn = viewController.navigationItem.rightBarButtonItem;
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    /**
     * 如果此子类示例被设置了allowEditing = YES;
     * 当前方法就不走了
     */
    
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    
    if ([self isIndexPathExist]) {
        [self removeCurrentImage:img];
    } else {
        if ([self.vcDelegate respondsToSelector:@selector(imagePickerController:shouldSelectedImage:)]) {
            [self addCurrentImage:img];
        } else {
            return;
        }
    }
    dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
        if (self.images.count != 0) {
            picker.topViewController.navigationItem.rightBarButtonItem = self.doneBtn;
        } else {
            picker.topViewController.navigationItem.rightBarButtonItem = self.lastDoneBtn;
        }
    });
    if ([self.vcDelegate respondsToSelector:@selector(imagePickerControllerDidFinish:)]) {
        [self.vcDelegate imagePickerControllerDidFinish:self];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([self.vcDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [self.vcDelegate imagePickerControllerDidCancel:self];
    }
}

#pragma mark - Getter && Setter
- (Class)PUPhotoView
{
    return NSClassFromString(@"PUPhotoView");
}

- (Class)PUCollectionView
{
    return NSClassFromString(@"PUCollectionView");
}

- (NSMutableArray *)indexPaths
{
    if (!_indexPaths) {
        _indexPaths = [NSMutableArray array];
    }
    return _indexPaths;
}

- (NSArray *)images
{
    return [NSArray arrayWithArray:_selectedImgs];
}

- (NSMutableArray *)selectedImgs
{
    if (!_selectedImgs) {
        _selectedImgs = [NSMutableArray array];
    }
    return _selectedImgs;
}

- (void)setVcDelegate:(id<VCImagePickerControllerDelegate>)vcDelegate
{
    _vcDelegate = vcDelegate;
    
}

@end
