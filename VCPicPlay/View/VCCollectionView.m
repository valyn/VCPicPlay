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

static NSString *reuseIdentifier = @"VCCollectionViewCell";




@interface VCCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *removeBtn;
@property (nonatomic, copy) EventBlock removeBlk;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation VCCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_removeBtn];
        _removeBtn.backgroundColor = VCImageBlueColor;
        [_removeBtn setTitle:@"x" forState:UIControlStateNormal];
        [_removeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_removeBtn addTarget:self action:@selector(removeBtnDidClick:) forControlEvents:UIControlEventTouchDown];
        _removeBtn.layer.cornerRadius = 10.0f;
        _removeBtn.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _removeBtn.frame = CGRectMake(self.width - 20, 0, 20, 20);
    _imageView.frame = CGRectMake(10, 10, self.width - 20, self.height - 20);
}

- (void)removeBtnDidClick:(UIButton *)sender
{
    if (self.removeBlk) {
        self.removeBlk();
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
}

@end



@interface VCCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *lbl;
@property (nonatomic, strong) UIButton *doneBtn;


@end

@implementation VCCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[UICollectionViewFlowLayout new]];
        [_collectionView registerClass:[VCCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _lbl = [UILabel new];
        [self addSubview:_lbl];
        _lbl.textColor = ColorWithRGBA(120, 120, 120, 1);
        _lbl.text = @"Selected Images:";
        
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_doneBtn];
        [_doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        _doneBtn.adjustsImageWhenHighlighted = NO;
        [_doneBtn addTarget:self action:@selector(doneBtnDidClick:) forControlEvents:UIControlEventTouchDown];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneBtn.backgroundColor = VCImageBlueColor;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _lbl.frame = CGRectMake(0, 0, self.width, 20);
    _doneBtn.frame= CGRectMake(self.width - 75, 0, 60, 30);
    _collectionView.frame = CGRectMake(0, _lbl.maxY, self.width, self.height - 20);
}

- (void)doneBtnDidClick:(UIButton *)btn
{
    if (self.finishBlk) {
        self.finishBlk();
    }
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
    VCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.image = [_imgArr objectAtIndex:indexPath.row];
    @WeakObj(self);
    @WeakObj(cell);
    cell.removeBlk = ^{
        [selfWeak.imgArr removeObject:cellWeak.image];
        [selfWeak reloadData];
        if (selfWeak.removeBlk) {
            selfWeak.removeBlk();
        }
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collectionView.height, _collectionView.height);
}

 - (void)reloadData
{
    [_collectionView reloadData];
}

#pragma mark - Setter & Getter
- (void)setImgArr:(NSMutableArray *)imgArr
{
    _imgArr = imgArr;
    [_collectionView reloadData];
}


@end
