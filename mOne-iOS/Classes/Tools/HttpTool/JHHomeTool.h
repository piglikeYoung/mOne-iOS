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
 *  @param index   要展示数据的 Item 的下标
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */
+ (void)homeContentWithParam:(JHHomeParam *)param success:(void (^)(JHHomeResult *result))success failure:(void (^)(NSError *error))failure;

@end
