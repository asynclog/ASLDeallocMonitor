//
//  ASLViewController.m
//  ASLDeallocMonitor
//
//  Created by infiniteQin on 07/08/2017.
//  Copyright (c) 2017 infiniteQin. All rights reserved.
//

#import "ASLViewController.h"
#import "ASLTestViewController.h"


@interface ASLViewController ()

@end

@implementation ASLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)btnAction:(UIButton *)sender {
    ASLTestViewController *testVC = [[ASLTestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
