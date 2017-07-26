//
//  LSPSlideView.m
//  LSPSlideShow
//
//  Created by iOS－MacBook on 2017/5/22.
//  Copyright © 2017年 lispeng. All rights reserved.
//

#import "LSPSlideView.h"
#import "NSTimer+Extension.h"
//#import "LSPImageView.h"
//#import "LSPickImageBrower.h"
@interface LSPSlideView()<UIScrollViewDelegate>
/***<#title#>*****/
@property (nonatomic,weak) UIPageControl *pageControl;
/***定时器*****/
@property (nonatomic,strong) NSTimer *timer;
/***<#title#>*****/
@property (nonatomic,assign) NSInteger imageCount;
/***<#title#>*****/
//@property (nonatomic,strong) NSMutableArray <UIImageView *>*imageViewArray;
/***<#title#>*****/
@property (nonatomic,strong) NSArray *arr;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UIScrollView *scrollView;
/**
 <#annotation#>
 */
@property (nonatomic,weak) UILabel *numIndicaterLabel;

@end

@implementation LSPSlideView
//- (NSMutableArray<UIImageView *> *)imageViewArray
//{
//    if (nil == _imageViewArray) {
//        _imageViewArray = [NSMutableArray array];
//    }
//    return _imageViewArray;
//}

- (instancetype)init
{
    if (self = [super init]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self.scrollView addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}
- (void)setImageArray:(NSArray<UIImage *> *)imageArray
{
    _imageArray = imageArray;
    // self.arr = imageArray;
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = self.frame;
    NSInteger imageCount = imageArray.count;
    self.imageCount = imageCount;
    CGFloat imageWidth = self.frame.size.width;
    CGFloat imageHeight = self.frame.size.height;
    CGFloat imageY = 0;
    // [self.imageViewArray removeAllObjects];
    //添加图片
    for (NSInteger i = 0; i < imageCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
       // UIPanGestureRecognizer *panGes = [UIPanGestureRecognizer alloc] initWithTarget:<#(nullable id)#> action:<#(nullable SEL)#>;
        CGFloat imageX = i * imageWidth;
        imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        //设置图片
        UIImage *image = imageArray[i];
        imageView.image = image;
        // [self.imageViewArray addObject:imageView];
        [self.scrollView addSubview:imageView];
    }
    //图片数字指示器
    UILabel *numIndicaterLabel = [[UILabel alloc] init];
    numIndicaterLabel.font = [UIFont systemFontOfSize:14];
    numIndicaterLabel.textColor = [UIColor whiteColor];
    numIndicaterLabel.textAlignment = NSTextAlignmentCenter;
    numIndicaterLabel.backgroundColor = [UIColor lightGrayColor];
    CGFloat numIndicaterWidth = 43;
    CGFloat numIndicaterHeight = numIndicaterWidth;
    CGFloat numIndicaterX = imageWidth - numIndicaterWidth - 10;;
    CGFloat numIndicaterY = imageHeight - numIndicaterHeight - 10;;
    numIndicaterLabel.frame = CGRectMake(numIndicaterX, numIndicaterY, numIndicaterWidth, numIndicaterHeight);
    numIndicaterLabel.textAlignment = NSTextAlignmentCenter;
    numIndicaterLabel.layer.cornerRadius = numIndicaterWidth / 2;
    numIndicaterLabel.layer.masksToBounds = YES;
    // [self addSubview:numIndicaterLabel];
    
    NSString *foreNum = @"1";
    NSInteger length = foreNum.length;
    NSString *numStr = [NSString stringWithFormat:@"1/%ld",imageCount];
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:numStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, numStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, length)];
    numIndicaterLabel.attributedText = attrStr;
    [self addSubview:numIndicaterLabel];
    self.numIndicaterLabel = numIndicaterLabel;

    //设置自身的ContentSize
    CGFloat contentWidth = imageCount * imageWidth;
    self.scrollView.contentSize = CGSizeMake(contentWidth, 0);
    //隐藏滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //设置分页
    self.scrollView.pagingEnabled = YES;
    //设置pageControl的总页数
    self.pageControl.numberOfPages = imageCount;
    //添加定时器
    [self addTimer];
}
//- (void)imageViewTapClick:(UITapGestureRecognizer *)tap
//{
//}

/**
 添加定时器
 */
- (void)addTimer
{
    __weak typeof(self)weakSelf = self;
    weakSelf.timer = [NSTimer lsp_scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *timer) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf nextImage];
    }];
    [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];

}
/**
 定时器暂停
 */
- (void)pauseTimer
{
    if (![self.timer isValid]) {
        return ;
    }
    [self.timer setFireDate:[NSDate distantFuture]];
}
/**
 定时器重新开启
 */
- (void)resumeTimer
{
    if (![self.timer isValid]) {
        return ;
    }
    
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self.timer setFireDate:[NSDate date]];
    
}

/**
 移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)nextImage
{
    //算页码
    NSInteger page = self.pageControl.currentPage;
    NSLog(@"self.pageControl.currentPage = %ld",self.pageControl.currentPage);
    if (page == self.imageCount - 1) {
        page = 0;
    }else{
        page ++;
    }
    NSString *foreNum = [NSString stringWithFormat:@"%ld",page + 1];
    NSInteger length = foreNum.length;
    NSString *numStr = [NSString stringWithFormat:@"%@/%ld",foreNum,self.imageCount];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:numStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, numStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, length)];
    self.numIndicaterLabel.attributedText = attrStr;

    //计算滚动位置
    CGFloat offsetX = page * self.pageControl.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    
}
#pragma mark---UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSInteger page = (self.scrollView.contentOffset.x + self.scrollView.frame.size.width*0.5) / self.scrollView.frame.size.width;
    self.pageControl.currentPage = page;
    
    NSString *foreNum = [NSString stringWithFormat:@"%ld",page + 1];
    NSInteger length = foreNum.length;
    NSString *numStr = [NSString stringWithFormat:@"%@/%ld",foreNum,self.imageCount];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:numStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, numStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, length)];
    self.numIndicaterLabel.attributedText = attrStr;

    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //停止定时器
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
- (void)dealloc
{
    //停止定时器
    [self removeTimer];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
