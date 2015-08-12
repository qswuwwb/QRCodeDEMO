//
//  HomeViewController.m
//  QrCodeTest
//
//  Created by tarena231 on 15/8/11.
//  Copyright (c) 2015年 Draconis Software. All rights reserved.
//

#import "HomeViewController.h"
#import "CreateQRCodeViewController.h"
#import "ScannerViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (IBAction)goToNextPage:(UIButton*)sender {
    CreateQRCodeViewController *createVC = [self.storyboard instantiateViewControllerWithIdentifier:@"create"];
    ScannerViewController *scannerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"scanner"];
    if (sender.tag == 0) {
        [self.navigationController pushViewController:createVC animated:YES];
    }
    else{
        [self.navigationController pushViewController:scannerVC animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
