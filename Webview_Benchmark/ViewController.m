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
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *avgIntervalLabel;

@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@property (weak, nonatomic) IBOutlet UIButton *wkwvBtn;

@property (weak, nonatomic) IBOutlet UIButton *uiwvBtn;
@end

//static NSString *const url = @"https://www.baidu.com";
//static NSString *const url = @"https://ad.doubleclick.net/ddm/trackclk/N566410.3083733/B22986968.251748222;dc_trk_aid=447818764;dc_trk_cid=119078338;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=&use_webkit=1";
//static NSString *const url = @"https://maimai.cn";
static NSString *const url = @"https://ithome.com";
//static NSString *const url = @"https://api.51datakey.com/h5/importV3/index.html#/taobao?apiKey=9ce2eb5cf7ff4c76950abbde20d32ef3&phone=15914412294&backUrl=http%3A%2F%2Fxexdata-fat.wolaidai.com%2Ftools%2FthirdpartyJump%3Fwldchannel%3Dtaobao_scorpion&idcard=431129199012177015&name=%E8%B5%B5%E7%8F%8D%E6%9E%97&quitOnLoginDone=YES&userId=%257B%2522account%2522%253A%252215914412294%2522%252C%2522cnid%2522%253A%2522431129199012177015%2522%252C%2522name%2522%253A%2522%25E8%25B5%25B5%25E7%258F%258D%25E6%259E%2597%2522%252C%2522product%2522%253A%2522test%2522%257D";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
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
//    self.uiwvBtn.enabled = NO;
    
    WKWebviewViewController *wkwvvc = [[WKWebviewViewController alloc] init];
    wkwvvc.url = url;
    wkwvvc.title = sender.titleLabel.text;;
    [self.navigationController pushViewController:wkwvvc animated:YES];
}

- (IBAction)uiwvBtnClicked:(UIButton *)sender
{
//    self.wkwvBtn.enabled = NO;
    
    UIWebviewViewController *uiwvvc = [[UIWebviewViewController alloc] init];
    uiwvvc.url = url;
    uiwvvc.title = sender.titleLabel.text;
    [self.navigationController pushViewController:uiwvvc animated:YES];
}


@end
