//
//  JHBaseTableViewController.h
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/31.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBaseTableViewController : UITableViewController

// 暴露groups的get方法，.m文件里面做了实现
- (NSMutableArray *)groups;

@end
