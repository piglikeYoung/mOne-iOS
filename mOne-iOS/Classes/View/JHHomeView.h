//
//  JHHomeView.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHHomeInfo;

@interface JHHomeView : UIView

/**
 *  按照给定的数据显示视图
 *
 *  @param homeEntity 要显示的数据
 *  @param animated   是否需要图片的加载动画
 */
- (void)configureViewWithHomeEntity:(JHHomeInfo *)homeInfo animated:(BOOL)animated;

@property (nonatomic, weak) JHHomeInfo *homeInfo;

@end
