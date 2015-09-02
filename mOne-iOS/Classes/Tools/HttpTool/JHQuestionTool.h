//
//  JHQuestionTool.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHBaseTool.h"

@class JHQuestionParam, JHQuestionResult;

@interface JHQuestionTool : JHBaseTool



/**
 *  获取问题数据
 *
 */
+ (void)questionContentWithParam:(JHQuestionParam *)param success:(void (^)(JHQuestionResult *result))success failure:(void (^)(NSError *error))failure;
@end
