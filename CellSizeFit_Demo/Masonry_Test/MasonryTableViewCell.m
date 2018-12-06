//
//  MasonryTableViewCell.m
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import "MasonryTableViewCell.h"
#import "MasonryPhotoContainerView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Andy.h"

@interface MasonryTableViewCell ()

@property (nonatomic ,strong)UIImageView *iconImageView;
@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *contentLabel;
@property (nonatomic ,strong)UIView *devideLineView;

@property (nonatomic ,strong) MasonryPhotoContainerView *photoContainerView;

@end

@implementation MasonryTableViewCell

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

- (MasonryPhotoContainerView *)photoContainerView
{
    if (_photoContainerView == nil)
    {
        _photoContainerView = [[MasonryPhotoContainerView alloc] init];
    }
    return _photoContainerView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Id = @"MasonryCellId";
    MasonryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil)
    {
        cell = [[MasonryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
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
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.photoContainerView];
    [self.contentView addSubview:self.devideLineView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.iconImageView.mas_top);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.nameLabel.mas_right);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    
    [self.devideLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.photoContainerView.mas_bottom).offset(10);
        make.left.and.right.and.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setLineModel:(TimeLineModel *)lineModel
{
    _lineModel = lineModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:lineModel.iconUrl] placeholderImage:[UIImage andy_createImageWithColor:[UIColor grayColor]]];
    
    self.nameLabel.text = lineModel.name;
    self.contentLabel.text = lineModel.content;
    self.photoContainerView.linkModelsArr = lineModel.links;
    
    [self.photoContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10).with.priorityHigh();
        make.left.mas_equalTo(self.nameLabel.mas_left);
    }];
}

@end
