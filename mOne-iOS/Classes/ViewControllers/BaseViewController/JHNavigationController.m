//
//  JHNavigationController.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHNavigationController.h"

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
    textAttrs[UITextAttributeFont]=[UIFont systemFontOfSize:15];
    //这是偏移量为0
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    //设置颜色为橙色
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    //2.设置高亮状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[UITextAttributeTextColor] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    
    //3.设置不可用状态下文字的属性
    //使用1中的textAttrs进行通用设置
    NSMutableDictionary *disabletextAttrs=[NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //设置颜色为灰色
    disabletextAttrs[UITextAttributeTextColor]=[UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];

    //4.设置小图标颜色
    [appearance setTintColor:JHColorRGBA(100, 100, 100, 0.9)];
}



/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只有第一次push的控制器显示bottomBar，别的都隐藏
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 导航栏的左上角和右上角按钮
//        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(back)];
//        viewController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(]UIBarButtonSystemItem target:<#(id)#> action:<#(SEL)#>];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}


@end
