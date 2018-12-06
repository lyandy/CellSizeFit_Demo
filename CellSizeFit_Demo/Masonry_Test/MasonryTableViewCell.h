//
//  MasonryTableViewCell.h
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineModel.h"

@interface MasonryTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) TimeLineModel *lineModel;

@end

