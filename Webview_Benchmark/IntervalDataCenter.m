//
//  IntervalDataCenter.m
//  Webview_Benchmark
//
//  Created by 李扬 on 2019/5/8.
//  Copyright © 2019 李扬. All rights reserved.
//

#import "IntervalDataCenter.h"

@interface IntervalDataCenter ()

@property (nonatomic, strong) NSMutableArray *intervalsArrM;

@end

@implementation IntervalDataCenter

+ (instancetype)sharedInstance
{
    static IntervalDataCenter* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IntervalDataCenter alloc] init];
        sharedInstance->_intervalsArrM = [NSMutableArray array];
    });
    return sharedInstance;
}

- (void)addInterval:(NSTimeInterval)interval
{
    @synchronized (self) {
        [self.intervalsArrM addObject:@(interval)];
    }
    self.timeCount = self.intervalsArrM.count;
    
    [self computeAvg];
}

- (void)computeAvg
{
    __block NSTimeInterval sumInterval = 0;
    @synchronized (self) {
        [self.intervalsArrM enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            sumInterval += obj.doubleValue;
        }];
    }

    self.avgInterval = sumInterval / (self.timeCount * 1.0);
}

@end
