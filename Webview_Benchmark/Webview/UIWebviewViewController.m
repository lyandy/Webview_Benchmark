//
//  UIWebviewViewController.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "UIWebviewViewController.h"

@interface UIWebviewViewController ()<UIWebViewDelegate>

@end

@implementation UIWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupSubview
{
    UIWebView *uiwv = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:uiwv];
    uiwv.delegate = self;
    NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [uiwv loadRequest:requset];
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
