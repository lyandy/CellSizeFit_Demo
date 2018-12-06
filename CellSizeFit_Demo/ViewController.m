//
//  ViewController.m
//  CellSizeFit_Demo
//
//  Created by 李扬 on 2018/12/5.
//  Copyright © 2018 maimai. All rights reserved.
//

#import "ViewController.h"
#import "MasonryViewController.h"
#import "SDAutoLayoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)masonryBtnClicked:(UIButton *)sender {
    MasonryViewController *masonryVC = [[MasonryViewController alloc] init];
    
    [self.navigationController pushViewController:masonryVC animated:YES];
}

- (IBAction)SDAutoLayoutBtnClicked:(UIButton *)sender {
    SDAutoLayoutViewController *sdAutoLayoutVC = [[SDAutoLayoutViewController alloc] init];

    [self.navigationController pushViewController:sdAutoLayoutVC animated:YES];
}


@end
