//
//  VCCollectionView.h
//  VCPicPlay
//
//  Created by Valyn on 2018/6/26.
//  Copyright © 2018年 Valyn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EventBlock)();



@interface VCCollectionView : UIView

@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, copy) EventBlock removeBlk;
@property (nonatomic, copy) EventBlock finishBlk;

- (void)reloadData;

@end
