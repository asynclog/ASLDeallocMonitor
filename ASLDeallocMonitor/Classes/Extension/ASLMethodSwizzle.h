//
//  ASLMethodSwizzle.h
//  ASLDeallocMonitor
//
//  Created by infiq on 2017/7/8.
//

#ifndef ASLMethodSwizzle_h
#define ASLMethodSwizzle_h

#include <stdio.h>

extern void ASLSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector);

#endif /* ASLMethodSwizzle_h */
