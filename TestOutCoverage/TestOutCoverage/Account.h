//
//  Account.h
//
//  Created by LeRoy Mattingly on 8/10/13.
//  Copyright (c) 2013 OpenSource. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject
@property (nonatomic, assign) int accountNumber;
@property (nonatomic, assign) double balance;
@property (nonatomic, strong) NSDate *lastUpdate;

-(void)debit:(double)amount;
-(void)credit:(double)amount;

@end
