//
//  AppMacro.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#ifndef mOne_iOS_AppMacro_h
#define mOne_iOS_AppMacro_h


//-------------调试相关------------
#ifdef DEBUG // 调试状态, 打开LOG功能
#define JHLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define JHLog(...)
#endif

// 随机色
#define JHRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

// 颜色
#define JHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JHColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 是否为iOS8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

// 屏幕尺寸
#define JHScreenW [UIScreen mainScreen].bounds.size.width
#define JHScreenH [UIScreen mainScreen].bounds.size.height
#define JHScreenBounds [UIScreen mainScreen].bounds


//----------------界面设置相关---------------
// 全局背景色
#define JHGlobalBg JHColor(211, 211, 211)

// 导航栏标题的字体
#define JHNavigationTitleFont [UIFont boldSystemFontOfSize:20]

// App 主题模式是否开启夜间模式
#define APP_THEME_NIGHT_MODE @"Night_Mode_Is_On"

// Controller的View的背景色
// 夜间模式
#define JHNightBGViewColor JHColor(38, 38, 39) // #262626
// 日常模式
#define JHDawnBGViewColor  [UIColor whiteColor]// #白色

// NavigationBar的背景色
// 夜间模式
#define JHNightNavigationBarColor JHColor(32, 32, 34) // #202020
// 日常模式
#define JHDawnNavigationBarColor JHColor(236, 236, 236) // #ECECEC

// TabBar的背景色
// 夜间模式
#define JHNightTabBarColor JHColor(48, 48, 49)
// 日常模式
#define JHDawnTabBarColor JHColor(240, 240, 240)


#endif
