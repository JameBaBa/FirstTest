//
//  RootViewController.m
//  WeixinPay
//
//  Created by 徐东 on 15/12/3.
//  Copyright © 2015年 徐东. All rights reserved.
/*
 文件说明：SDKExport(SDK出口)、Control（控制）、Helper(助手)
 */

#import "RootViewController.h"
#import "WXApiRequestHandler.h"//微信的请求处理类（这里用支付）
#import "WXApiObject.h"
#import "WXApi.h"
@interface RootViewController ()<UITextFieldDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendPay];
    // Do any additional setup after loading the view.
}
-(void)sendPay
{
    if (![WXApi isWXAppInstalled]) {//判断安没安装微信
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"jame"message:@"请先安装微信客户端再发起支付" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    /*
     注释：
     商家向财付通申请的商家idpartnerId;
     预支付订单prepayId;
     随机串，防重发 nonceStr;
     时间戳，防重发 timeStamp;
     商家根据财付通文档填写的数据和签名 package;
     商家根据微信开放平台文档对数据做的签名sign;
     */
    if (![WXApi isWXAppInstalled]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"云泊"message:@"请先安装微信客户端再发起支付" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = @"1900000109";
    request.prepayId= @"1101000000140415649af9fc314aa427";
    request.package = @"Sign=WXpay";
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    request.timeStamp= @"1397527777";
    request.sign= @"582282d72dd2b03ad892830965f428cb16e7a256";
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:request];//函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持SendAuthReq类型。
}
/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req
{
    //这里写给微信的处理结果的具体内容

}
/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void)onResp:(BaseResp*)resp
{
    //判断是否有这个类
    if ([resp isKindOfClass:[PayResp class]]) {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        PayResp * respons = (PayResp*)resp;
        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errored:%d",respons.errCode];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        switch (respons.errCode) {
            case WXSuccess:
            {
                NSNotification *notification = [NSNotification notificationWithName:@"成功" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];//广播通知
            }
                break;
                
            default:
            {
                NSNotification *notification = [NSNotification notificationWithName:@"失败" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
                break;
        }
    }
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
