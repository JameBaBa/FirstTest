//
//  PayViewController.m
//  WeixinPay
//
//  Created by 徐东 on 15/12/3.
//  Copyright © 2015年 徐东. All rights reserved.
//

#import "PayViewController.h"
#import "WXApi.h"
@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([WXApi isWXAppInstalled]) {//判断是否安装了微信
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOderPayResult:) name:@"通知" object:nil];//监听
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];//移除通知
}
-(void)getOderPayResult:(NSString *)req
{

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
