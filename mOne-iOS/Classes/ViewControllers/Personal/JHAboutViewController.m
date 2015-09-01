//
//  JHAboutViewController.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/31.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHAboutViewController.h"

@interface JHAboutViewController ()

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation JHAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JHDawnBGViewColor;
    // 设置夜间模式背景色
    self.view.nightBackgroundColor = JHNightBGViewColor;

    [self setTitleView];
    
    [self setupWebView];
    
}

- (void)setTitleView {
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"关于";
    titleLabel.textColor = JHDawnTextColor;
    titleLabel.nightTextColor = JHDawnTextColor;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.scalesPageToFit = NO;
    webView.multipleTouchEnabled = NO;
    webView.exclusiveTouch = NO;
    webView.scrollView.scrollsToTop = YES;
    webView.scrollView.backgroundColor = JHDawnBGViewColor;
    webView.scrollView.nightBackgroundColor = JHNightBGViewColor;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.wufazhuce.com/about?from=ONEApp"]]];
    [self.view addSubview:webView];
    self.webView = webView;
}

@end
