//
//  JHBaseTableViewController.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/31.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHBaseTableViewController.h"
#import "JHCommonGroup.h"
#import "JHCommonCell.h"
#import "JHCommonItem.h"

@interface JHBaseTableViewController ()
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation JHBaseTableViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

/** 屏蔽tableView的样式 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = JHDawnBGViewColor;
    // 设置夜间模式背景色
    self.tableView.nightBackgroundColor = JHNightBGViewColor;
    self.tableView.separatorColor = JHTableViewCellSeparatorDawnColor;
    self.tableView.nightSeparatorColor = JHNightBGViewColor;
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JHScreenW, 1)];
    // 不显示Cell多余的线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 设置标题栏不能覆盖下面viewcontroller的内容
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    /**
     *  分隔线不缩短15像素
     *
     */
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JHCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHCommonGroup *group = self.groups[indexPath.section];
    return ((JHCommonItem *)group.items[indexPath.row]).itemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHCommonCell *cell = [JHCommonCell cellWithTableView:tableView];
    JHCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    JHCommonGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    JHCommonGroup *group = self.groups[section];
    return group.header;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    JHCommonGroup *group = self.groups[indexPath.section];
    JHCommonItem *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        
        UIViewController *destVc = nil;
        
        // 判断是否根据storyboard创建
        if (item.isInitByStoryBoard) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[NSString stringWithFormat:@"%@", item.destVcClass] bundle:nil];
            destVc = [storyboard instantiateInitialViewController];
        } else {
            destVc = [[item.destVcClass alloc] init];
        }
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
        
    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

@end
