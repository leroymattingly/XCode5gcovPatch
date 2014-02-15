//
//  UIApplication+GCovFlush.m
//  TestOutCoverage
//
//  Created by LeRoy Mattingly on 9/12/13.
//  Copyright (c) 2013 OpenSource. All rights reserved.
//

#import "UIApplication+GCovFlush.h"

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
