//
//  JHTabBarController.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHTabBarController.h"
#import "JHNavigationController.h"
#import "JHHomeViewController.h"
#import "JHReadingViewController.h"
#import "JHQuestionViewController.h"
#import "JHThingViewController.h"
#import "JHPersonalViewController.h"
#import "DSNavigationBar.h"
#import "UIImage+Extension.h"

@interface JHTabBarController ()<UITabBarControllerDelegate>

@end

@implementation JHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    self.tabBar.tintColor = JHColor(55, 196, 242);
    
    // 添加所有的子控制器
    [self addAllChildVcs];
    
    // 开启了夜间模式
    if ([[NSUserDefaults standardUserDefaults] boolForKey:APP_THEME_NIGHT_MODE]) {
        [[DSNavigationBar appearance] setNavigationBarWithColor:JHNightNavigationBarColor];
        
        self.tabBar.backgroundImage = [UIImage imageWithColor:JHNightTabBarColor andRect:CGRectMake(0, 0, 1, 1)];
        
        [DKNightVersionManager nightFalling];

    }
    // 未开启
    else {
        [[DSNavigationBar appearance] setNavigationBarWithColor:JHDawnNavigationBarColor];
        
        self.tabBar.backgroundImage = [UIImage imageWithColor:JHDawnTabBarColor andRect:CGRectMake(0, 0, 1, 1)];
    }
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs{
    // 添加子控制器
    
    // 首页
    JHHomeViewController *homeViewController = [[JHHomeViewController alloc] init];
    [self addOneChlildVc:homeViewController title:@"首页" imageName:@"tabbar_item_home" selectedImageName:@"tabbar_item_home_selected"];
    // 文章
    JHReadingViewController *readingViewController = [[JHReadingViewController alloc] init];
    [self addOneChlildVc:readingViewController title:@"文章" imageName:@"tabbar_item_reading" selectedImageName:@"tabbar_item_reading_selected"];
    
    // 问题
    JHQuestionViewController *questionViewController = [[JHQuestionViewController alloc] init];
    [self addOneChlildVc:questionViewController title:@"问题" imageName:@"tabbar_item_question" selectedImageName:@"tabbar_item_question_selected"];
    
    // 东西
    JHThingViewController *thingViewController = [[JHThingViewController alloc] init];
    [self addOneChlildVc:thingViewController title:@"东西" imageName:@"tabbar_item_thing" selectedImageName:@"tabbar_item_thing_selected"];
    
    // 个人
    JHPersonalViewController *personViewController = [[JHPersonalViewController alloc] init];
    [self addOneChlildVc:personViewController title:@"个人" imageName:@"tabbar_item_person" selectedImageName:@"tabbar_item_person_selected"];

}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    
    // 设置标题
    // 相当于同时设置了tabBarItem.title和navigationItem.title
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
//    // 设置tabBarItem的普通文字颜色
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
//    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
//    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    // 设置tabBarItem的选中文字颜色
//    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
//    selectedTextAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
//    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    // 在iOS7中, 会对selectedImage的图片进行再次渲染为蓝色
    // 要想显示原图, 就必须得告诉它: 不要渲染
//    if (iOS7) {
//        // 声明这张图片用原图(别渲染)
//        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    JHNavigationController *nav = [[JHNavigationController alloc] initWithNavigationBarClass:[DSNavigationBar class] toolbarClass:nil];
    [nav.navigationBar setOpaque:YES];
    [nav addChildViewController:childVc];
    [self addChildViewController:nav];
}

@end
