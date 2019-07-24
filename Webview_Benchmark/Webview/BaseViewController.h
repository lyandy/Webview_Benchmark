//
//  BaseViewController.h
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) id realWebView;

- (void)setupSubview;

- (void)startLoad;

- (void)didFinishLoad;

@end

NS_ASSUME_NONNULL_END
