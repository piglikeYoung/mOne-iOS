//
//  JHTimeTool.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHTimeTool : NSObject

/**
 *  获取距离今天多少天前的日期，传3就是获取3天前的日期
 *
 *  @param days 多少天之前
 *
 *  @return 相应天数之前的那天的日期
 */
+ (NSString *)stringDateBeforeTodaySeveralDays:(NSInteger)days;

/**
 *  日期转换为yyyy-MM-dd格式
 *
 */
+ (NSString *)stringDateFromDate:(NSDate *)date;

/**
 *  根据“yyyy-MM-dd”格式的时间获取首页的时间格式（天）和（月、年）用 & 连接，用来切割字符串
 *
 *  @param originalMarketTime originalMarketTime 原数据中的时间
 *
 *  @return 转换之后的时间
 */
+ (NSString *)homeENMarketTimeWithOriginalMarketTime:(NSString *)originalMarketTime;
@end
