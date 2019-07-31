//
//  BaseViewController.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "BaseViewController.h"
#import "IntervalDataCenter.h"
#import <WebKit/WebKit.h>
#import "UIWebView+LongPress.h"
#import "WKWebView+LongPress.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSTimeInterval startDate;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubview];
    
   
    
    [self addLongPressGesture];
}

- (void)addLongPressGesture
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 0.3f;
    longPress.allowableMovement = 20.f;
    longPress.delegate = self;
    [self.realWebView addGestureRecognizer:longPress];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] == NO)
    {
        return NO;
    }
    
    return YES;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state != UIGestureRecognizerStateBegan)
    {
        return;
    }
    
    CGPoint point = [sender locationInView:self.realWebView];
    // convert point from view to HTML coordinate system
    CGSize viewSize = [self.realWebView frame].size;
    CGSize windowSize = [self.realWebView isKindOfClass:[WKWebView class]] ? [self.realWebView wk_windowSize] : [self.realWebView windowSize];
    
    CGFloat f = windowSize.width / viewSize.width;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 5.) {
        point.x = point.x * f;
        point.y = point.y * f;
    } else {
        // On iOS 4 and previous, document.elementFromPoint is not taking
        // offset into account, we have to handle it
        CGPoint offset = [self.realWebView isKindOfClass:[WKWebView class]] ? [self.realWebView wk_scrollOffset] : [self.realWebView scrollOffset];
        point.x = point.x * f + offset.x;
        point.y = point.y * f + offset.y;
    }
    
    // Load the JavaScript code from the Resources and inject it into the web page
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSTools" ofType:@"js"];
//    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    [self.realWebView isKindOfClass:[WKWebView class]] ? [self.realWebView wk_stringByEvaluatingJavaScriptFromStringAndReturn:jsCode] : [self.realWebView stringByEvaluatingJavaScriptFromString: jsCode];
//
//    NSString *tags = [self.realWebView isKindOfClass:[WKWebView class]] ? [self.realWebView wk_stringByEvaluatingJavaScriptFromStringAndReturn:[NSString stringWithFormat:@"getHTMLElementsAtPoint(%i,%i);",(NSInteger)point.x,(NSInteger)point.y]] : [self.realWebView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"getHTMLElementsAtPoint(%i,%i);",(NSInteger)point.x,(NSInteger)point.y]];
//    NSString *tagsSRC = [self.realWebView isKindOfClass:[WKWebView class]] ? [self.realWebView wk_stringByEvaluatingJavaScriptFromStringAndReturn:[NSString stringWithFormat:@"getLinkSRCAtPoint(%i,%i);",(NSInteger)point.x,(NSInteger)point.y]] : [self.realWebView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"getLinkSRCAtPoint(%i,%i);",(NSInteger)point.x,(NSInteger)point.y]];
//
//
//    NSLog(@"src : %@",tags);
//    NSLog(@"src : %@",tagsSRC);
//
//    NSString *url = nil;
//    if ([tags rangeOfString:@",IMG,"].location != NSNotFound) {
//        url = tagsSRC;    // Here is the image url!
//        NSLog(@"srcurl :%@", url);
//    }
//
//    CGPoint touchPoint = [sender locationInView:self.realWebView];
    NSString *imgURLJS = [NSString stringWithFormat:@"(function(){var element=document.elementFromPoint(%f, %f);if(element.tagName.toLowerCase()=='img'){return element.src;}})()", point.x, point.y];
    // 执行对应的JS代码 获取url
    [self evaluateJavaScript:imgURLJS completionHandler:^(NSString * _Nullable imageUrl, NSError * _Nullable error) {
        if (imageUrl.length == 0)
        {
            NSLog(@"-----+> 出错");
            return;
        }
        NSLog(@"-----+> %@", imageUrl);
    }];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler
{
    if ([self.realWebView isKindOfClass:[WKWebView class]])
    {
        return [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
    }
    else
    {
        NSString* result = [(UIWebView*)self.realWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        if(completionHandler)
        {
            completionHandler(result, nil);
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.realWebView isKindOfClass:[UIWebView class]])
    {
        ((UIWebView *)self.realWebView).scrollView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    }
    else
    {
        ((WKWebView *)self.realWebView).scrollView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    }
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
