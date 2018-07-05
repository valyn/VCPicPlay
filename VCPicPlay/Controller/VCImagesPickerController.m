//
//  VCImagesPickerController.m
//  VCPicPlay
//
//  Created by Valyn on 2018/7/3.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import <PhotosUI/PHContentEditingController.h>
#import "VCCollectionView.h"
#import "VCImagesPickerController.h"
#import "VCImageEditViewController.h"

static NSString * const reuseIdentifier = @"VCImageCollectionViewCell";

@interface VCImagesCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign, getter=isChecked) BOOL check;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *indicatorImgView;


@end

@implementation VCImagesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imgView = [UIImageView new];
        [self addSubview:_imgView];
        
        _indicatorImgView = [UIImageView new];
        [self addSubview:_indicatorImgView];
        _indicatorImgView.image = [UIImage imageNamed:@"VCPickerChecked"];
        _indicatorImgView.hidden = YES;
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imgView.image = image;
    //    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    float width = 0;
    //    float height = 0;
    //    float ratioW = self.imgView.image.size.width / self.width;
    //    float ratioH = self.imgView.image.size.height / self.height;
    //
    //    if (self.imgView.image.size.width > self.imgView.image.size.height) {
    //
    //        width = self.imgView.image.size.width / ratioW ;
    //        height = self.imgView.image.size.height / ratioW;
    //    } else {
    //
    //        width = self.imgView.image.size.width / ratioH;
    //        height = self.imgView.image.size.height / ratioH;
    //    }
    //
    
    _imgView.frame = CGRectMake(0, 0, self.width, self.height);
    //    _imgView.center = self.center;
    
    _indicatorImgView.frame = CGRectMake(self.width - 30, self.height - 30, 25, 25);
}

- (void)setCheck:(BOOL)check
{
    _check = check;
    _indicatorImgView.hidden = !check;
    self.backgroundColor = check ? VCImageBlueColor : [UIColor whiteColor];
}

@end



@interface VCImagesPickerController() <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) NSArray *photos;

@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
@property (nonatomic, strong) VCCollectionView *selectedCollectionView;


@end

@implementation VCImagesPickerController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedIndexPaths = [NSMutableArray array];
    _selectedPhotos = [NSMutableArray array];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 100) collectionViewLayout:[UICollectionViewFlowLayout new]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[VCImagesCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _selectedCollectionView = [VCCollectionView new];
    @WeakObj(self);
    _selectedCollectionView.removeBlk = ^{
        [selfWeak.collectionView reloadData];
        selfWeak.selectedPhotos = selfWeak.selectedCollectionView.imgArr;
    };
    _selectedCollectionView.finishBlk = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![selfWeak.navigationController.topViewController isKindOfClass:[VCImageEditViewController class]]) {
                VCImageEditViewController *editVC = [VCImageEditViewController new];
                editVC.imgs = selfWeak.selectedPhotos;
                [selfWeak.navigationController pushViewController:editVC animated:YES];
            }
        });
    };
    _selectedCollectionView.disposeImgBlk = ^(UIImage *img) {
      
    };
    
    [self.view addSubview:_selectedCollectionView];
    _selectedCollectionView.frame = CGRectMake(0, self.view.height - 100, self.view.width, 100);
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *imgArr = [NSMutableArray new];
    PHFetchOptions *option = [PHFetchOptions new];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];//PHAsset 的属性: creationDate......
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithOptions:option];
    
    [fetchResult enumerateObjectsUsingBlock:^(PHAsset *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHImageRequestOptions *requestOptions = [PHImageRequestOptions new];
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        requestOptions.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestImageForAsset:obj targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            if (obj.mediaType == PHAssetMediaTypeImage) {
                [imgArr addObject:[result copy]];
            }
            
            if (idx == fetchResult.count - 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    selfWeak.photos = imgArr;
                });
            }
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VCImagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    ////    NSLayoutConstraint *layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imgV]-0-|" options:NSLayoutFormatAlignAllLastBaseline metrics:nil views:imgV];
    ////    [imgV addConstraint:layout];
    cell.image = _photos[indexPath.row];
    cell.check = [self.selectedPhotos containsObject:cell.imgView.image];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(180, 180);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VCImagesCollectionViewCell *cell = (VCImagesCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.check = !cell.isChecked;
    [self addImage:cell.imgView.image];
    [self addIndexPath:indexPath];
}

- (void)addImage:(UIImage *)currentImg
{
    if ([_selectedPhotos containsObject:currentImg]) {
        [_selectedPhotos removeObject:currentImg];
    } else {
        [_selectedPhotos addObject:currentImg];
    }
    _selectedCollectionView.imgArr = _selectedPhotos;
}

- (void)addIndexPath:(NSIndexPath *)currentIndexPath
{
    if ([_selectedIndexPaths containsObject:currentIndexPath]) {
        [_selectedIndexPaths removeObject:currentIndexPath];
    } else {
        [_selectedIndexPaths addObject:currentIndexPath];
    }
}
/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.collectionView reloadData];
}

@end
