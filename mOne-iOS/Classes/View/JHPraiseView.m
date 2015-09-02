//
//  JHPraiseView.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/9/2.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHPraiseView.h"
#import "JHQuestionInfo.h"

@interface JHPraiseView()

@property (weak, nonatomic) UIButton *praiseNumberBtn;

@end

@implementation JHPraiseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews {
    [DKNightVersionManager addClassToSet:self.class];
    self.backgroundColor = [UIColor clearColor];
    self.nightBackgroundColor = [UIColor clearColor];
    // 初始化点赞 Button
    UIButton *praiseNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    praiseNumberBtn.titleLabel.font = JHSystemFont(12);
    [praiseNumberBtn setTitleColor:JHPraiseBtnTextColor forState:UIControlStateNormal];
    praiseNumberBtn.nightTitleColor = JHPraiseBtnTextColor;
    UIImage *btnImage = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:20 topCapHeight:2];
    [praiseNumberBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [praiseNumberBtn setImage:[UIImage imageNamed:@"home_like"] forState:UIControlStateNormal];
    [praiseNumberBtn setImage:[UIImage imageNamed:@"home_like_hl"] forState:UIControlStateSelected];
    praiseNumberBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    praiseNumberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.praiseNumberBtn = praiseNumberBtn;
    [self addSubview:praiseNumberBtn];
}

- (void)setQuestionInfo:(JHQuestionInfo *)questionInfo {
    _questionInfo = questionInfo;
    
    [self.praiseNumberBtn setTitle:_questionInfo.strPraiseNumber forState:UIControlStateNormal];
    [self.praiseNumberBtn sizeToFit];
    CGFloat btnWidth = self.praiseNumberBtn.width + 22;
    self.praiseNumberBtn.frame = CGRectMake(JHScreenW - btnWidth, 30, btnWidth, self.praiseNumberBtn.height);
}

@end
