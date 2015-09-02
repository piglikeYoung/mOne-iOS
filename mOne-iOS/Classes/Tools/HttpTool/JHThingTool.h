//
//  JHThingTool.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHBaseTool.h"

@class JHThingParam, JHThingResult;

@interface JHThingTool : JHBaseTool

/**
 *  获取东西数据
 *
 */
+ (void)thingContentWithParam:(JHThingParam *)param success:(void (^)(JHThingResult *result))success failure:(void (^)(NSError *error))failure;

@end
