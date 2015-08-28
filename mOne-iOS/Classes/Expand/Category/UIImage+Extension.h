//
//  UIImage+Extension.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据颜色绘制一张图片
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color andRect:(CGRect) rect;

@end
