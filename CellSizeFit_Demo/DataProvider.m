//
//  DataProvider.m
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import "DataProvider.h"
#import "AndyExtension.h"

@implementation DataProvider

+ (NSArray<TimeLineModel *> *)getTimeLineData
{
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *tempDict in dict[@"data"]) {
        TimeLineModel *model =[TimeLineModel andy_objectWithKeyValues:tempDict];
        [arrM addObject:model];
    }
    
    [arrM addObjectsFromArray:arrM];
    [arrM addObjectsFromArray:arrM];
    [arrM addObjectsFromArray:arrM];
    [arrM addObjectsFromArray:arrM];
    [arrM addObjectsFromArray:arrM];
    [arrM addObjectsFromArray:arrM];
    
    return [arrM copy];
}

@end
