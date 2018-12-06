//
//  TimeLineModel.m
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import "TimeLineModel.h"
#import "NSObject+AndyKeyValue.h"

@implementation TimeLineModel

+ (NSDictionary *)andy_objectClassInArray
{
    return @{@"links" : [LinkModel class]};
}

@end

@implementation LinkModel

@end
