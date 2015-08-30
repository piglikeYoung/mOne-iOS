//
//  JHHomeTool.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHBaseTool.h"

@class JHHomeParam, JHHomeResult;

@interface JHHomeTool : JHBaseTool

/**
 *  获取首页数据
 *
 */
+ (void)homeContentWithParam:(JHHomeParam *)param success:(void (^)(JHHomeResult *result))success failure:(void (^)(NSError *error))failure;

@end
