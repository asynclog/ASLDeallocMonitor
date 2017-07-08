//
//  ASLTestObject.h
//  ASLDeallocMonitor_Example
//
//  Created by infiq on 2017/7/8.
//  Copyright © 2017年 infiniteQin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ASLTestObjectBlock)();
@interface ASLTestObject : NSObject
@property (nonatomic, copy) ASLTestObjectBlock testBlock;
@end
