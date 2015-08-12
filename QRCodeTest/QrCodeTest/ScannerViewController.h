//
//  ScannerViewController.h
//  QrCodeTest
//
//  Created by tarena231 on 15/8/11.
//  Copyright (c) 2015年 Draconis Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScannerViewController : UIViewController<ZXCaptureDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeIV;
@property (weak, nonatomic) IBOutlet UILabel *result;


@end
