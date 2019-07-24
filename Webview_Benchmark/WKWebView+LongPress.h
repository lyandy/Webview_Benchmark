//
//  WKWebView+LongPress.h
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/7/24.
//  Copyright © 2019 李扬. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (LongPress)

- (CGSize)wk_windowSize;

- (CGPoint)wk_scrollOffset;

- (NSString *)wk_stringByEvaluatingJavaScriptFromStringAndReturn:(NSString *)script;

@end

NS_ASSUME_NONNULL_END
