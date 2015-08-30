//
//  JHReadingResult.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/30.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHBaseResult.h"

@class JHReadingInfo;

@interface JHReadingResult : JHBaseResult

@property (nonatomic, strong) JHReadingInfo *contentEntity;

@end
