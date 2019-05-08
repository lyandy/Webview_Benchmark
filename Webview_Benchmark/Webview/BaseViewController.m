//
//  BaseViewController.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "BaseViewController.h"
#import "IntervalDataCenter.h"

@interface BaseViewController ()

@property (nonatomic, assign) NSTimeInterval startDate;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubview];
    
}

- (void)setupSubview
{
}

- (void)startLoad
{
    // 页面开始加载
    self.startDate = [[NSDate date] timeIntervalSince1970];
}

- (void)didFinishLoad
{
    // 页面加载结束
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] - self.startDate;
    
    [[IntervalDataCenter sharedInstance] addInterval:interval];
    
    NSLog(@"------> %lf", interval);
}


@end
