//
//  ASCDeallocMonitor.h
//  ASLDeallocMonitor
//
//  Created by infiq on 2017/7/8.
//

#import <Foundation/Foundation.h>

typedef BOOL (^ASCDeallocMonitorFilter)(NSString *clsName);

@interface ASCDeallocMonitor : NSObject

@property (nonatomic, copy) ASCDeallocMonitorFilter filter;
@property (nonatomic, assign) Class observeClass;
@property (nonatomic, assign) NSUInteger delay;


@property (nonatomic, assign, readonly) BOOL isObserving;
//@property(nonatomic, strong, readonly) NSMutableSet<NSString*> *monitoredObjs;

+ (instancetype)monitor;

- (void)startMonitor;

- (void)manualEnd;

- (void)addObserveInstance:(NSString*)objDesc;

- (void)removeDeallocInstance:(NSString*)objDesc;

- (void)resetAllOnserveInstance;

@end
