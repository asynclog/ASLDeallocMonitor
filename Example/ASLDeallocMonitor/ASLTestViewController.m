//
//  ASLTestViewController.m
//  ASLDeallocMonitor_Example
//
//  Created by infiq on 2017/7/8.
//  Copyright © 2017年 infiniteQin. All rights reserved.
//

#import "ASLTestViewController.h"
#import "ASLTestObject.h"
#import <ASLDeallocMonitor/ASCDeallocMonitor.h>

@interface ASLTestViewController ()
@property (nonatomic, strong) ASLTestObject *testObj;
@property (nonatomic, strong) NSString *testStr;
@end

@implementation ASLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testStr = @"xxx";
    self.testObj = [[ASLTestObject alloc] init];
    self.testObj.testBlock = ^{
        NSLog(@"%@",self.testStr);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[ASCDeallocMonitor monitor] manualEnd];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
