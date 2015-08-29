//
//  JHHomeView.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHHomeView.h"
#import "CustomImageView.h"
#import "JHHomeInfo.h"
#import "JHTimeTool.h"

@interface JHHomeView()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UILabel *volLabel;
@property (nonatomic, weak) CustomImageView *paintImageView;
@property (nonatomic, weak) UILabel *paintNameLabel;
@property (nonatomic, weak) UILabel *paintAuthorLabel;
@property (nonatomic, weak) UILabel *dayLabel;
@property (nonatomic, weak) UILabel *monthAndYearLabel;
@property (nonatomic, weak) UIImageView *contentBGImageView;
@property (nonatomic, weak) UITextView *contentTextView;
@property (nonatomic, weak) UIButton *praiseNumberBtn;
@end

@implementation JHHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupViews];
    }
    return self;
}

- (void) setupViews {
    [DKNightVersionManager addClassToSet:self.class];
    self.backgroundColor = JHDawnBGViewColor;
    // 设置夜间模式背景色
    self.nightBackgroundColor = JHNightBGViewColor;
    
    // 初始化 ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.alwaysBounceVertical = YES;
    scrollView.backgroundColor = JHDawnBGViewColor;
    scrollView.nightBackgroundColor = JHNightBGViewColor;
    scrollView.scrollsToTop = YES;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 初始化容器视图
    UIView *containerView = [[UIView alloc] init];
    [scrollView addSubview:containerView];
    containerView.backgroundColor = JHDawnBGViewColor;
    containerView.nightBackgroundColor = JHNightBGViewColor;
    self.containerView = containerView;
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    // 初始化 VOL 文字控件
    UILabel *volLabel = [[UILabel alloc] init];
    volLabel.font = JHSystemFont(13);
    volLabel.textColor = JHVOLTextColor;
    volLabel.nightTextColor = JHVOLTextColor;
    volLabel.backgroundColor = JHDawnBGViewColor;
    volLabel.nightBackgroundColor = JHNightBGViewColor;
    [containerView addSubview:volLabel];
    self.volLabel = volLabel;
    [volLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.top.equalTo(containerView.mas_top).with.offset(kPadding);
        make.right.equalTo(containerView.mas_right).with.offset(-kPadding);
        make.height.mas_equalTo(16);
    }];
    
    // 初始化显示画控件
    CustomImageView *paintImageView = [[CustomImageView alloc] init];
    paintImageView.backgroundColor = [UIColor whiteColor];
    paintImageView.nightBackgroundColor = JHNightBGViewColor;
    [containerView addSubview:paintImageView];
    CGFloat paintWidth = JHScreenW - kPadding * 2;
    CGFloat paintHeight = paintWidth * 0.75;
    self.paintImageView = paintImageView;
    [paintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(volLabel.mas_bottom).with.offset(kPadding);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.right.equalTo(containerView.mas_right).with.offset(-kPadding);
        make.height.mas_equalTo(paintHeight);
    }];
    
    // 初始化画名文字控件
    UILabel *paintNameLabel = [[UILabel alloc] init];
    paintNameLabel.textColor = JHPaintInfoTextColor;
    paintNameLabel.nightTextColor = JHPaintInfoTextColor;
    paintNameLabel.font = JHSystemFont(12);
    paintNameLabel.textAlignment = NSTextAlignmentRight;
    [containerView addSubview:paintNameLabel];
    self.paintNameLabel = paintNameLabel;
    [paintNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(paintImageView.mas_bottom).with.offset(kPadding);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.right.equalTo(containerView.mas_right).with.offset(-kPadding);
    }];
    
    // 初始化画作者
    UILabel *paintAuthorLabel = [[UILabel alloc] init];
    paintAuthorLabel.textColor = JHPaintInfoTextColor;
    paintAuthorLabel.nightTextColor = JHPaintInfoTextColor;
    paintAuthorLabel.font = JHSystemFont(12);
    paintAuthorLabel.textAlignment = NSTextAlignmentRight;
    [containerView addSubview:paintAuthorLabel];
    self.paintAuthorLabel = paintAuthorLabel;
    [paintAuthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(paintNameLabel.mas_bottom);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.right.equalTo(containerView.mas_right).with.offset(-kPadding);
    }];
    
    // 初始化日文字控件
    UILabel *dayLabel = [[UILabel alloc] init];
    dayLabel.textColor = JHDayTextColor;
    dayLabel.nightTextColor = JHDayTextColor;
    dayLabel.backgroundColor = JHDawnBGViewColor;
    dayLabel.nightBackgroundColor = JHNightBGViewColor;
    dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:43];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.shadowOffset = CGSizeMake(1, 1);
    dayLabel.shadowColor = [UIColor whiteColor];
    [containerView addSubview:dayLabel];
    self.dayLabel = dayLabel;
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(paintAuthorLabel.mas_bottom).with.offset(kPadding * 2);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    // 初始化月和年文字控件
    UILabel *monthAndYearLabel = [[UILabel alloc] init];
    monthAndYearLabel.textColor = JHMonthAndYearTextColor;
    monthAndYearLabel.nightTextColor = JHMonthAndYearTextColor;
    monthAndYearLabel.backgroundColor = JHDawnBGViewColor;
    monthAndYearLabel.nightBackgroundColor = JHNightBGViewColor;
    monthAndYearLabel.font = [UIFont fontWithName:@"CenturyGothic-Bold" size:10];
    monthAndYearLabel.textAlignment = NSTextAlignmentCenter;
    monthAndYearLabel.shadowOffset = CGSizeMake(1, 1);
    monthAndYearLabel.shadowColor = [UIColor whiteColor];
    [containerView addSubview:monthAndYearLabel];
    self.monthAndYearLabel = monthAndYearLabel;
    [monthAndYearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dayLabel.mas_bottom).with.offset(2);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(12);
    }];
    
    // 初始化内容背景图片控件
    UIImageView *contentBGImageView = [[UIImageView alloc] init];
    [containerView addSubview:contentBGImageView];
    self.contentBGImageView = contentBGImageView;
    [contentBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(paintAuthorLabel.mas_bottom).with.offset(kPadding * 2);
        make.left.equalTo(dayLabel.mas_right).with.offset(kPadding);
        make.right.equalTo(containerView.mas_right).with.offset(-kPadding);
    }];
    
    // 初始化内容控件
    UITextView *contentTextView = [[UITextView alloc] init];
    contentTextView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
    contentTextView.editable = NO;
    contentTextView.scrollEnabled = NO;
    contentTextView.backgroundColor = [UIColor clearColor];
    [contentBGImageView addSubview:contentTextView];
    self.contentTextView = contentTextView;
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentBGImageView.mas_left).with.offset(6);
        make.top.equalTo(contentBGImageView.mas_top).with.offset(0);
        make.right.equalTo(contentBGImageView.mas_right).with.offset(-6);
        make.bottom.equalTo(contentBGImageView.mas_bottom).with.offset(0);
    }];
    
    // 初始化点赞按钮
    UIButton *praiseNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    praiseNumberBtn.titleLabel.font = JHSystemFont(12);
    [praiseNumberBtn setTitleColor:JHPraiseBtnTextColor forState:UIControlStateNormal];
    praiseNumberBtn.nightTitleColor = JHPraiseBtnTextColor;
    UIImage *btnImage = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:20 topCapHeight:2];
    [praiseNumberBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [praiseNumberBtn setImage:[UIImage imageNamed:@"home_like"] forState:UIControlStateNormal];
    [praiseNumberBtn setImage:[UIImage imageNamed:@"home_like_hl"] forState:UIControlStateSelected];
    praiseNumberBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    praiseNumberBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [praiseNumberBtn addTarget:self action:@selector(praise) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:praiseNumberBtn];
    self.praiseNumberBtn = praiseNumberBtn;
    [praiseNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentBGImageView.mas_bottom).with.offset(30);
        make.right.equalTo(containerView.mas_right).with.offset(0);
        make.height.mas_equalTo(@28);
        make.bottom.equalTo(containerView.mas_bottom).with.offset(-16);
    }];
}


- (void)praise {
    self.praiseNumberBtn.selected = !self.praiseNumberBtn.isSelected;
}


- (void)setHomeInfo:(JHHomeInfo *)homeInfo {
    _homeInfo = homeInfo;
    self.scrollView.backgroundColor =  Is_Night_Mode ? JHNightBGViewColor : JHDawnBGViewColor;
    
    self.volLabel.text = homeInfo.strHpTitle;
    [self.paintImageView configureImageViwWithImageURL:[NSURL URLWithString:homeInfo.strThumbnailUrl] animated:YES];
    self.paintNameLabel.text = [homeInfo.strAuthor componentsSeparatedByString:@"&"][0];
    self.paintAuthorLabel.text = [homeInfo.strAuthor componentsSeparatedByString:@"&"][1];
    NSString *marketTime = [JHTimeTool homeENMarketTimeWithOriginalMarketTime:homeInfo.strMarketTime];
    self.dayLabel.text = [marketTime componentsSeparatedByString:@"&"][0];
    self.monthAndYearLabel.text = [marketTime componentsSeparatedByString:@"&"][1];
    if (Is_Night_Mode) {
        self.dayLabel.shadowColor = [UIColor blackColor];
        self.monthAndYearLabel.shadowColor = [UIColor blackColor];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attribute;
    if (Is_Night_Mode) {
        attribute = @{NSParagraphStyleAttributeName : paragraphStyle,
                      NSForegroundColorAttributeName : JHPaintInfoTextColor,
                      NSFontAttributeName : JHSystemFont(13)};
    } else {
        attribute = @{NSParagraphStyleAttributeName : paragraphStyle,
                      NSForegroundColorAttributeName : [UIColor whiteColor],
                      NSFontAttributeName : JHSystemFont(13)};
    }
    
    self.contentTextView.attributedText = [[NSAttributedString alloc] initWithString:homeInfo.strContent attributes:attribute];
    [self.contentTextView sizeToFit];
    
    if (Is_Night_Mode) {
        self.contentBGImageView.image = [[UIImage imageNamed:@"contBack_nt"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    } else {
        self.contentBGImageView.image = [[UIImage imageNamed:@"contBack"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    }
    
    [self.praiseNumberBtn setTitle:[NSString stringWithFormat:@"  %@", homeInfo.strPn] forState:UIControlStateNormal];
    [self.praiseNumberBtn sizeToFit];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.containerView.frame));

}

@end
