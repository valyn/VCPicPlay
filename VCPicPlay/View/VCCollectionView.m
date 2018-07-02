//
//  VCCollectionView.m
//  VCPicPlay
//
//  Created by Valyn on 2018/6/26.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import "VCCollectionView.h"

//typedef unsigned char bit;
struct status{
    unsigned bit : 1;// isCellForRow;
    
};

@interface VCCollectionViewLayout () <VCCollectionViewDelegateLayout>


@end

@implementation VCCollectionViewLayout

#pragma mark - Delegate
#pragma mark - VCCollectionViewDelegateLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeZero;
}

@end





@interface VCCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation VCCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[VCCollectionViewLayout new]];
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return self;
}


#pragma mark - Delegate
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Setter & Getter
- (void)setImgArr:(NSArray *)imgArr
{
    _imgArr = imgArr;
    [_collectionView reloadData];
}

@end
