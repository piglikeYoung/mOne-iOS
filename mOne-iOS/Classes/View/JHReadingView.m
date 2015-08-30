//
//  JHReadingView.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/30.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHReadingView.h"
#import "JHTimeTool.h"
#import "JHReadingInfo.h"
#import "JHReadingAuthorView.h"

@interface JHReadingView()<UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation JHReadingView

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
    webView.scrollView.delegate = self;
    self.webView = webView;
    [self addSubview:webView];
    
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, 0, self.width, kPadding + 6)];
    dateLabel.font = JHSystemFont(13.0);
    dateLabel.textColor = JHDateTextColor;
    dateLabel.nightTextColor = JHDateTextColor;
    self.dateLabel = dateLabel;
    [webView.scrollView addSubview:dateLabel];
}

- (void)setReadingInfo:(JHReadingInfo *)readingInfo {
    _readingInfo = readingInfo;
    
    self.dateLabel.text = [JHTimeTool enMarketTimeWithOriginalMarketTime:_readingInfo.strContMarketTime];
    
    NSString *webViewBGColor = Is_Night_Mode ? NightWebViewBGColorName : @"#ffffff";
    NSString *webViewContentTextColor = Is_Night_Mode ? NightWebViewTextColorName : DawnWebViewTextColorName;
    NSString *webViewTitleTextColor = Is_Night_Mode ? NightWebViewTextColorName : @"#5A5A5A";
    NSString *webViewAuthorTitleTextColor = Is_Night_Mode ? @"#575757" : @"#888888";
    
    NSMutableString *HTMLContent = [[NSMutableString alloc] init];
    [HTMLContent appendString:[NSString stringWithFormat:@"<body style=\"margin: 0px; background-color: %@;\"><div style=\"margin-bottom: 10px; background-color: %@;\">", webViewBGColor, webViewBGColor]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章标题 --><p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 34px; margin-left: 15px;\">%@</p>", webViewTitleTextColor, _readingInfo.strContTitle]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章作者 --><p style=\"color: %@; font-size: 14px; font-weight: bold; margin-left: 15px; margin-top: -15px;\">%@</p><p></p>", webViewAuthorTitleTextColor, _readingInfo.strContAuthor]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div>", webViewContentTextColor, _readingInfo.strContent]];
    [HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章责任编辑 --><p style=\"color: %@; font-size: 15px; font-style: oblique; margin-left: 15px;\">%@</p></div></body>", webViewContentTextColor, _readingInfo.strContAuthorIntroduce]];
    
    [self.webView loadHTMLString:HTMLContent baseURL:nil];
    [self.webView.scrollView scrollsToTop];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JHReadingAuthorView *readingAuthorView = nil;
    
    if (webView.scrollView.subviews.count < 4) {// 小于4说明还没有添加文章底部的作者详情 view
        // webView 底部添加一个作者的描述视图
        readingAuthorView = [[JHReadingAuthorView alloc] init];
        readingAuthorView.tag = 20;
    } else {
        readingAuthorView = (JHReadingAuthorView *)[webView.scrollView viewWithTag:20];
    }
    
    // 赋值的时候计算了readingAuthorView的frame
    readingAuthorView.readingInfo = self.readingInfo;
    
    // 获取网页内容的真实高度
    CGFloat webBrowserViewHeight = 0;
    for (id view in webView.scrollView.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")]) {
            webBrowserViewHeight = ((UIView *)view).frame.size.height;
            break;
        }
    }
    
    // webView的scrollView高度增加readingAuthorView.height
    webView.scrollView.contentSize = CGSizeMake(webView.scrollView.contentSize.width, webBrowserViewHeight + readingAuthorView.height);
    
    // 设置作者栏的frame
    readingAuthorView.frame = CGRectMake(0, webView.scrollView.contentSize.height - readingAuthorView.height, JHScreenW, readingAuthorView.height);
    // 添加到webView.scrollView
    if (!readingAuthorView.superview) {
        [webView.scrollView addSubview:readingAuthorView];
    }
}


@end
