//
//  JHQuestionParam.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHQuestionParam.h"
#import "JHTimeTool.h"

@implementation JHQuestionParam

- (void)setIndex:(NSNumber *)index {
    //    _index = [index copy];
    
    _strDate = [JHTimeTool stringDateBeforeTodaySeveralDays:[index integerValue]];
    _strLastUpdateDate = [JHTimeTool stringDateBeforeTodaySeveralDays:0];
    
}

@end
