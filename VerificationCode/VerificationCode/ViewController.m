//
//  ViewController.m
//  VerificationCode
//
//  Created by 55it on 2018/12/21.
//  Copyright © 2018年 55it. All rights reserved.
//

#import "ViewController.h"
#import "VerificationCodeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    VerificationCodeView *codeView = [[VerificationCodeView alloc]initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width-20, 90) WithInputNum:6];
    
    codeView.lineColor = [UIColor redColor];
    codeView.textColor = [UIColor blueColor];
    codeView.verCodeBlock = ^(NSString * _Nonnull verCode) {
        NSLog(@"%@",verCode);
    };
    [self.view addSubview:codeView];
    
    
}


@end
