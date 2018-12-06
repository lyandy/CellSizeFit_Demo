//
//  DataProvider.h
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeLineModel.h"

@interface DataProvider : NSObject

+ (NSArray<TimeLineModel *> *)getTimeLineData;

@end

