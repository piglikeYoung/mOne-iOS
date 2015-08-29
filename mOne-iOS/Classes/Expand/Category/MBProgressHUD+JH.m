//
//  MBProgressHUD+JH.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/29.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "MBProgressHUD+JH.h"

static const NSTimeInterval kDefaultAfterDelay = 1.f;
static const CGFloat kDefaultMagin = 10.f;

@implementation MBProgressHUD (JH)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:kDefaultAfterDelay];
}


#pragma mark 显示错误信息
+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (void)showText:(NSString *)text {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];

    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = kDefaultMagin;
    hud.removeFromSuperViewOnHide = YES;

    [hud hide:YES afterDelay:kDefaultAfterDelay];
}
+ (void)showText:(NSString *)text delay:(NSTimeInterval)delay {
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = kDefaultMagin;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delay];
    
}
+ (void)showText:(NSString *)text toView:(UIView *)view delay:(NSTimeInterval)delay {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = kDefaultMagin;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delay];
}

+ (void)showMessage:(NSString *)message {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    // 隐藏
    [hud hide:YES afterDelay:kDefaultAfterDelay];
}

+ (void)showMessage:(NSString *)message delay:(NSTimeInterval)delay {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    // 隐藏
    [hud hide:YES afterDelay:delay];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)delay{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    // 隐藏
    [hud hide:YES afterDelay:delay];
}

#pragma mark - 隐藏
+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}



@end
