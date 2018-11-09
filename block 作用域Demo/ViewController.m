//
//  ViewController.m
//  block 作用域Demo
//
//  Created by 马栋军 on 2018/8/31.
//  Copyright © 2018年 DangDangWang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)bigButton:(UIButton *)sender {
    NSLog(@"==%s",__func__);
}
- (IBAction)smallButton:(id)sender {
    NSLog(@"==%s",__func__);
}

- (void)click1:(UIButton *)sender
{
  NSLog(@"==%s",__func__);
}

- (void)click2:(UIButton *)sender
{
    NSLog(@"==%s",__func__);
}

- (void)test33
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 80, 80);
    [self.view addSubview:btn];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(100, 100, 80, 180);
    [btn addSubview:btn2];
    
}

- (void)test7
{
    NSLog(@"222222222");
}

- (void)test6
{
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"==1");
    }];
    [thread start];
    
    [self performSelectorOnMainThread:@selector(test7) withObject:nil waitUntilDone:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self test6];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self test6];
    
    [self test2];
}

//没有截获自动变量的Block
//打印:__NSGlobalBlock__
//截获自动变量i的Block
//打印：__NSMallocBlock__
- (void)test1
{
    void (^blk)(void) = ^{
        NSLog(@"Stack Block");
    };
    blk();
    NSLog(@"1：%@",[blk class]);// 全局区
    
    int i = 1;
    void (^captureBlk)(void) = ^{
        NSLog(@"Capture:%d", i);
    };
    captureBlk();
    NSLog(@"2：%@",[captureBlk class]);// 堆区
    
    NSLog(@"3：%@", [^{NSLog(@"Stack Block:%d",i);} class]);// 栈区
    
    NSLog(@"4：%@",[^{NSLog(@"123%d",i);} class]);// 栈区
    
}
// 3412001500142797
//打印：blk's Class:__NSMallocBlock__
//打印：Global Block:__NSGlobalBlock__
//打印：Copy Block:__NSMallocBlock__
//打印：Stack Block:__NSStackBlock__
- (void)test2
{
    int count = 0;
    void (^blk)(void) = ^{
        NSLog(@"Stack Block");
    };
    blk = ^(){
        NSLog(@"In Stack:%d", count);
    };
    NSLog(@"blk's Class:%@", [blk class]);
    NSLog(@"Global Block:%@", [^{NSLog(@"Global Block");} class]);
    NSLog(@"Copy Block:%@", [[^{NSLog(@"Copy Block:%d",count);} copy] class]);
    NSLog(@"Stack Block:%@", [^{NSLog(@"Stack Block:%d",count);} class]);
}


@end
