//
//  JHReadingParam.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/30.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHReadingParam.h"
#import "JHTimeTool.h"

@implementation JHReadingParam

- (void)setIndex:(NSNumber *)index {
    //    _index = [index copy];
    
    _strDate = [JHTimeTool stringDateBeforeTodaySeveralDays:[index integerValue]];
    _strLastUpdateDate = [JHTimeTool stringDateBeforeTodaySeveralDays:0];

}

@end
