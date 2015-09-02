//
//  JHCommonCell.m
//  iOSDevTips
//
//  Created by piglikeyoung on 15/8/10.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHCommonCell.h"
#import "JHCommonItem.h"
#import "JHCommonArrowItem.h"
#import "JHCommonSwitchItem.h"
#import "JHCommonLabelItem.h"
#import "UIImage+Extension.h"

@interface JHCommonCell()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;

/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;

@end

@implementation JHCommonCell

#pragma mark - 懒加载右边的view
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        _rightSwitch = [[UISwitch alloc] init];
        [_rightSwitch addTarget:self action:@selector(rightSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.font = JHSystemFont(17);
        _rightLabel.nightBackgroundColor = JHNightBGViewColor;
    }
    return _rightLabel;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    JHCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];

        self.textLabel.textColor = JHDawnTextColor;
        self.textLabel.nightTextColor = JHNightTextColor;
        self.backgroundColor = JHDawnBGViewColor;
        self.nightBackgroundColor = JHNightBGViewColor;
        [DKNightVersionManager addClassToSet:self.class];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整子标题的x
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 3;
}

#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows
{
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:APP_THEME_NIGHT_MODE]) {
//        self.nightBackgroundColor = JHNightBGViewColor;
//    } else {
//        self.backgroundColor = JHDawnBGViewColor;
//    }
}



- (void)setItem:(JHCommonItem *)item
{
    _item = item;
    
    // 1.设置基本数据
    if (item.icon.length > 0) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    // 2.设置右边的内容
    if ([item isKindOfClass:[JHCommonArrowItem class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if ([item isKindOfClass:[JHCommonSwitchItem class]]) {
        JHCommonSwitchItem *switchItem = (JHCommonSwitchItem *)item;
        switch (switchItem.switchType) {
            case NightModeSwitch:
                
                self.rightSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:APP_THEME_NIGHT_MODE];
                break;
                
            default:
                break;
        }
        self.accessoryView = self.rightSwitch;
    } else if ([item isKindOfClass:[JHCommonLabelItem class]]) {
        JHCommonLabelItem *labelItem = (JHCommonLabelItem *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.accessoryView = self.rightLabel;
    } else { // 取消右边的内容
        self.accessoryView = nil;
    }
}

- (void) rightSwitchChanged:(UISwitch *)rightSwitch {
    JHCommonSwitchItem *switchItem = (JHCommonSwitchItem *)self.item;
    switch (switchItem.switchType) {
        case NightModeSwitch:
        {
            if (rightSwitch.isOn) {
                // 夜间模式开启
                [DKNightVersionManager nightFalling];
            } else {
                // 日常模式开启
                [DKNightVersionManager dawnComing];
            }
            
            // 存储到偏好设置
            [[NSUserDefaults standardUserDefaults] setBool:rightSwitch.isOn forKey:APP_THEME_NIGHT_MODE];
        }
            break;
            
        default:
            break;
    }
}


@end
