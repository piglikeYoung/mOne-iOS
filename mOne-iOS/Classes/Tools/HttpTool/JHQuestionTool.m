//
//  JHQuestionTool.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHQuestionTool.h"
#import "JHQuestionParam.h"
#import "JHQuestionResult.h"

@implementation JHQuestionTool

+ (void)questionContentWithParam:(JHQuestionParam *)param success:(void (^)(JHQuestionResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = [kServerUrl stringByAppendingString:@"/getOneQuestionInfo"];
    
    [self getWithUrl:urlStr param:param resultClass:[JHQuestionResult class] success:success failure:failure];
    
}

@end
