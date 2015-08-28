//
//  JHTimeTool.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTimeTool.h"

// 1天的秒数
static const NSTimeInterval oneDay = 24 * 60 * 60;

@implementation JHTimeTool

/**
 *  获取距离今天多少天前的日期，传3就是获取3天前的日期
 *
 *  @param days 几天之前
 *
 *  @return 相应天数之前的那天的日期
 */
+ (NSString *)stringDateBeforeTodaySeveralDays:(NSInteger)days {
    
    NSDate *theDate;
    
    if (days != 0) {
        theDate = [[NSDate date] initWithTimeIntervalSinceNow:(-oneDay * days)];
    } else {
        theDate = [NSDate date];
    }
    
    return [JHTimeTool stringDateFromDate:theDate];
}

/**
 *  日期转换为yyyy-MM-dd格式
 *
 */
+ (NSString *)stringDateFromDate:(NSDate *)date {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateformatter stringFromDate:date];
}

@end
