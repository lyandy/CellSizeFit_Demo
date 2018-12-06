//
//  SDAutoLayoutTableViewCell.m
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/6.
//  Copyright © 2018 maimai. All rights reserved.
//

#import "SDAutoLayoutTableViewCell.h"
#import "SDAutoLayoutPhotoContainerView.h"
#import "SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Andy.h"
#import "UIView+Andy.h"
#import "UIView+SDAutoLayout.h"
#import "Masonry.h"

@interface SDAutoLayoutTableViewCell ()

@property (nonatomic ,strong)UIImageView *iconImageView;
@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *contentLabel;
@property (nonatomic ,strong)UIView *devideLineView;

@property (nonatomic ,strong) SDAutoLayoutPhotoContainerView *photoContainerView;

@end

@implementation SDAutoLayoutTableViewCell

- (UIImageView *)iconImageView
{
    if (_iconImageView == nil)
    {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}


- (UILabel *)nameLabel{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
}

- (UIView *)devideLineView
{
    if (_devideLineView == nil)
    {
        _devideLineView = [[UIView alloc] init];
        _devideLineView.backgroundColor = [UIColor colorWithRed:227/255.0 green:232/255.0 blue:238/255.0 alpha:1];
    }
    return _devideLineView;
}

- (SDAutoLayoutPhotoContainerView *)photoContainerView
{
    if (_photoContainerView == nil)
    {
        _photoContainerView = [[SDAutoLayoutPhotoContainerView alloc] init];
    }
    return _photoContainerView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Id = @"SDAutoLayoutCellId";
    SDAutoLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil)
    {
        cell = [[SDAutoLayoutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    [self.contentView sd_addSubviews:@[self.iconImageView, self.nameLabel, self.contentLabel, self.photoContainerView, self.devideLineView]];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView, 16)
    .topSpaceToView(self.contentView, 10)
    .heightIs(55)
    .widthIs(55);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topEqualToView(self.iconImageView)
    .heightIs(16);
    
    self.contentLabel.sd_layout
    .leftEqualToView(self.nameLabel)
    .rightEqualToView(self.nameLabel)
    .topSpaceToView(self.nameLabel, 10)
    .autoHeightRatio(0);
    
    self.photoContainerView.sd_layout
    .leftEqualToView(self.nameLabel);

    self.devideLineView.sd_layout
    .topSpaceToView(self.photoContainerView, 10)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(0.5);
}

- (void)setLineModel:(TimeLineModel *)lineModel
{
    _lineModel = lineModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:lineModel.iconUrl] placeholderImage:[UIImage andy_createImageWithColor:[UIColor grayColor]]];
    
    self.nameLabel.text = lineModel.name;
    self.contentLabel.text = lineModel.content;
    self.photoContainerView.linkModelsArr = lineModel.links;
    
    self.photoContainerView.sd_layout
    .topSpaceToView(self.contentLabel, 10);

    [self setupAutoHeightWithBottomViewsArray:@[self.devideLineView] bottomMargin:0];
}


@end
