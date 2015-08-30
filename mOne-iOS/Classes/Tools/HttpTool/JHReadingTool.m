//
//  JHReadingTool.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/30.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHReadingTool.h"
#import "JHReadingParam.h"
#import "JHReadingResult.h"

@implementation JHReadingTool

+ (void)readingContentWithParam:(JHReadingParam *)param success:(void (^)(JHReadingResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = [kServerUrl stringByAppendingString:@"/getOneContentInfo"];
    
    [self getWithUrl:urlStr param:param resultClass:[JHReadingResult class] success:success failure:failure];
    
}

@end
