//
//  UIWebviewViewController.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "UIWebviewViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface UIWebviewViewController ()<UIWebViewDelegate>

@end

@implementation UIWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)setupSubview
{
    UIWebView *uiwv = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:uiwv];
    uiwv.delegate = self;
    NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [uiwv loadRequest:requset];
//    NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]]];
//    [uiwv loadRequest:requset];
    
    self.realWebView = uiwv;

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSString *str = @"(function(){if(window.search_callback)search_callback('{\"keyword\":\"邵然\",\"is_suggestion\":1}')})()";
//        [uiwv stringByEvaluatingJavaScriptFromString:str];
//    });
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 参考：https://stackoverflow.com/questions/37781529/nsassert-not-work-in-uiwebview-delegate-method
    //abort();
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [super startLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super didFinishLoad];
}

@end
