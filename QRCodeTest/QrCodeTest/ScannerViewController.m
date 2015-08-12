//
//  ScannerViewController.m
//  QrCodeTest
//
//  Created by tarena231 on 15/8/11.
//  Copyright (c) 2015年 Draconis Software. All rights reserved.
//

#import "ScannerViewController.h"

@interface ScannerViewController ()
@property (nonatomic, strong) ZXCapture *capture;
@end

@implementation ScannerViewController

//初始化捕捉属性
- (ZXCapture *)capture{
    if (!_capture) {
        ZXCapture *capture = [[ZXCapture alloc] init];
        capture.camera = self.capture.back;
        capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        capture.rotation = 90.0f;
        capture.layer.frame = self.view.bounds;
        _capture = capture;
    }
    return _capture;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)fromCanmera:(id)sender {
    //设置代理对象，设置扫描框
    [self.view.layer addSublayer:self.capture.layer];
    [self.view.layer addSublayer:self.capture.layer];
    [self.view bringSubviewToFront:self.QRCodeIV];
    [self.view bringSubviewToFront:self.result];
    
    self.capture.delegate = self;
    self.capture.layer.frame = self.view.bounds;
    
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(self.QRCodeIV.frame, captureSizeTransform);
}

- (IBAction)fromImage:(id)sender {
    //加载图片
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = paths[0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"1.png"];
    
    UIImage *imageToDecode = [[UIImage alloc] initWithContentsOfFile:filePath];
    self.QRCodeIV.image = imageToDecode;
    
    //解码
    
    ZXLuminanceSource *source =     [[ZXCGImageLuminanceSource alloc] initWithCGImage:[imageToDecode CGImage]];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    self.result.text = result.text;
}


- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;
    
    // 得到结果后回主线程显示
    NSString *display = [NSString stringWithFormat:@"Contents:\n%@", result.text];
    [self.result performSelectorOnMainThread:@selector(setText:) withObject:display waitUntilDone:YES];
    
    [self.capture stop];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.capture start];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
