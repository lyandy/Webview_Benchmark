//
//  IntervalDataCenter.h
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntervalDataCenter : NSObject

@property (nonatomic, assign) NSUInteger timeCount;

@property (nonatomic, assign) NSTimeInterval avgInterval;

+ (instancetype)sharedInstance;

- (void)addInterval:(NSTimeInterval)interval;

@end

NS_ASSUME_NONNULL_END
