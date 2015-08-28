//
//  JHHomeParam.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHHomeParam.h"
#import "JHTimeTool.h"

@implementation JHHomeParam

- (void)setIndex:(NSNumber *)index {
//    _index = [index copy];
    
    if ([index integerValue] > 9) {
        _strDate = [JHTimeTool stringDateBeforeTodaySeveralDays:[index integerValue]];
        _strRow = @"1";
    } else {
        
        _strDate = [JHTimeTool stringDateFromDate:[NSDate date]];
        _strRow = [@([index integerValue] + 1) stringValue];
    }
}


@end
