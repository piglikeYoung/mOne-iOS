//
//  JHQuestionView.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHQuestionView.h"
#import "JHQuestionInfo.h"
#import "JHTimeTool.h"
#import "JHPraiseView.h"

@interface JHQuestionView()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation JHQuestionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}


- (void)setUpViews {
    [DKNightVersionManager addClassToSet:self.class];
    self.backgroundColor = JHDawnBGViewColor;
    // 设置夜间模式背景色
    self.nightBackgroundColor = JHNightBGViewColor;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.bounds];
    webView.scrollView.showsVerticalScrollIndicator = YES;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scalesPageToFit = NO;
    webView.backgroundColor = JHDawnBGViewColor;
    webView.nightBackgroundColor = JHNightBGViewColor;
    webView.scrollView.backgroundColor = JHDawnBGViewColor;
    webView.scrollView.nightBackgroundColor = JHNightBGViewColor;
    webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    webView.multipleTouchEnabled = NO;
    webView.scrollView.scrollsToTop = YES;
    webView.delegate = self;
    self.webView = webView;
    [self addSubview:webView];
    
    // webView 顶部添加一个 UIView，高度为34，UIView 里面再添加一个 UILabel，x 为15，y 为12，高度为16，左右距离为15，水平垂直居中，系统默认字体，颜色#555555，大小为13。
    UIView *webViewTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, JHTopViewH)];
    webViewTopView.tag = JHTopViewTag;
    webViewTopView.backgroundColor = JHDawnBGViewColor;
    webViewTopView.nightBackgroundColor = JHNightBGViewColor;
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, 0, self.width, kPadding + 6)];
    dateLabel.font = JHSystemFont(13.0);
    dateLabel.textColor = JHDateTextColor;
    dateLabel.nightTextColor = JHDateTextColor;
    self.dateLabel = dateLabel;
    [webViewTopView addSubview:dateLabel];
    [webView.scrollView addSubview:webViewTopView];
}

- (void)setQuestionInfo:(JHQuestionInfo *)questionInfo {
    _questionInfo = questionInfo;
    
    // 如果当前的问题内容没有获取过来，就暂时直接加载该问题对应的官方手机版网页
    if (!_questionInfo.strQuestionId || _questionInfo.strQuestionId.length <= 0) {
        self.dateLabel.superview.hidden = YES;
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.wufazhuce.com/question/%@", _questionInfo.strQuestionMarketTime]]]];
    } else {
        self.dateLabel.superview.hidden = NO;
        self.dateLabel.text = [JHTimeTool enMarketTimeWithOriginalMarketTime:_questionInfo.strQuestionMarketTime];
        
        NSString *webViewBGColor = Is_Night_Mode ? NightWebViewBGColorName : @"#ffffff";
        NSString *webViewContentTextColor = Is_Night_Mode ? NightWebViewTextColorName : DawnWebViewTextColorName;
        NSString *separateLineColor = Is_Night_Mode ? @"#333333" : @"#d4d4d4";
        
        NSMutableString *HTMLString = [[NSMutableString alloc] init];
        // Questin Title
        [HTMLString appendString:[NSString stringWithFormat:@"<body style=\"margin: 0px; background-color: %@;\"><div style=\"margin-bottom: 0px; margin-top: 0px; background-color: %@;\"><div style=\"margin-bottom: 100px; margin-top: 34px;\"><table style=\"width: 100%%;\"><tbody style=\"display: table-row-group; vertical-align: middle; border-color: inherit;\"><tr style=\"display: table-row; vertical-align: inherit;\"><td style=\"width: 84px;\" align=\"center\"><img style=\"width: 42px; height: 42px; vertical-align: middle;\" alt=\"问题\" src=\"http://s2-cdn.wufazhuce.com/m.wufazhuce/images/question.png\" /></td>", webViewBGColor, webViewBGColor]];
        [HTMLString appendString:[NSString stringWithFormat:@"<td><p style=\"margin-top: 0; margin-left: 0; color: %@; font-size: 16px; font-weight: bold;\">%@</p></td></tr></tbody></table>", webViewContentTextColor, _questionInfo.strQuestionTitle]];
        // Question Content
        [HTMLString appendString:[NSString stringWithFormat:@"<div style=\"line-height: 26px; margin-top: 14px;\"><p style=\"margin-left: 20px; margin-right: 20px; margin-bottom: 0; color: %@; text-shadow: none; font-size: 15px;\">%@</p></div>", webViewContentTextColor, _questionInfo.strQuestionContent]];
        // Separate Line
        [HTMLString appendString:[NSString stringWithFormat:@"<div style=\"margin-top: 15px; margin-bottom: 15px; width: 95%%; height: 1px; background-color: %@; margin-left: auto; margin-right: auto;\"></div>", separateLineColor]];
        // Answer Title
        [HTMLString appendString:[NSString stringWithFormat:@"<table style=\"width: 100%%;\"><tbody style=\"display: table-row-group; vertical-align: middle; border-color: inherit;\"><tr style=\"display: table-row; vertical-align: inherit; border-color: inherit;\"><td style=\"width: 84px;\" align=\"center\"><img style=\"width: 42px; height: 42px; vertical-align: middle;\" alt=\"回答\" src=\"http://s2-cdn.wufazhuce.com/m.wufazhuce/images/answer.png\" /></td><td align=\"left\"><p style=\"margin-top: 0; margin-left: 0; color: %@; font-size: 16px; font-weight: bold; margin-right: 20px; margin-bottom: 0; text-shadow: none;\">%@</p></td></tr></tbody></table>", webViewContentTextColor, _questionInfo.strAnswerTitle]];
        // Answer Content
        [HTMLString appendString:[NSString stringWithFormat:@"<div style=\"line-height: 26px; margin-top: 14px;\"><p></p><p style=\"margin-left: 20px; margin-right: 20px; margin-bottom: 0; color: %@; text-shadow: none; font-size: 15px;\">%@</p><p></p></div>", webViewContentTextColor, _questionInfo.strAnswerContent]];
        // Question Editor
        [HTMLString appendString:[NSString stringWithFormat:@"<p style=\"color: #333333; font-style: oblique; margin-left: 20px; margin-right: 20px; margin-bottom: 0; text-shadow: none; font-size: 15px;\">%@</p></div></div></body>", _questionInfo.sEditor]];
        
        [self.webView loadHTMLString:HTMLString baseURL:nil];
    }
    
    [self.webView.scrollView scrollsToTop];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JHPraiseView *praiseView = nil;
    
    if (webView.scrollView.subviews.count < 4) {// 小于4说明还没有添加文章底部的作者详情 view
        // webView 底部添加一个作者的描述视图
        praiseView = [[JHPraiseView alloc] initWithFrame:CGRectMake(0, 0, JHScreenW, 68)];
        praiseView.tag = JHBottomViewTag;
    } else {
        praiseView = (JHPraiseView *)[webView.scrollView viewWithTag:JHBottomViewTag];
    }
    
    // 如果当前的问题内容没有获取过来，就不添加点赞的视图
    if (self.questionInfo.strQuestionId && self.questionInfo.strQuestionId.length > 0) {
        [praiseView setQuestionInfo:self.questionInfo];
        
        CGRect bottomViewFrame = praiseView.frame;
        bottomViewFrame.origin.y = webView.scrollView.contentSize.height - praiseView.height - 39;
        praiseView.frame = bottomViewFrame;
        
        if (!praiseView.superview) {
            [webView.scrollView addSubview:praiseView];
        }
    } else {
        praiseView.hidden = YES;
    }
}

@end
