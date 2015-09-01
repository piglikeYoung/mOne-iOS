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


// 保存右拉的 x 距离
@property (nonatomic, assign) CGFloat draggedX;

// 标记是否能够 scroll back，用在刷新的时候不改变 leftRefreshLabel 的 frame，默认为 YES
@property (nonatomic, assign, getter=isCanScrollBack) BOOL canScrollBack;

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
    leftRefreshLabel.frame = CGRectMake(0 - size.width  * 1.5 - kLabelOffsetX, carousel.centerY, size.width * 1.5, size.height);
    leftRefreshLabel.hidden = YES;// 开始隐藏，当加载完数据显示
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
    
    
    // 请求数据
    [self leftLoadMoreData];
    
    
    // 监听夜间模式按钮通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:DKNightVersionNightFallingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:DKNightVersionDawnComingNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:DKNightVersionNightFallingNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:DKNightVersionDawnComingNotification];
}

#pragma mark - Request
- (void)requestHomeContentAtIndex:(NSInteger)index {
    
    JHHomeParam *param = [JHHomeParam param];
    param.index = [NSNumber numberWithInteger:index];
    [JHHomeTool homeContentWithParam:param success:^(JHHomeResult *result) {
        if ([result.result isEqualToString:kSuccessFlag]) {
            
            // 是右拉刷新
            if (self.isRefreshing) {
                
                // 之前有数据
                if (self.items.count > 0) {
                    // 刷新的数据和之前获取的数据比较，相同没有新数据
                    if ([result.hpEntity.strHpId isEqualToString:((JHHomeInfo *)self.items[0]).strHpId]) {
                        
                        // 没有最新数据
                        [MBProgressHUD showText:kNoLatestData delay:1.f];
                    }
                    // 不相同，放到数组里
                    else {
                        // 删掉所有的已读数据，不用考虑第一个已读数据和最新数据之间相差几天，简单粗暴
                        [_items removeAllObjects];
                        // 添加到数组
                        [_items addObject:result.hpEntity];
                        // 将新的item插入末尾
                        [self.carousel insertItemAtIndex:self.items.count animated:YES];
                        
                        // 当有新数据，为了防止左拉到第二个item卡顿，再发送一次请求加载第二个item的数据
                        // 只执行一次，之后每次左拉都预加载一个item
                        static dispatch_once_t onceToken;
                        dispatch_once(&onceToken, ^{
                            [self requestHomeContentAtIndex:self.items.count];
                        });
                    }
                }
                // 之前没数据
                else {
                    // 添加到数组
                    [_items addObject:result.hpEntity];
                    // 刷新carousel
                    [self.carousel reloadData];
                    
                    // 显示label
                    self.leftRefreshLabel.hidden = NO;
                }
                
                // 延迟一下再归位
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kDefaultAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self endRefreshing];
                });
            }
            // 左拉加载
            else {
                // 添加数据到数组中
                [self.items addObject:result.hpEntity];
                // 将新的item插入末尾
                [self.carousel insertItemAtIndex:self.items.count animated:YES];
                // 显示label
                self.leftRefreshLabel.hidden = NO;
                
                // 当第一次加载数据，为了防止左拉到第二个item卡顿，再发送一次请求加载第二个item的数据
                // 只执行一次，之后每次左拉都预加载一个item
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    [self requestHomeContentAtIndex:self.items.count];
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
- (void)rightRefreshing {
    if (self.items.count > 0) {// 避免第一个还未加载的时候右拉刷新更新数据
        
        _refreshing = YES;// 是右拉刷新
        _canScrollBack = YES;
        [self requestHomeContentAtIndex:0];
    }
}

/**
 *  左拉加载更多数据
 */
- (void) leftLoadMoreData {
    
    
    _refreshing = NO;// 不是右拉刷新
    _canScrollBack = YES;
    
    [self requestHomeContentAtIndex:self.items.count];
    
}

/**
 *  停止刷新归位
 */
- (void)endRefreshing {
    // 右拉刷新完成，carousel归位
    if (self.isRefreshing) {
        [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
            self.carousel.contentOffset = CGSizeMake(0, 0);
            self.leftRefreshLabel.x = - self.leftRefreshLabel.width * 1.5 - kLabelOffsetX;
        } completion:^(BOOL finished) {
            _canScrollBack = YES;
        }];
    }
}



#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    JHHomeView *homeView = (JHHomeView *)view;
    
    // 复用View
    if (!homeView) {
        homeView = [[JHHomeView alloc] initWithFrame:carousel.bounds];
    }
    homeView.homeInfo = self.items[index];
    
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
            if (_draggedX >= self.leftRefreshLabel.width  * 1.5 + kLabelOffsetX) {
                // 刷新 leftRefreshLabel
                self.leftRefreshLabel.text = kLeftReleaseToRefreshHintText;
                
            } else {
                // 刷新 leftRefreshLabel
                self.leftRefreshLabel.text = kLeftDragToRightForRefreshHintText;
            }
        }
    }
    
    
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate {
    
    // 不是减速
    if (!decelerate) {
        // 右拉释放
        if (carousel.scrollOffset <= 0) {
            // 设置 leftRefreshLabel 的显示文字、X 轴坐标
            self.leftRefreshLabel.text = kLeftReleaseIsRefreshingHintText;
            self.leftRefreshLabel.x = 0;
            
            // 刷新数据
            [self rightRefreshing];
            
            // 不改变 leftRefreshLabel 的 frame
            _canScrollBack = NO;
            
            [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
                // 设置 carousel item 的 X 轴偏移
                carousel.contentOffset = CGSizeMake(self.leftRefreshLabel.width, 0);
            }];
        }
    }
    
    // 每次左拉都预加载新的数据
    if (carousel.scrollOffset > 0) {
        [self leftLoadMoreData];
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {

    // 如果当前的 item 为第一个并且 leftRefreshLabel 可以 scroll back，那么就刷新 leftRefreshLabel
    if (carousel.currentItemIndex == 0 && self.isCanScrollBack) {
        self.leftRefreshLabel.text = kLeftDragToRightForRefreshHintText;
    }
    
}

#pragma mark - 夜间模式
- (void)nightModeSwitch:(NSNotification *)notification {
    // 刷新数据，就能刷新日常模式或夜间模式
    [self.carousel reloadData];
}

@end
