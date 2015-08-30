//
//  JHReadingTool.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/30.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHBaseTool.h"

@class JHReadingParam, JHReadingResult;

@interface JHReadingTool : JHBaseTool

/**
 *  获取首页数据
 *
 */
+ (void)readingContentWithParam:(JHReadingParam *)param success:(void (^)(JHReadingResult *result))success failure:(void (^)(NSError *error))failure;

@end
