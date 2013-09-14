//
//  AccountTests.m
//  OBJCStateChart
//
//  Created by LeRoy Mattingly on 8/15/13.
//  Copyright (c) 2013 OpenSource. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Account.h"

//extern void __gcov_flush();

@interface AccountTests : XCTestCase

@end

@implementation AccountTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
//    __gcov_flush();
    [super tearDown];
}

- (void)testStates
{
    Account *account = [[Account alloc]init];
    [account setBalance:10.0];
    [account debit:1.0];
    [account credit:1.0];
    XCTAssertTrue([account balance] == 10.0, @"Expected 10.0 balance");
}

@end
