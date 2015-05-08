//
//  ViewController.m
//  demo
//
//  Created by shaw on 15/5/8.
//  Copyright (c) 2015年 shaw. All rights reserved.
//

#import "ViewController.h"
#import "ZSDProgressCircleView.h"
#import "ZSDClockProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    
//    ZSDProgressCircleView *circle1 = [[ZSDProgressCircleView alloc]initWithFrame:CGRectMake(50, 20, 200, 200)];
////    circle1.title = @"请填写标题1";
////    circle1.detailText = @"请填写副标题1";
//    circle1.progressType = ZSDCircleProgressTypeValue1;
//    circle1.progress = 0.6f;
//    [self.view addSubview:circle1];
//    
//    ZSDProgressCircleView *circle2 = [[ZSDProgressCircleView alloc]initWithFrame:CGRectMake(50, 250, 200, 200)];
////    circle2.title = @"请填写标题2";
////    circle2.detailText = @"请填写副标题2";
//    circle2.progressType = ZSDCircleProgressTypeValue2;
//    circle2.progress = 0.6f;
//    [self.view addSubview:circle2];
    
    ZSDProgressCircleView *circle3 = [[ZSDProgressCircleView alloc]initWithFrame:CGRectMake(50, 20, 200, 200)];
//    circle3.title = @"请填写标题3";
//    circle3.detailText = @"请填写副标题3";
    circle3.progressType = ZSDCircleProgressTypeValue3;
    circle3.progress = 0.6f;
    [self.view addSubview:circle3];
    
    
    ZSDClockProgressView *clock = [[ZSDClockProgressView alloc]initWithFrame:CGRectMake(50, 250, 200, 200)];
    clock.bigCircleRadiu = 3.0f;
    clock.selectedColor = [UIColor redColor];
    clock.progress = 0.6f;
    [self.view addSubview:clock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
