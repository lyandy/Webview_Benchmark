//
//  ViewController.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "ViewController.h"
#import "WKWebviewViewController.h"
#import "UIWebviewViewController.h"
#import "YYFPSLabel.h"
#import "libOOMDetector.h"
#import "CCUIModel.h"
#import "IntervalDataCenter.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *avgIntervalLabel;

@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@property (weak, nonatomic) IBOutlet UIButton *wkwvBtn;

@property (weak, nonatomic) IBOutlet UIButton *uiwvBtn;
@end

//static NSString *const url = @"https://www.baidu.com";
static NSString *const url = @"https://www.ithome.com";
//static NSString *const url = @"https://maimai.cn";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Webview Benchmark";
    
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(0, 100, 60, 20)];
    [self.navigationController.view addSubview:fpsLabel];
    
    OOMDetector *detector = [OOMDetector getInstance];
    [detector setupWithDefaultConfig];
    
    self.urlLabel.text = [NSString stringWithFormat:@"url:%@", url];
    
    __weak typeof(self) weakSelf = self;
    [CCMNotifier([IntervalDataCenter sharedInstance], timeCount) makeRelation:self withBlock:^(id value) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSUInteger timeCount = ((NSNumber *)value).unsignedIntegerValue;
        strongSelf.countLabel.text = [NSString stringWithFormat:@"次数:%zd", timeCount];
    }];
    
    [CCMNotifier([IntervalDataCenter sharedInstance], avgInterval) makeRelation:self withBlock:^(id value) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSTimeInterval avgInterval = ((NSNumber *)value).doubleValue;
        strongSelf.avgIntervalLabel.text = [NSString stringWithFormat:@"平均加载时间:%lf", avgInterval];
    }];
}

- (IBAction)wkwvBtnClicked:(UIButton *)sender
{
    self.uiwvBtn.enabled = NO;
    
    WKWebviewViewController *wkwvvc = [[WKWebviewViewController alloc] init];
    wkwvvc.url = url;
    wkwvvc.title = sender.titleLabel.text;;
    [self.navigationController pushViewController:wkwvvc animated:YES];
}

- (IBAction)uiwvBtnClicked:(UIButton *)sender
{
    self.wkwvBtn.enabled = NO;
    
    UIWebviewViewController *uiwvvc = [[UIWebviewViewController alloc] init];
    uiwvvc.url = url;
    uiwvvc.title = sender.titleLabel.text;
    [self.navigationController pushViewController:uiwvvc animated:YES];
}


@end
