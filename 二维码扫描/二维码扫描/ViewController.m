//
//  ViewController.m
//  二维码扫描
//
//  Created by 刘硕 on 16-1-25.
//  Copyright (c) 2016年 北京千锋互联科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <ZBarSDK.h>
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZBarReaderViewDelegate>
//扫描窗口
@property (nonatomic,strong)ZBarReaderView * readerView;

@property (nonatomic,strong)UIView * scanView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)readerControllerClick:(UIButton *)sender {
    ZBarReaderController * controller = [[ZBarReaderController alloc]init];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}
//成功
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取扫描结果
    NSLog(@"扫描成功");
    //得到结果
    id<NSFastEnumeration> results = info[ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    //最后得到的结果
    NSLog(@"扫描结果:%@",symbol.data);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ZBReaderView
/*
- (instancetype)init{
    if (self = [super init]) {
        //二维码扫描操作
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //没有在该方法中进行设置
    }
    return self;
}
 */
- (IBAction)ReaderViewClick:(UIButton *)sender {
    _readerView = [[ZBarReaderView alloc]init];
    _readerView.frame = CGRectMake(20, 100, self.view.bounds.size.width - 40, 300);
    _readerView.readerDelegate = self;
    _readerView.tracksSymbols = YES;//跟随边框
    _readerView.torchMode = 1;//闪光灯 0 表示关闭 1 表示开启
    [self.view addSubview:_readerView];
    [_readerView start];//开始扫描
}
#pragma mark ZBReaderViewDelegate
-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    const zbar_symbol_t *symbol = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    NSString *symbolStr = [NSString stringWithUTF8String:zbar_symbol_get_data(symbol)];
    NSLog(@"%@",symbolStr);
    [_readerView stop];//停止扫描
    [_readerView removeFromSuperview];//将视图移除
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
