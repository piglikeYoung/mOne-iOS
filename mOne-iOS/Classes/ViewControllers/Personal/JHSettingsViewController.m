//
//  JHSettingsViewController.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/31.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHSettingsViewController.h"
#import "JHCommonGroup.h"
#import "JHCommonLabelItem.h"
#import "JHCommonSwitchItem.h"
#import "JHCommonArrowItem.h"

@interface JHSettingsViewController ()

@end

@implementation JHSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = JHSettingDawnViewBGColor;
    
    [self setTitleView];
    
    [self setupGroups];
}



#pragma mark - Private

- (void)setTitleView {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"设置";
    titleLabel.textColor = JHDawnTextColor;
    titleLabel.nightTextColor = JHDawnTextColor;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - private method
/**
 *  初始化模型数据
 */
- (void)setupGroups {
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    group.header = @"浏览设置";
    
    // 2.设置组的所有行数据
    JHCommonSwitchItem *nightItem = [JHCommonSwitchItem itemWithTitle:@"夜间模式切换"];
    
    
    group.items = @[nightItem];
}

- (void)setupGroup1 {
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    group.header = @"缓存处理";
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *cacheItem = [JHCommonArrowItem itemWithTitle:@"清除缓存"];

    group.items = @[cacheItem];
}

- (void)setupGroup2 {
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    group.header = @"更多";
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *iRateItem = [JHCommonArrowItem itemWithTitle:@"去评分"];
    
    JHCommonArrowItem *feedbackItem = [JHCommonArrowItem itemWithTitle:@"反馈"];
    
    JHCommonArrowItem *userProtocol = [JHCommonArrowItem itemWithTitle:@"用户协议"];
    
    JHCommonLabelItem *versionItem = [JHCommonLabelItem itemWithTitle:@"版本号"];
    
    group.items = @[iRateItem, feedbackItem, userProtocol, versionItem];
}



@end
