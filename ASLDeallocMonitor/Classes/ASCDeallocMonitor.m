//
//  ASCDeallocMonitor.m
//  ASLDeallocMonitor
//
//  Created by infiq on 2017/7/8.
//

#import "ASCDeallocMonitor.h"
#import <Aspects/Aspects.h>
//
@interface ASCDeallocMonitor ()
@property(nonatomic, strong) NSMutableSet<NSString*> *monitoredObjs;
@end


@implementation ASCDeallocMonitor

+ (instancetype)monitor {
    static ASCDeallocMonitor *monitor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[self alloc] init];
    });
    return monitor;
}

- (void)startMonitor {
    if (!self.observeClass) {
        return;
    }
    __weak typeof(self) wSelf = self;
    [self.observeClass aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        __strong typeof(wSelf) sSelf = wSelf;
        if ([NSStringFromClass([aspectInfo.instance class]) isEqualToString:NSStringFromClass(sSelf.observeClass)]) {
            [sSelf endMonitor:self.monitoredObjs];
        }
    } error:nil];
}

- (void)manualEnd {
    [self endMonitor:self.monitoredObjs];
}

- (void)endMonitor:(NSMutableSet<NSString*>*)monitoredObjs {
    _isObserving = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @autoreleasepool {
            if (monitoredObjs.count > 0) {
                NSLog(@"=============un dealloc class name==========");
                [monitoredObjs enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                    NSLog(@"%@",obj);
                }];
                NSLog(@"=============end==========");
            }else {
                NSLog(@"==============no reference class=====================");
            }
            [monitoredObjs removeAllObjects];
        }
    });
}

- (NSMutableSet<NSString*> *)monitoredObjs {
    @synchronized(_monitoredObjs){
        if (!_monitoredObjs) {
            _monitoredObjs = [NSMutableSet set];
        }
    }
    return _monitoredObjs;
}

- (void)addObserveInstance:(NSString*)objDesc {
    if(!objDesc) {
        return;
    }
    [self.monitoredObjs addObject:objDesc];
}

- (void)removeDeallocInstance:(NSString*)objDesc {
    if(!objDesc) {
        return;
    }
    [self.monitoredObjs removeObject:objDesc];
}

- (void)resetAllOnserveInstance {
    [self.monitoredObjs removeAllObjects];
    _monitoredObjs = nil;
}


@end
