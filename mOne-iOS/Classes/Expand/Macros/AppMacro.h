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

#define JHBoldSystemFont(size)  [UIFont boldSystemFontOfSize:size]
#define JHSystemFont(size)      [UIFont systemFontOfSize:size]

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
// 加载图片圈圈颜色
#define LoadingCircleColor JHColor(132, 132, 132) // #848484

//-------------------首页界面宏-------------------
// VOL字体颜色
#define JHVOLTextColor JHColor(85, 85, 85)// #555555

// 作者字体颜色
#define JHPaintInfoTextColor JHColor(85, 85, 85) // #555555
// 天数的字体颜色
#define JHDayTextColor JHColor(55, 194, 241) // #37C2F1
// 月份和年份字体颜色
#define JHMonthAndYearTextColor JHColor(173, 173, 173)// #ADADAD
// 点赞按钮字体颜色
#define JHPraiseBtnTextColor JHColor(80, 80, 80)// #505050
// 右拉刷新字体颜色
#define JHLeftRefreshLabelTextColor JHColor(90, 91, 92)// #5A5B5C

//--------------------文章界面宏----------------------
#define JHAuthorTextViewColor JHColor(51, 51, 51) // #333333
#define JHAuthorTextColor JHColor(90, 91, 92) // #5A5B5C
#define JHAuthorWenNameTextColor JHColor(172, 177, 180)// #ACB1B4
#define JHDateTextColor JHColor(85, 85, 85)// #555555
#define JHNightTextColor JHColor(135, 135, 135) // #878787
#define NightWebViewBGColorName @"#262626"
#define DawnWebViewBGColorName @"#f0f0f0"
#define NightWebViewTextColorName @"#888888"
#define DawnWebViewTextColorName @"#333333"

//--------------------个人界面宏----------------------
#define JHTableViewCellSeparatorDawnColor JHColor(200, 199, 204) // #C8C7CC
#define JHDawnTextColor JHColor(90, 91, 92) // #5A5B5C
#define JHSettingDawnViewBGColor JHColor(235, 235, 235) // #EBEBEB
#define JHDawnCellHeaderTextColor JHColor(85, 85, 85)// #555555
#define JHNightCellHeaderTextColor JHColor(75, 75, 75)// #4B4B4B



//--------------------http接口---------------
// 获取首页内容接口地址
#define URL_GET_HOME_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/getHp_N"
// 获取文章接口地址
#define URL_GET_READING_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/getOneContentInfo"
// 获取问题接口地址
#define URL_GET_QUESTION_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/getOneQuestionInfo"
// 获取问题后援接口地址 (What the f**k! 日了狗了，试了几次不同日期，获取过来都是最新一天的(也就是今天))，没办法，只能显示一个官方的手机版网页了
//#define URL_BACKUP_GET_QUESTION_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/getQ_N"
// 获取东西接口地址
#define URL_GET_THING_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/o_f"


//-------------------夜间模式标示符----------------
#define Is_Night_Mode [DKNightVersionManager currentThemeVersion] == DKThemeVersionNight
// 保存到偏好设置
#define APP_THEME_NIGHT_MODE @"Night_Mode_Is_On"


#endif
