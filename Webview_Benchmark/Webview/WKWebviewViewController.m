//
//  WKWebviewViewController.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "WKWebviewViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebviewViewController ()<WKNavigationDelegate>

@end

@implementation WKWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupSubview
{
    WKWebView *wkwv = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:wkwv];
    wkwv.navigationDelegate = self;
    
//    NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
//    [wkwv loadRequest:requset];
    
    NSURLRequest *requset = [[NSURLRequest alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]]];
    [wkwv loadRequest:requset];
    self.realWebView = wkwv;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [super startLoad];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [super didFinishLoad];
}

@end
