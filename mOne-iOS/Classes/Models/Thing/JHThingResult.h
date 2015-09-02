//
//  JHThingResult.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHBaseResult.h"

@class JHThingInfo;

@interface JHThingResult : JHBaseResult

@property (nonatomic, copy) NSString *rs;

@property (nonatomic, strong) JHThingInfo *entTg;

@end
