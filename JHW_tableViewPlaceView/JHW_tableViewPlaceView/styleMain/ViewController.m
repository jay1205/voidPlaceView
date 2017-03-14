//
//  ViewController.m
//  JHW_tableViewPlaceView
//
//  Created by JHW on 17/3/14.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "ViewController.h"
#import "JHWPlaceHoderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, self.view.frame.size.width - 200, 50)];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:btn];
    
    JHWPlaceHoderViewController *vc = [[JHWPlaceHoderViewController alloc]init];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
