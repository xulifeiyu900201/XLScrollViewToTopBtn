//  代码地址: https://github.com/xulifeiyu900201/XLScrollViewToTopBtn
//  XLToScrollViewTopBtn.m
//  XLScrollViewToTopBtn
//
//  Created by 秦旭力 on 16/4/24.
//  Copyright © 2016年 XL Quin. All rights reserved.
//

#import "XLToScrollViewTopBtn.h"
#import "SelfViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
NSString *const XLToScrollViewTopBtnContentOffset = @"contentOffset";

@interface XLToScrollViewTopBtn ()

/** 设置滚动视图偏移量为多少时显示按钮,如果不设置默认为zero点*/
@property (nonatomic ,assign) CGFloat showBtnFloat;

/** 设置滚动视图滚动的偏移量坐标,如果不设置默认为zero(滚动到顶部)*/
@property (nonatomic ,assign) CGPoint scrollToPoint;

/** 滚动结束按钮多长时间消失*/
@property (nonatomic, assign) NSTimeInterval btnDisDur;

/** 点击按钮完成回调的block*/
@property (nonatomic ,copy) void (^completeBlock) (UIButton *);

/** 记录当前按钮的状态*/
@property (nonatomic, assign) XLToScrollViewTopBtnType topBtnType;

/** 视图滚动完毕之后调用*/
@property (nonatomic, copy) void (^scrollCompleteBlock) ();

@end

@implementation XLToScrollViewTopBtn {
    
    __weak UIScrollView *_scView;
}

+ (instancetype)createWithBtnType:(XLToScrollViewTopBtnType)topBtnType scrollView:(UIScrollView * _Nonnull __unsafe_unretained)scrollView clickButtonActionHandler:(void (^)(UIButton * _Nonnull))touchHandler {
    
    XLToScrollViewTopBtn *btn = [[self alloc] initWithBtnType:topBtnType scrollView:scrollView clickButtonActionHandler:touchHandler];
    
    return btn;
}

- (instancetype)initWithBtnType:(XLToScrollViewTopBtnType)topBtnType scrollView:(UIScrollView * _Nonnull __unsafe_unretained)scrollView clickButtonActionHandler:(void (^)(UIButton * _Nonnull))touchHandler {
    
    if (self = [super init]) {
        self.topBtnType = topBtnType;
        _scView = scrollView;
        self.completeBlock = touchHandler;
        [self addTarget:self action:@selector(scrollToTopActionTouched:) forControlEvents:UIControlEventTouchUpInside];
        switch (self.topBtnType) {
            case XLToScrollViewTopBtnTypeNormal:
                // 添加传递过来的ScrollView观察者为自己,并且观察ScrollView的contentOffset属性
                [scrollView addObserver:self forKeyPath:XLToScrollViewTopBtnContentOffset options:NSKeyValueObservingOptionNew context:nil];
                break;
            case XLToScrollViewTopBtnTypeDownRoll:
                // 添加传递过来的ScrollView观察者为自己,并且观察ScrollView的contentOffset属性
                [scrollView addObserver:self forKeyPath:XLToScrollViewTopBtnContentOffset options:NSKeyValueObservingOptionNew context:nil];
                // 一出来就要隐藏按钮
                self.hidden = YES;
                break;
            case XLToScrollViewTopBtnTypeDecelerat:
                // 下一步需要实现的功能
                break;
                
            default:
                break;
        }
    }
    return self;
}

- (void)setUpBtnEffect:(void (^)(CGSize * _Nonnull, UIEdgeInsets * _Nonnull, NSString *__autoreleasing  _Nullable * _Nullable, CGPoint * _Nonnull, CGFloat * _Nonnull, NSTimeInterval * _Nonnull))topBtnEffectBlock {
    
    // 初始化一些指针来接受block赋值
    CGSize btnSize = CGSizeZero;
    UIEdgeInsets relaLoc = UIEdgeInsetsZero;
    NSString *imageName = nil;
    CGPoint scrollToPoint = CGPointZero;
    CGFloat showBtnFloat = CGFLOAT_MIN;
    NSTimeInterval btnDisDur = CGFLOAT_MIN;
    if (topBtnEffectBlock) {
        topBtnEffectBlock(&btnSize,&relaLoc,&imageName,&scrollToPoint,&showBtnFloat,&btnDisDur);
        _scrollToPoint = scrollToPoint;
        _showBtnFloat = showBtnFloat;
        _btnDisDur = btnDisDur;
    }
    // 设置按钮的图片
    if (imageName) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    [self addLayoutConstraint:btnSize andUIEdgeInsets:relaLoc];
}

// 添加约束条件
- (void)addLayoutConstraint:(CGSize)btnSize andUIEdgeInsets:(UIEdgeInsets)relaLoc {
    
    // 关闭AutoresizingMask, 以便使用AutoLayout
    self.translatesAutoresizingMaskIntoConstraints = NO;
    // 添加约束条件使按钮适配各个屏幕的位置
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:btnSize.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:btnSize.height];
    [self addConstraints:@[width,height]];
    
    // 找到ScrollView的父控制器
    UIView *superView = _scView.superview;
    if (superView) {
        // 将按钮添加到ScrollView的父控制器并且悬浮在ScrollView之上
        [superView insertSubview:self aboveSubview:_scView];
        
        [self superViewAddConstrains:superView andUIEdgeInsets:relaLoc];
    }else {// 如果当前滚动视图没有父容器
        // 创建一个window大小的view作为父容器放在底部
        UIView *bacView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIViewController *scrViewC = [SelfViewController viewController:_scView];
        scrViewC.view = bacView;
        [scrViewC.view addSubview:_scView];
        // 将按钮与ScrollView成为"兄弟",呈现悬浮状态
        [scrViewC.view insertSubview:self aboveSubview:_scView];
        
        [self superViewAddConstrains:scrViewC.view andUIEdgeInsets:relaLoc];
        
    }
}

// 给父容器添加约束
- (void)superViewAddConstrains:(UIView *)superView andUIEdgeInsets:(UIEdgeInsets)relaLoc {
    
    if (relaLoc.top && relaLoc.left) {
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:relaLoc.top];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:relaLoc.left];
        [superView addConstraints:@[top,left]];
    }
    
    if (relaLoc.bottom && relaLoc.right) {
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:-relaLoc.bottom];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:-relaLoc.right];
        [superView addConstraints:@[bottom,right]];
    }
}

// 按钮点击响应方法
- (void)scrollToTopActionTouched:(UIButton *)button {
    // 让视图滚动到预想的位置
    [_scView setContentOffset:self.scrollToPoint animated:YES];
    // 执行回调block响应控制器
    if (self.completeBlock) {
        self.completeBlock(button);
    }
}

// contentOffset属性发生改变调用此方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // 取出视图滚动的偏移量值
    CGPoint point = [change[@"new"] CGPointValue];
    
    switch (self.topBtnType) {
        case XLToScrollViewTopBtnTypeNormal:
            // 根据当前ScrollView的滚动情况决定按钮的显示情况
            self.hidden = point.y < self.showBtnFloat ? YES : NO;
            break;
        case XLToScrollViewTopBtnTypeDownRoll:{
            // 静态变量存储上一次滚动的y值
            static CGFloat lastPosition = 0;
            // 这次的y值
            CGFloat currentPostion = point.y;
            if (currentPostion < lastPosition && currentPostion > self.scrollToPoint.y) {// 向下滚动并且当前y值比预想位置大 显示按钮
                lastPosition = currentPostion;
                self.hidden = NO;
            }else if (currentPostion > lastPosition){// 向上滚动隐藏按钮
                lastPosition = currentPostion;
                self.hidden = YES;
            }
            
            if (point.y <= self.scrollToPoint.y) {// 当前位置比预想位置小 隐藏按钮
                self.hidden = YES;
            }
        }
            break;
        case XLToScrollViewTopBtnTypeDecelerat:
            // 下一步需要实现的功能
            break;
            
        default:
            break;
    }
    
}

- (void)dealloc {
    // 当视图控制器消失的时候移除观察者防止内存泄漏
    [_scView removeObserver:self forKeyPath:XLToScrollViewTopBtnContentOffset];
    NSLog(@"toTopButton-----dealloc!!!!!!!!!!");
}


@end
