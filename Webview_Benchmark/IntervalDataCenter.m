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

- (NSMutableArray *)intervalsArrM
{
    if (_intervalsArrM == nil)
    {
        _intervalsArrM = [NSMutableArray array];
    }
    return _intervalsArrM;
}

+ (instancetype)sharedInstance
{
    static IntervalDataCenter* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IntervalDataCenter alloc] init];
    });
    return sharedInstance;
}

- (void)addInterval:(NSTimeInterval)interval
{
    [self.intervalsArrM addObject:@(interval)];
    self.timeCount = self.intervalsArrM.count;
    
    [self computeAvg];
}

- (void)computeAvg
{
    __block NSTimeInterval sumInterval = 0;
    [self.intervalsArrM enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumInterval += obj.doubleValue;
    }];
    
    self.avgInterval = sumInterval / (self.timeCount * 1.0);
}

@end
