//
//  Account.m
//
//  Created by LeRoy Mattingly on 8/10/13.
//  Copyright (c) 2013 OpenSource. All rights reserved.
//

#import "Account.h"

@implementation Account

-(void)debit:(double)amount
{
    self.balance -= amount;
}

-(void)credit:(double)amount
{
    self.balance += amount;
}




@end
