//
//  JHReadingAuthorView.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/30.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHReadingAuthorView.h"
#import "JHReadingInfo.h"

@interface JHReadingAuthorView()

@property (weak, nonatomic) UIButton *praiseNumberBtn;
@property (weak, nonatomic) UIImageView *horizontalLine;
@property (weak, nonatomic) UILabel *authorLabel;
@property (weak, nonatomic) UILabel *authorWebNameLabel;
@property (weak, nonatomic) UITextView *authorDescriptionTextView;

@end

@implementation JHReadingAuthorView

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
    
    // 初始化点赞 Button
    UIButton *praiseNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    praiseNumberBtn.titleLabel.font = JHSystemFont(12);
    [praiseNumberBtn setTitleColor:JHPraiseBtnTextColor forState:UIControlStateNormal];
    praiseNumberBtn.nightTitleColor = JHPraiseBtnTextColor;
    UIImage *btnImage = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:45 topCapHeight:0];
    [praiseNumberBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [praiseNumberBtn setImage:[UIImage imageNamed:@"home_like"] forState:UIControlStateNormal];
    [praiseNumberBtn setImage:[UIImage imageNamed:@"home_like_hl"] forState:UIControlStateSelected];
    praiseNumberBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    praiseNumberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:praiseNumberBtn];
    self.praiseNumberBtn = praiseNumberBtn;
    
    // 初始化水平分割线
    UIImageView *horizontalLine = [[UIImageView alloc] init];
    horizontalLine.image = [UIImage imageNamed:@"horizontalLine"];
    [self addSubview:horizontalLine];
    self.horizontalLine = horizontalLine;
    
    // 初始化作者名字 Label
    UILabel *authorLabel = [[UILabel alloc] init];
    authorLabel.textColor = JHAuthorTextColor;
    authorLabel.nightTextColor = JHNightTextColor;
    authorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    [self addSubview:authorLabel];
    self.authorLabel = authorLabel;
    
    // 初始化作者网名 Label
    UILabel *authorWebNameLabel = [[UILabel alloc] init];
    authorWebNameLabel.textColor = JHAuthorWenNameTextColor;
    authorWebNameLabel.nightTextColor = UIColorFromRGB(0xACB1B4);
    authorWebNameLabel.font = JHSystemFont(13);
    [self addSubview:authorWebNameLabel];
    self.authorWebNameLabel = authorWebNameLabel;
    
    // 初始化作者介绍 TextView
    UITextView *authorDescriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, JHScreenW, 0)];
    authorDescriptionTextView.font = JHSystemFont(15);
    authorDescriptionTextView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
    authorDescriptionTextView.editable = NO;
    authorDescriptionTextView.scrollEnabled = NO;
    authorDescriptionTextView.pagingEnabled = NO;
    authorDescriptionTextView.showsVerticalScrollIndicator = NO;
    authorDescriptionTextView.showsHorizontalScrollIndicator = NO;
    authorDescriptionTextView.backgroundColor = [UIColor whiteColor];
    authorDescriptionTextView.nightBackgroundColor = JHNightBGViewColor;
    [self addSubview:authorDescriptionTextView];
    self.authorDescriptionTextView = authorDescriptionTextView;
}

- (void)setReadingInfo:(JHReadingInfo *)readingInfo {
    _readingInfo = readingInfo;
    
    // 点赞按钮
    [self.praiseNumberBtn setTitle:_readingInfo.strPraiseNumber forState:UIControlStateNormal];
    [self.praiseNumberBtn sizeToFit];
    CGFloat btnWidth = self.praiseNumberBtn.width + 22;
    self.praiseNumberBtn.frame = CGRectMake(JHScreenW - btnWidth, kPadding * 0.5, btnWidth, self.praiseNumberBtn.height);
    
    // 分隔线
    self.horizontalLine.frame = CGRectMake(kPadding, CGRectGetMaxY(self.praiseNumberBtn.frame) + kPadding * 2, JHScreenW - kPadding * 2, 1);
    
    // 作者
    self.authorLabel.text = _readingInfo.strContAuthor;
    [self.authorLabel sizeToFit];
    self.authorLabel.frame = CGRectMake(kPadding + 5, CGRectGetMaxY(self.horizontalLine.frame) + kPadding, self.authorLabel.width, self.authorLabel.height);
    
    // 作者网名
    self.authorWebNameLabel.text = _readingInfo.sWbN;
    [self.authorWebNameLabel sizeToFit];
    CGFloat wnLabelHeight = self.authorWebNameLabel.height;
    CGFloat wnLabelY = CGRectGetMaxY(self.authorLabel.frame) - wnLabelHeight;
    CGFloat wnLabelX = CGRectGetMaxX(self.authorLabel.frame) + 5;
    CGRect authorWNLabelFrame = CGRectMake(wnLabelX, wnLabelY, JHScreenW - wnLabelX, wnLabelHeight);
    self.authorWebNameLabel.frame = authorWNLabelFrame;
    
    // 作者介绍
    self.authorDescriptionTextView.text = _readingInfo.sAuth;
    if (Is_Night_Mode) {
        self.authorDescriptionTextView.textColor = JHNightTextColor;
        self.authorDescriptionTextView.backgroundColor = JHNightBGViewColor;
    } else {
        self.authorDescriptionTextView.textColor = JHAuthorTextViewColor;
        self.authorDescriptionTextView.backgroundColor = JHDawnBGViewColor;
    }
    [self.authorDescriptionTextView sizeToFit];

    self.authorDescriptionTextView.frame = CGRectMake(kPadding, CGRectGetMaxY(self.authorLabel.frame) + kPadding, JHScreenW - kPadding * 2, CGRectGetHeight(self.authorDescriptionTextView.frame));
    
    self.height = CGRectGetMaxY(self.authorDescriptionTextView.frame) + kPadding;;

}


@end
