XCode5gcovPatch
===============

A monkey patch for unit and UIAutomation coverage. The patch forces gcov to flush its results to .gcda files.


Force Code Coverage for UIAutomation Tests:
===========================================

The following code will force gcov to flush its metrics when the iOS app enters the background (command shit H in the simulator).



UIApplication+GCovFlush.h	
-------------------------
'''
#import <XCTest/XCTest.h>

@interface XCTest (GCovFlush)

@end
'''

UIApplication+GCovFlush.m
-------------------------
'''
#import "UIApplication+GCovFlush.h"
#import <objc/runtime.h>

extern void __gcov_flush();

@implementation UIApplication (GCovFlush)

+ (void)forceGcovFlush
{
    if (__gcov_flush) {
        __gcov_flush();
    }
}

+ (void)load
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forceGcovFlush) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

@end
'''


Force Code Coverage for Unit XCTests:
===========================================


XCTest+GCovFlush.h	
'''
#import <XCTest/XCTest.h>

@interface XCTest (GCovFlush)

@end
'''

XCTest+GCovFlush.m
------------------
'''
#import "XCTest+GCovFlush.h"
#import <objc/runtime.h>

extern void __gcov_flush();

@implementation XCTest (GCovFlush)

+ (void)load
{
    Method original, swizzled;
    
    original = class_getInstanceMethod(self, @selector(tearDown));
    swizzled = class_getInstanceMethod(self, @selector(_swizzledTearDown));
    method_exchangeImplementations(original, swizzled);
}

- (void)_swizzledTearDown
{
    if (__gcov_flush) {
        __gcov_flush();
    }
        [self _swizzledTearDown];
}

@end
'''


