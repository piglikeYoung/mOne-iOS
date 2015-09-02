//
//  JHThingView.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHThingView.h"
#import "CustomImageView.h"
#import "JHTimeTool.h"
#import "JHThingInfo.h"

@interface JHThingView()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) CustomImageView *thingImageView;
@property (nonatomic, weak) UILabel *thingNameLabel;
@property (nonatomic, weak) UITextView *thingDescriptionTextView;

@end

@implementation JHThingView

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
    
    // 初始化日期文字控件
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.font = JHSystemFont(13);
    dateLabel.textColor = JHDateTextColor;
    dateLabel.nightTextColor = JHDateTextColor;
    dateLabel.backgroundColor = JHDawnBGViewColor;
    dateLabel.nightBackgroundColor = JHNightBGViewColor;
    [containerView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_top).with.offset(kPadding);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.right.equalTo(containerView.mas_right).with.offset(-kPadding);
    }];
    
    // 初始化东西图片控件
    CustomImageView *thingImageView = [[CustomImageView alloc] init];
    thingImageView.backgroundColor = JHDawnBGViewColor;
    thingImageView.nightBackgroundColor = JHNightBGViewColor;
    CGFloat imgWidth = JHScreenW - 20;
    CGFloat imgHeight = imgWidth;
    [containerView addSubview:thingImageView];
    self.thingImageView = thingImageView;
    [thingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateLabel.mas_bottom).with.offset(kPadding);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.right.equalTo(containerView.mas_right).with.offset(-kPadding);
        make.height.mas_equalTo(imgHeight);
    }];
    
    // 初始化东西名字文字控件
    UILabel *thingNameLabel = [[UILabel alloc] init];
    thingNameLabel.numberOfLines = 0;
    thingNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    thingNameLabel.textColor = JHThingNameTextColor;
    thingNameLabel.nightTextColor = JHNightTextColor;
    [containerView addSubview:thingNameLabel];
    self.thingNameLabel = thingNameLabel;
    [thingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thingImageView.mas_bottom).with.offset(kPadding * 3);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding + 5);
        make.right.equalTo(containerView.mas_right).with.offset(-(kPadding + 5));
    }];
    
    // 初始化东西介绍文字视图控件
    UITextView *thingDescriptionTextView = [[UITextView alloc] init];
    thingDescriptionTextView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
    thingDescriptionTextView.editable = NO;
    thingDescriptionTextView.scrollEnabled = NO;
    thingDescriptionTextView.pagingEnabled = NO;
    thingDescriptionTextView.scrollsToTop = NO;
    thingDescriptionTextView.directionalLockEnabled = NO;
    thingDescriptionTextView.alwaysBounceVertical = NO;
    thingDescriptionTextView.alwaysBounceHorizontal = NO;
    thingDescriptionTextView.backgroundColor = JHDawnBGViewColor;
    thingDescriptionTextView.nightBackgroundColor = JHNightBGViewColor;
    [containerView addSubview:thingDescriptionTextView];
    self.thingDescriptionTextView = thingDescriptionTextView;
    [thingDescriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thingNameLabel.mas_bottom).with.offset(kPadding * 2 + 5);
        make.left.equalTo(containerView.mas_left).with.offset(kPadding);
        make.right.equalTo(containerView).with.offset(-kPadding);
        make.bottom.equalTo(containerView.mas_bottom).with.offset(-kPadding);
    }];
    
}

- (void)setThingInfo:(JHThingInfo *)thingInfo {
    _thingInfo = thingInfo;
    
    self.dateLabel.text = [JHTimeTool enMarketTimeWithOriginalMarketTime:_thingInfo.strTm];
    [self.thingImageView configureImageViwWithImageURL:[NSURL URLWithString:_thingInfo.strBu] animated:YES];
    self.thingNameLabel.text = _thingInfo.strTt;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attribute;
    if (Is_Night_Mode) {
        self.thingDescriptionTextView.backgroundColor = JHNightBGViewColor;
        
        attribute = @{NSParagraphStyleAttributeName : paragraphStyle,
                      NSForegroundColorAttributeName : JHNightTextColor,
                      NSFontAttributeName : [UIFont systemFontOfSize:15]};
    } else {
        self.thingDescriptionTextView.backgroundColor = JHDawnBGViewColor;
        
        attribute = @{NSParagraphStyleAttributeName : paragraphStyle,
                      NSForegroundColorAttributeName : JHThingDescriptionColor,
                      NSFontAttributeName : [UIFont systemFontOfSize:15]};
    }
    self.thingDescriptionTextView.attributedText = [[NSAttributedString alloc] initWithString:_thingInfo.strTc attributes:attribute];
    [self.thingDescriptionTextView sizeToFit];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.containerView.frame));
}


@end
