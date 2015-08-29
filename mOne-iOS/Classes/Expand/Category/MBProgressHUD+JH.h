//
//  MBProgressHUD+JH.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/29.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (JH)

/**
 *  展示成功消息
 *
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success;

/**
 *  展示失败消息
 *
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showError:(NSString *)error;


/**
 *  展示文字，没菊花转的
 *
 */
+ (void)showText:(NSString *)text;
+ (void)showText:(NSString *)text delay:(NSTimeInterval)delay;
+ (void)showText:(NSString *)text toView:(UIView *)view delay:(NSTimeInterval)delay;

/**
 *  展示文字，有菊花转的
 *
 */
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message delay:(NSTimeInterval)delay;
+ (void)showMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)delay;


+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
