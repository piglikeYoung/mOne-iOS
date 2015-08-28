//
//  JHHomeTool.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHHomeTool.h"
#import "JHHomeParam.h"
#import "JHHomeResult.h"

@implementation JHHomeTool

+ (void)homeContentWithParam:(JHHomeParam *)param success:(void (^)(JHHomeResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = [kServerUrl stringByAppendingString:@"/getHp_N"];
    
    [self getWithUrl:urlStr param:param resultClass:[JHHomeResult class] success:success failure:failure];
}

@end
