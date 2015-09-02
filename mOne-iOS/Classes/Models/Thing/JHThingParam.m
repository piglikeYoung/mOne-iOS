//
//  JHThingParam.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHThingParam.h"
#import "JHTimeTool.h"

@implementation JHThingParam

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
