XCode5gcovPatch
===============

Provides patches for XCTests, or SenTests and a patch for UIAutomation coverage. The patches force gcov 
to flush its results to .gcda files. 

Unit Tests:
XCTests use the new testing framework from Apple. But if you have old SenTests you 
have not converted to XCTest, then use the SenTest patch.

Functional UI Tests:
Use the UIApplication+GCovFlush patch to force gcov to write .gcda files when you put the app in the background. You put the
app in the background on the simulator by pressing the cmd+shift+H. Note: UIAutomation tests will not generate coverage 
files when run on a device but will generate them when run on the simulator. 

Make sure to add this line at the bottom of your UIAutomation .js scripts to your to force the app into the background so 
you can get gcov to generate the .gcda files. (See included sample project for an example of this.)

UIATarget.localTarget().deactivateAppForDuration(1);




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




