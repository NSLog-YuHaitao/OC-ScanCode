//
//  ViewController.m
//  QREncoderDemo
//
//  Created by qianfeng on 13-4-7.
//  Copyright (c) 2013年 PK. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     1、前往cocosPod导入libqrencode三方库
     2、再去添加QRCodeGenerator该类即可使用
     */
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 220, 220)];
    [self.view addSubview:imageView];
    [imageView release];
    imageView.image = [QRCodeGenerator qrImageForString:@"四川四千人同吃烤羊排破记录" imageSize:imageView.bounds.size.width];
}


@end
