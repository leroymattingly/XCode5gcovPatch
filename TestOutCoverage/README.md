TestOutCoverage
===============

There are multiple workflows developing, testing, and checking coverage. Below is only a single example.


Example Workflow:
--------

1.) Build the sample app TestOutCoverage in XCode 5.
2.) Code the model objects and write XCTests for the model. (TDD works well for model classes)
3.) Run unit tests (individually or all).
4.) Launch CoverStory and open







See the following XCode Project for an example of using the patch(es). 

<a href="https://github.com/leroymattingly/XCode5gcovPatch/tree/master/TestOutCoverage">TestOutCoverage</a>



Force Code Coverage for UIAutomation Tests:
-------------------------------------------

The following code will force gcov to flush its metrics when the iOS app enters the background 
(command shit H in the simulator).

### UIApplication+GCovFlush.h

    #import <UIKit/UIKit.h>
    
    @interface UIApplication (GCovFlush)
    @end

    

### UIApplication+GCovFlush.m

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
        [[NSNotificationCenter defaultCenter] addObserver:self 
            selector:@selector(forceGcovFlush) 
            name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    
    @end



Force Code Coverage for Unit XCTests:
-------------------------------------


### XCTest+GCovFlush.h

    #import <XCTest/XCTest.h>
    
    @interface XCTest (GCovFlush)
    
    @end


### XCTest+GCovFlush.m

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

Force Code Coverage for Unit SenTests:
-------------------------------------
### SenTest+GCovFlush.h
    @interface SenTest (GCovFlush)
    
    @end

### SenTest+GCovFlush.m

    #import "SenTest+GCovFlush.h"
    #import <objc/runtime.h>
    
    extern void __gcov_flush();
    
    @implementation SenTest (GCovFlush)
    
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




