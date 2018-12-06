//
//  MasonryPhotoContainerView.m
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import "MasonryPhotoContainerView.h"
#import "Masonry.h"
#import "TimeLineModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Andy.h"

#define MAX_IMAGE_COUNT 9

@interface MasonryPhotoContainerView ()

@property (nonatomic, strong) NSArray<UIImageView *> *imageViewsArr;

@end

@implementation MasonryPhotoContainerView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setLinkModelsArr:(NSArray<LinkModel *> *)linkModelsArr
{
    _linkModelsArr = linkModelsArr;
    
    for (long i = linkModelsArr.count; i < self.imageViewsArr.count; i++)
    {
        UIImageView *imageView = [self.imageViewsArr objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (linkModelsArr.count == 0)
    {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
        }];
    }
    else
    {
        CGFloat itemW = [self itemWidthFromArray:linkModelsArr];
        CGFloat itemH = itemW;
        NSUInteger rowItemCount = [self rowItemCountFromArray:linkModelsArr];
        CGFloat commonMargin = 5.0;
        
        [linkModelsArr enumerateObjectsUsingBlock:^(LinkModel * _Nonnull linkModel, NSUInteger idx, BOOL * _Nonnull stop) {
            NSUInteger columnIndex = idx % rowItemCount;
            NSUInteger rowIndex = idx / rowItemCount;
            
            UIImageView *imageView = [self.imageViewsArr objectAtIndex:idx];
            imageView.hidden = NO;
            [imageView sd_setImageWithURL:[NSURL URLWithString:linkModel.linkurl] placeholderImage:[UIImage andy_createImageWithColor:[UIColor grayColor]]];
            
            [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(columnIndex * (itemW + commonMargin));
                make.top.mas_equalTo(rowIndex * (itemH + commonMargin));
                make.width.mas_equalTo(itemW);
                make.height.mas_equalTo(itemH);
            }];
        }];
        
        
        CGFloat w = rowItemCount * itemW + (rowItemCount - 1) * commonMargin;
        NSUInteger columnCount = ceilf(self.linkModelsArr.count * 1.0 / rowItemCount);
        CGFloat h = columnCount * itemH + (columnCount - 1) * commonMargin;

        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(h);
            make.width.mas_equalTo(w);
        }];
    }
}

- (CGFloat)itemWidthFromArray:(NSArray *)array
{
    if (array.count == 1)
    {
        return 120;
    }
    else
    {
        CGFloat width = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return width;
    }
}

- (NSInteger)rowItemCountFromArray:(NSArray *)array
{
    if (array.count < 3)
    {
        return array.count;
    }
    else if (array.count <= 4)
    {
        return 2;
    }
    else
    {
        return 3;
    }
}


- (void)setupSubViews
{
    NSMutableArray<UIImageView *> *tempArrM = [[NSMutableArray alloc] init];

    for (int i = 0; i < MAX_IMAGE_COUNT; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        [tempArrM addObject:imageView];
    }

    self.imageViewsArr = [tempArrM copy];
}

@end
