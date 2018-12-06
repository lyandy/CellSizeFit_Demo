//
//  TimeLineModel.h
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LinkModel;

@interface TimeLineModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray<LinkModel *> *links;

@end

@interface LinkModel : NSObject

@property (nonatomic, copy) NSString *linkurl;

@end
