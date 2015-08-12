/*
 * Copyright 2012 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "CreateQRCodeViewController.h"

@implementation CreateQRCodeViewController

- (IBAction)updatePressed:(id)sender {
    [self.textView resignFirstResponder];
    
    NSString *data = self.textView.text;
    if (data == 0) return;
    //对NSString编码，并设置二维码的大小
    ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc] init];
    ZXBitMatrix *result = [writer encode:data
                                  format:kBarcodeFormatQRCode
                                   width:self.imageView.frame.size.width
                                  height:self.imageView.frame.size.width
                                   error:nil];
    
    if (result) {
        //用编码后的result得到图片
        ZXImage *imageZX = [ZXImage imageWithMatrix:result];
        UIImage *image = [UIImage imageWithCGImage:imageZX.cgimage];
        //显示
        self.imageView.image = image;
        //设置图片的保存路径并保存
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = paths[0];
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"1.png"];
        
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    } else {
        self.imageView.image = nil;
    }
}

@end
