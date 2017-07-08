//
//  NSObject+ASCDeallocMonitor.m
//  ASLDeallocMonitor
//
//  Created by infiq on 2017/7/8.
//

#import "NSObject+ASCDeallocMonitor.h"
#import "ASLMethodSwizzle.h"
#import <objc/runtime.h>
#import "ASCDeallocMonitor.h"

@implementation NSObject (ASCDeallocMonitor)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ASLSwizzleInstanceMethod(self,@selector(init),@selector(asl_init));
        ASLSwizzleInstanceMethod(self,NSSelectorFromString(@"dealloc"),@selector(asl_dealloc));
    });
}

static char const kAssKey;
- (instancetype)asl_init {
    if ([[self class] isEqual:[ASCDeallocMonitor class]]) {
        return [self asl_init];
    }
    if ([NSStringFromClass([ASCDeallocMonitor monitor].observeClass) isEqualToString:NSStringFromClass([self class])]) {
        [[ASCDeallocMonitor monitor] resetAllOnserveInstance];
        [[ASCDeallocMonitor monitor] setValue:@(YES) forKey:@"isObserving"];
        NSString *str = [NSString stringWithFormat:@"%@",self];
        objc_setAssociatedObject(self, &kAssKey, str, OBJC_ASSOCIATION_COPY);
        [[ASCDeallocMonitor monitor] addObserveInstance:str];
        return [self asl_init];
    }
    if (![ASCDeallocMonitor monitor].isObserving || ([ASCDeallocMonitor monitor].filter && [ASCDeallocMonitor monitor].filter(NSStringFromClass([self class])))) {
        return [self asl_init];
    }
    // filter system classes
    if ([NSStringFromClass([self class]) hasPrefix:@"_"] || [NSStringFromClass([self class]) hasPrefix:@"UI"] || [NSStringFromClass([self class]) hasPrefix:@"NS"] || [NSStringFromClass([self class]) hasPrefix:@"CA"] || [NSStringFromClass([self class]) hasPrefix:@"CF"] || [NSStringFromClass([self class]) hasPrefix:@"CUI"] || [NSStringFromClass([self class]) hasPrefix:@"CSI"]) {
        return [self asl_init];
    }
    NSString *str = [NSString stringWithFormat:@"%@",self];
    objc_setAssociatedObject(self, &kAssKey, str, OBJC_ASSOCIATION_COPY);
    [[ASCDeallocMonitor monitor] addObserveInstance:str];
    return [self asl_init];
}

- (void)asl_dealloc {
    NSString *str = objc_getAssociatedObject(self, &kAssKey);
    [[ASCDeallocMonitor monitor] removeDeallocInstance:str];
    [self asl_dealloc];
}

@end
