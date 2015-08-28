//
//  AppDelegate.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "AppDelegate.h"
#import "JHTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    
    JHTabBarController *rootTabBar = [[JHTabBarController alloc] init];
    
    self.window.rootViewController = rootTabBar;
    
    // 2.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
