//
//  WKWebView+LongPress.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/7/24.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "WKWebView+LongPress.h"

@implementation WKWebView (LongPress)


- (CGSize)wk_windowSize {
    CGSize size;
    size.width = [[self wk_stringByEvaluatingJavaScriptFromStringAndReturn:@"window.innerWidth"] integerValue];
    size.height = [[self wk_stringByEvaluatingJavaScriptFromStringAndReturn:@"window.innerHeight"] integerValue];
    return size;}

- (CGPoint)wk_scrollOffset {
    CGPoint pt;
    pt.x = [[self wk_stringByEvaluatingJavaScriptFromStringAndReturn:@"window.pageXOffset"] integerValue];
    pt.y = [[self wk_stringByEvaluatingJavaScriptFromStringAndReturn:@"window.pageYOffset"] integerValue];
    return pt;}

- (NSString *)wk_stringByEvaluatingJavaScriptFromStringAndReturn:(NSString *)script
{
    __block NSString* result = nil;
    __block BOOL isExecuted = NO;
    [self evaluateJavaScript:script completionHandler:^(id obj, NSError *error) {
        if (self)
        {
            result = obj;
            isExecuted = YES;
            if (error)
            {
                NSLog(@"evaluateJavaScript %@ \n %@",script,error);
            }
        }
    }];
    if (self)
    {
        while (isExecuted == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }
    return result;
}

@end
