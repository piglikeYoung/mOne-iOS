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
#import "JHHomeTool.h"
#import "JHHomeParam.h"
#import "JHHomeResult.h"
#import "JHHomeInfo.h"

static const CGFloat kLabelOffsetX = 20.f;

@interface JHHomeViewController ()<iCarouselDataSource, iCarouselDelegate>

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

/**
 *  item 加载中转转的菊花
 */
@property (weak, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation JHHomeViewController

#pragma mark - lazy load
- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
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
    leftRefreshLabel.textColor = JHLeftRefreshLabelTextColor;
    leftRefreshLabel.nightTextColor = JHLeftRefreshLabelTextColor;
    leftRefreshLabel.textAlignment = NSTextAlignmentRight;
    leftRefreshLabel.text = kLeftDragToRightForRefreshHintText;
    CGSize size = [leftRefreshLabel.text sizeWithFont:leftRefreshLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    leftRefreshLabel.frame = CGRectMake(0 - size.width * 1.5 - kLabelOffsetX, carousel.centerY, size.width * 1.5, size.height);
    leftRefreshLabel.hidden = YES;
    self.leftRefreshLabel = leftRefreshLabel;
    
    [self.carousel.contentView addSubview:leftRefreshLabel];
    
    
    // 初始化加载中的菊花控件
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.hidesWhenStopped = YES;
    indicatorView.center = self.carousel.center;
    if (Is_Night_Mode) {
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    } else {
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    [indicatorView startAnimating];
    self.indicatorView = indicatorView;
    [self.view addSubview:indicatorView];
    
    self.refreshing = YES;
    self.canScrollBack = YES;
    [self requestHomeContentAtIndex:@(self.items.count)];
}

#pragma mark - Request
- (void)requestHomeContentAtIndex:(NSNumber *)index {
    
    JHHomeParam *param = [JHHomeParam param];
    param.index = index;
    [JHHomeTool homeContentWithParam:param success:^(JHHomeResult *result) {
        if ([result.result isEqualToString:kSuccessFlag]) {
            if (self.isRefreshing) {

                // 之前有数据
                if (self.items.count > 0) {
                    // 刷新的数据和之前获取的数据比较
                    if ([result.hpEntity.strHpId isEqualToString:((JHHomeInfo *)self.items[0]).strHpId]) {
                        
                        // 没有最新数据
                        [MBProgressHUD showText:kNoLatestData delay:1.f];
                    } else {// 有新数据
                        // 删掉所有的已读数据，不用考虑第一个已读数据和最新数据之间相差几天，简单粗暴
                        [_items removeAllObjects];
                        // 添加到数组
                        [_items addObject:result.hpEntity];
                        // 刷新carousel
                        [self.carousel reloadData];
                    }
                }
                // 之前没数据
                else {
                    // 添加到数组
                    [_items addObject:result.hpEntity];
                    // 刷新carousel
                    [self.carousel reloadData];
                    self.leftRefreshLabel.hidden = NO;
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDefaultAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self endRefreshing];
                });
                
                
            }
           
        }
        
        [self.indicatorView stopAnimating];
    } failure:^(NSError *error) {
        JHLog(@"%@", error);
        [self.indicatorView stopAnimating];
    }];
}

#pragma mark - Private
/**
 *  右拉刷新
 */
- (void)refreshing {
    if (self.items.count > 0) {// 避免第一个还未加载的时候右拉刷新更新数据
        
        _refreshing = YES;
        [self requestHomeContentAtIndex:0];
    }
}

/**
 *  停止刷新归位
 */
- (void)endRefreshing {
    if (self.isRefreshing) {
        [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
            self.carousel.contentOffset = CGSizeMake(0, 0);
            self.leftRefreshLabel.x = - self.leftRefreshLabel.width - kLabelOffsetX;
        } completion:^(BOOL finished) {
            _needRefresh = NO;
            _canScrollBack = YES;
        }];
    }
}



#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {

    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    JHHomeView *homeView = nil;
    
    if (!homeView) {
        homeView = [[JHHomeView alloc] initWithFrame:carousel.bounds];
        homeView.homeInfo = self.items[index];
        homeView.tag = 1;
    } else {
        homeView = (JHHomeView *)[view viewWithTag:1];
    }
    
    return homeView;
}


#pragma mark - iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return self.view.width;
}


- (void)carouselDidScroll:(iCarousel *)carousel {
    // 当右拉的时候，改变 leftRefreshLabel 的 x，根据右拉的速度一点点显示 leftRefreshLabel
    if (carousel.scrollOffset <= 0) {
        if (self.isCanScrollBack) {
            // 计算右拉的距离
            _draggedX = fabs(carousel.scrollOffset * carousel.itemWidth);

        
            CGFloat labelX = _draggedX - self.leftRefreshLabel.width - kLabelOffsetX;
            self.leftRefreshLabel.x = labelX;
            // 当右拉到一定的距离之后将 leftRefreshLabel 的文字改为“松开刷新数据...”，这里的距离为 leftRefreshLabel 宽度
            if (_draggedX >= self.leftRefreshLabel.width + kLabelOffsetX) {
                // 刷新 leftRefreshLabel
                self.leftRefreshLabel.text = kLeftReleaseToRefreshHintText;
                // 将刷新标记改为需要刷新
                _needRefresh = YES;
            } else {
                // 刷新 leftRefreshLabel
                self.leftRefreshLabel.text = kLeftDragToRightForRefreshHintText;
                // 将刷新标记改为需要刷新
                _needRefresh = NO;
            }
        }
    }
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate {
    
    if (!decelerate && self.isNeedRefresh) {// 右拉释放并且需要刷新数据
        // 设置 leftRefreshLabel 的显示文字、X 轴坐标
        self.leftRefreshLabel.text = kLeftReleaseIsRefreshingHintText;
        self.leftRefreshLabel.x = 0;
        
        // 刷新数据
        [self refreshing];
        
        // 不改变 leftRefreshLabel 的 frame
        _canScrollBack = NO;
        
        [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
            // 设置 carousel item 的 X 轴偏移
            carousel.contentOffset = CGSizeMake(self.leftRefreshLabel.width, 0);
        }];
        
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    //	NSLog(@"carousel DidEndScrollingAnimation");
    // 如果当前的 item 为第一个并且 leftRefreshLabel 可以 scroll back，那么就刷新 leftRefreshLabel
    if (carousel.currentItemIndex == 0 && self.isCanScrollBack) {
        self.leftRefreshLabel.text = kLeftDragToRightForRefreshHintText;
        _needRefresh = NO;
    }
    
}

@end
