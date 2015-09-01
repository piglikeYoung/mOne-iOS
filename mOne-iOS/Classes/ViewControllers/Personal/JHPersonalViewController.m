//
//  JHPersonalViewController.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHPersonalViewController.h"
#import "JHSettingsViewController.h"
#import "JHAboutViewController.h"
#import "JHCommonGroup.h"
#import "JHCommonArrowItem.h"

static NSString *const AccountCellID = @"AccountCell";
static NSString *const OtherCellID = @"OtherCell";

@interface JHPersonalViewController ()

@end

@implementation JHPersonalViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupGroups];
    
    // 监听夜间模式按钮通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:DKNightVersionNightFallingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:DKNightVersionDawnComingNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - private method
/**
 *  初始化模型数据
 */
- (void)setupGroups {
    [self setupGroup0];
}

- (void)setupGroup0
{
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *userItem = [JHCommonArrowItem itemWithTitle:@"杨小胖zz"];
    userItem.icon = @"person_icon";
    userItem.itemHeight = 65;
    
    JHCommonArrowItem *settingItem = [JHCommonArrowItem itemWithTitle:@"设置"];
    settingItem.icon = @"setting";
    settingItem.itemHeight = 65;
    settingItem.destVcClass = [JHSettingsViewController class];
    
    JHCommonArrowItem *aboutItem = [JHCommonArrowItem itemWithTitle:@"关于"];
    aboutItem.icon = Is_Night_Mode ? @"copyright_nt" : @"copyright";
    aboutItem.itemHeight = 65;
    aboutItem.destVcClass = [JHAboutViewController class];
    
    
    group.items = @[userItem, settingItem, aboutItem];
}

#pragma mark - 夜间模式
- (void)nightModeSwitch:(NSNotification *)notification {
    [self.tableView reloadData];
}




@end
