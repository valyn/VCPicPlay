//
//  VCCollectionView.h
//  VCPicPlay
//
//  Created by Valyn on 2018/6/26.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VCCollectionViewDelegateLayout<UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;


@end


@interface VCCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <VCCollectionViewDelegateLayout> delegate;


@end






@interface VCCollectionView : UIView

@property (nonatomic, strong) NSArray *imgArr;


@end
