//
//  JHHomeViewController.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHHomeViewController.h"
#import "iCarousel.h"
#import "JHHomeView.h"

static const CGFloat kLabelOffsetX = 20.f;

#define LeftRefreshLabelTextColor JHColor(90, 91, 92)// #5A5B5C

@interface JHHomeViewController ()<iCarouselDataSource, iCarouselDelegate>

/**
 *  当前一共有多少篇文章，默认为3篇
 */
@property (nonatomic, assign) NSInteger numberOfItems;
/**
 *  保存当前查看过的数据
 */
@property (nonatomic, weak) NSMutableDictionary *readItems;
/**
 *  最后展示的 item 的下标
 */
@property (nonatomic, assign) NSInteger lastSelectedItemIndex;
/**
 *  当前是否正在右拉刷新标记
 */
@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;

/**
 *  滚动栏
 */
@property (weak, nonatomic) iCarousel *carousel;

/**
 *  刷新显示的label
 */
@property (weak, nonatomic) UILabel *leftRefreshLabel;


// 保存当 leftRefreshLabel 的 text 为“右拉刷新...”时的宽，在右拉的时候用到
@property (nonatomic, assign) CGFloat leftRefreshLabelWidth;
// 标记是否需要刷新，默认为 NO
@property (nonatomic, assign, getter=isNeedRefresh) BOOL needRefresh;
// 保存右拉的 x 距离
@property (nonatomic, assign) CGFloat draggedX;
// 标记是否能够 scroll back，用在刷新的时候不改变 leftRefreshLabel 的 frame，默认为 YES
@property (nonatomic, assign, getter=isCanScrollBack) BOOL canScrollBack;
// 最后一次显示的 item 的下标
@property (nonatomic, assign) NSInteger lastItemIndex;

/**
 *  存放数据的数组
 */
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation JHHomeViewController

#pragma mark - lazy load
- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            JHHomeView *homeView = [[JHHomeView alloc] initWithFrame:CGRectMake(0, 0, JHScreenW, JHScreenH - kNavigationBarH - kTableBarH)];
            [_items addObject:homeView];
        }
    }
    return _items;
}


#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 滚动框
    iCarousel *carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, JHScreenW, JHScreenH - kNavigationBarH - kTableBarH)];
    carousel.delegate = self;
    carousel.dataSource = self;
    carousel.type = iCarouselTypeLinear;
    carousel.vertical = NO;
    carousel.pagingEnabled = YES;
    carousel.bounceDistance = 0.7;
    carousel.decelerationRate = 0.6;
    self.carousel = carousel;
    [self.view addSubview:carousel];
    
    // 左侧刷新label
    UILabel *leftRefreshLabel = [[UILabel alloc] init];
    leftRefreshLabel.font = [UIFont systemFontOfSize:10.0f];
    leftRefreshLabel.textColor = LeftRefreshLabelTextColor;
    leftRefreshLabel.nightTextColor = LeftRefreshLabelTextColor;
    leftRefreshLabel.textAlignment = NSTextAlignmentRight;
    leftRefreshLabel.text = kLeftDragToRightForRefreshHintText;
    CGSize size = [_leftRefreshLabel.text sizeWithFont:leftRefreshLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    leftRefreshLabel.frame = CGRectMake(0 - size.width * 1.5 - kLabelOffsetX, carousel.centerY, size.width * 1.5, size.height);
    self.leftRefreshLabel = leftRefreshLabel;
    
    [self.carousel addSubview:leftRefreshLabel];
}


#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {

    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    
    return self.items[index];
}


@end
