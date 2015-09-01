//
//  JHCommonSwitchItem.h
//  黑马微博
//
//  Created by piglikeyoung on 15/4/13.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHCommonItem.h"

typedef enum {
    NightModeSwitch, // 夜间模式开关类型
} SwitchItemType;


@interface JHCommonSwitchItem : JHCommonItem

@property (nonatomic, assign) SwitchItemType switchType;

@end
