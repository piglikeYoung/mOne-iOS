//
//  JHNavigationController.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "DSNavigationBar.h"

@interface JHNavigationController ()

@end

@implementation JHNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 清空弹出手势的代理，就可以恢复弹出手势
    self.interactivePopGestureRecognizer.delegate = nil;
    
    // 监听夜间模式按钮通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:DKNightVersionNightFallingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:DKNightVersionDawnComingNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:DKNightVersionNightFallingNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:DKNightVersionDawnComingNotification];
}


/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    //设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
    
    //设置UINavigationBar的主题
    [self setupNavigationBarTheme];
    
}

/**
 *设置UINavigationBar的主题
 */
+ (void)setupNavigationBarTheme
{
    
    //通过设置appearance对象，能够修改整个项目中所有UINavigationBar的样式
    UINavigationBar *appearance=[UINavigationBar appearance];
    
    
    //设置文字属性
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    //设置字体颜色
    textAttrs[UITextAttributeTextColor]=[UIColor blackColor];
    //设置字体
    textAttrs[UITextAttributeFont]=JHNavigationTitleFont;
    //设置字体的偏移量（0）
    //说明：UIOffsetZero是结构体，只有包装成NSValue对象才能放进字典中
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
}


/**
 *设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    //通过设置appearance对象，能够修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance=[UIBarButtonItem appearance];
    
    //设置文字的属性
    //1.设置普通状态下文字的属性
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    //设置字体
    textAttrs[UITextAttributeFont]=[UIFont fontWithName:@"HelveticaNeue-Medium" size:15];
    //这是偏移量为0
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    //设置颜色
    textAttrs[UITextAttributeTextColor] = JHDawnTextColor;
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    //2.设置高亮状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[UITextAttributeTextColor] = JHDawnTextColor;
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    
    //3.设置不可用状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *disabletextAttrs=[NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //设置颜色为灰色
    disabletextAttrs[UITextAttributeTextColor]=[UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];

}

// 拦截每次添加子控制器
- (void)addChildViewController:(UIViewController *)childController {
    
    // 显示导航栏上的《一个》图标
    childController.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navLogo"]];
    
    // 初始化导航栏右侧的分享按钮
    UIBarButtonItem *shareItem = [UIBarButtonItem itemWithImageName:@"nav_share_btn_normal" highImageName:@"nav_share_btn_highlighted" target:self action:@selector(shareItemClick)];
    
    
    childController.navigationItem.rightBarButtonItem = shareItem;
    
    [super addChildViewController:childController];
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只有第一次push的控制器显示bottomBar，别的都隐藏
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void) shareItemClick {
    
}

#pragma mark - 夜间模式
- (void)nightModeSwitch:(NSNotification *)notification {
    if (Is_Night_Mode) {
        [[DSNavigationBar appearance] setNavigationBarWithColor:JHNightNavigationBarColor];
    } else {
        [[DSNavigationBar appearance] setNavigationBarWithColor:JHDawnNavigationBarColor];
    }
}


@end
