//
//  MasonryViewController.m
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import "MasonryViewController.h"
#import "DataProvider.h"
#import "Masonry.h"
#import "MasonryTableViewCell.h"
#import "YYFPSLabel.h"
#import "AndyGCD.h"

@interface MasonryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *timeLineArr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) AndyGCDTimer *timer;

@end

@implementation MasonryViewController

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Masonry 自动布局";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubViews];
    
    [self getData];
    
    [self testPerformance];
}

- (void)setupSubViews
{
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(0, 100, 60, 20)];
    [self.view addSubview:fpsLabel];
}

- (void)getData
{
    self.timeLineArr = [DataProvider getTimeLineData];
    [self.tableView reloadData];
}

- (void)testPerformance
{
    self.timer = [[AndyGCDTimer alloc] initInQueue:[AndyGCDQueue mainQueue]];
    
    __weak typeof(self) weakSelf = self;
    
    [self.timer timerExecute:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        // 随机得到 25% 的cell，去随机改变cell数据，测试Masonry性能
        
        // 首先得到随机数选取第几份
        uint32_t idxCategory = arc4random_uniform(4); // 0 ~ 3
        // 得到 跨步步长
        NSUInteger perPercentCount = strongSelf.timeLineArr.count / 4;
        
        // 得到索引开始值和结束值
        NSUInteger startIndex = idxCategory * perPercentCount;
        NSUInteger endIndex = (idxCategory + 1) *perPercentCount - 1;
        
        // 改变对应index的数据，组合NSIndexPath indexPathArrM
        NSMutableArray<NSIndexPath *> *indexPathArrM = [NSMutableArray array];
        for (NSUInteger idx = startIndex; idx < endIndex; idx++)
        {
            TimeLineModel *lineModel = strongSelf.timeLineArr[idx];
            lineModel.name = @"我变了";
            
            NSMutableString *strM = [NSMutableString string];
            uint32_t tempIdx = arc4random_uniform(9) + 1;
            for (int i = 0; i < tempIdx; i++)
            {
                [strM appendString:lineModel.name];
            }
            lineModel.content = [strM copy];
            
            NSMutableArray<LinkModel *> *linksArrM = [NSMutableArray array];
            for (int i = 0; i < tempIdx; i++)
            {
                LinkModel *linkMode = lineModel.links.firstObject;
                
                if (linkMode != nil)
                {
                    [linksArrM addObject:linkMode];
                }
            }
            lineModel.links = [linksArrM copy];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [indexPathArrM addObject:indexPath];
        }
        
        [strongSelf.tableView reloadRowsAtIndexPaths:[indexPathArrM copy] withRowAnimation:UITableViewRowAnimationAutomatic];
    } timeIntervalWithSecs:0.1];
    
    [self.timer start];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeLineArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MasonryTableViewCell *cell = [MasonryTableViewCell cellWithTableView:tableView];
    
    TimeLineModel *lineModel = self.timeLineArr[indexPath.row];
    cell.lineModel = lineModel;
    
    return cell;
}

- (void)dealloc
{
    if (self.timer != nil)
    {
        [self.timer destroy];
    }
}

@end
