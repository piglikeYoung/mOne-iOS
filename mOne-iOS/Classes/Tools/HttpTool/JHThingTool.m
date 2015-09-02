//
//  JHThingTool.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHThingTool.h"
#import "JHThingParam.h"
#import "JHThingResult.h"


@implementation JHThingTool

+ (void)thingContentWithParam:(JHThingParam *)param success:(void (^)(JHThingResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = [kServerUrl stringByAppendingString:@"/o_f"];
    
    [self getWithUrl:urlStr param:param resultClass:[JHThingResult class] success:success failure:failure];
    
}

@end
