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


static const CGFloat kTableViewCellHeaderViewH = 35;

@interface JHSettingsViewController ()

@property (nonatomic, strong) NSArray *sectionHeaderTexts;

@end

@implementation JHSettingsViewController

- (NSArray *)sectionHeaderTexts {
    if (!_sectionHeaderTexts) {
        _sectionHeaderTexts = @[@"浏览设置", @"缓存设置", @"更多", @""];
    }
    return _sectionHeaderTexts;
}


/** 屏蔽父类的样式，改为平铺的样式 */
- (id)init {
    return [self initWithStyle:UITableViewStylePlain];
}

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
    
    // 2.设置组的所有行数据
    JHCommonSwitchItem *nightItem = [JHCommonSwitchItem itemWithTitle:@"夜间模式切换"];
    nightItem.switchType = NightModeSwitch;
    
    group.items = @[nightItem];
}

- (void)setupGroup1 {
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *cacheItem = [JHCommonArrowItem itemWithTitle:@"清除缓存"];

    group.items = @[cacheItem];
}

- (void)setupGroup2 {
    // 1.创建组
    JHCommonGroup *group = [JHCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    JHCommonArrowItem *iRateItem = [JHCommonArrowItem itemWithTitle:@"去评分"];
    
    JHCommonArrowItem *feedbackItem = [JHCommonArrowItem itemWithTitle:@"反馈"];
    
    JHCommonArrowItem *userProtocol = [JHCommonArrowItem itemWithTitle:@"用户协议"];
    
    JHCommonLabelItem *versionItem = [JHCommonLabelItem itemWithTitle:@"版本号"];
    versionItem.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    group.items = @[iRateItem, feedbackItem, userProtocol, versionItem];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kTableViewCellHeaderViewH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JHScreenW, kTableViewCellHeaderViewH)];
    headerView.backgroundColor = JHDawnNavigationBarColor;
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, headerView.width - 20, headerView.height)];
    headerLabel.text = self.sectionHeaderTexts[section];
    headerLabel.textColor = JHDawnCellHeaderTextColor;
    headerLabel.nightTextColor = JHNightCellHeaderTextColor;
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    [headerView addSubview:headerLabel];
    headerView.nightBackgroundColor = JHNightBGViewColor;
    
    return headerView;
}



@end
