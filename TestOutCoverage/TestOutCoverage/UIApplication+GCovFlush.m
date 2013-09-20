//
//  UIApplication+GCovFlush.m
//
//  Use this patch to force gcov to write .gcda (results) files when you put the app in
//  the background - cmd+shift+H on the simulator. 
//
//  Created by LeRoy Mattingly on 9/12/13.
//  Copyright (c) 2013 OpenSource. All rights reserved.
//

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
