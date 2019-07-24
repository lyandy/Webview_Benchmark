//
//  UIWebView+LongPress.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/7/24.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "UIWebView+LongPress.h"

@implementation UIWebView (LongPress)

- (CGSize)windowSize {
    CGSize size;
    size.width = [[self stringByEvaluatingJavaScriptFromString:@"window.innerWidth"] integerValue];
    size.height = [[self stringByEvaluatingJavaScriptFromString:@"window.innerHeight"] integerValue];
    return size;}

- (CGPoint)scrollOffset {
    CGPoint pt;
    pt.x = [[self stringByEvaluatingJavaScriptFromString:@"window.pageXOffset"] integerValue];
    pt.y = [[self stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] integerValue];
    return pt;}

@end
