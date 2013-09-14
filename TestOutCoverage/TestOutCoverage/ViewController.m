//
//  ViewController.m
//  TestOutCoverage
//
//  Created by LeRoy Mattingly on 8/16/13.
//  Copyright (c) 2013 OpenSource. All rights reserved.
//

#import "ViewController.h"
#import "Account.h"

@interface ViewController ()
@property Account *account;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@end

@implementation ViewController
{
    NSNumberFormatter *moneyFormatter;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	_account = [[Account alloc] init];
    moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
}

- (IBAction)credit:(UITextField *)sender
{
    double amount = [sender.text doubleValue];
    [self.account credit:amount];
    [self updateBalance];
    sender.text = @"";
}

- (IBAction)debit:(UITextField *)sender
{
    double amount = [sender.text doubleValue];
    [self.account debit:amount];
    [self updateBalance];
    sender.text = @"";
}

- (void)updateBalance
{
    NSString *display = [moneyFormatter stringFromNumber:[NSNumber numberWithDouble:self.account.balance]];
    if (self.account.balance < 0.0)
        [self.balance setTextColor:[UIColor redColor]];
    else
        [self.balance setTextColor:[UIColor blackColor] ];

    [self.balance setText:display];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
