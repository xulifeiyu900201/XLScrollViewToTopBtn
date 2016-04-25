//
//  XLToScrollViewTopBtn.m
//  XLScrollViewToTopBtn
//
//  Created by 秦旭力 on 16/4/24.
//  Copyright © 2016年 XL Quin. All rights reserved.
//

#import "XLToScrollViewTopBtn.h"

@interface XLToScrollViewTopBtn ()

@property (nonatomic ,copy) void (^completeBlock) (UIButton *);

@end

@implementation XLToScrollViewTopBtn {

    __weak UIScrollView *_scView;
}

- (instancetype)initWithBtnImageName:(NSString *)imageName andRect:(CGRect)rect andScrollToPoint:(CGPoint)scrollToPoint andShowBtnFloat:(CGFloat)showBtnFloat {

    if (self = [super initWithFrame:rect]) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        self.scrollToPoint = scrollToPoint;
        self.showBtnFloat = showBtnFloat;
    }
    return self;
}

- (void)scrollView:(UIScrollView *__unsafe_unretained)scrollView clickButtonActionHandler:(void (^)(UIButton *))touchHandler {
    
    self.completeBlock = touchHandler;
    [self addTarget:self action:@selector(scrollToTopActionTouched:) forControlEvents:UIControlEventTouchUpInside];
    _scView = scrollView;
    // 添加传递过来的ScrollView观察者为自己,并且观察ScrollView的contentOffset属性
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)scrollToTopActionTouched:(UIButton *)button {
    
    [_scView setContentOffset:self.scrollToPoint animated:YES];
    
    if (self.completeBlock) {
        self.completeBlock(button);
    }
}
// contentOffset属性发生改变调用此方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGPoint point = [change[@"new"] CGPointValue];
    // 根据当前ScrollView的滚动情况决定按钮的显示情况
    self.hidden = point.y < self.showBtnFloat ? YES : NO;
}

- (void)dealloc {
    // 当试图控制器消失的时候移除观察者防止内存泄漏
    [_scView removeObserver:self forKeyPath:@"contentOffset"];
    NSLog(@"toTopButton-----dealloc!!!!!!!!!!");
}


@end
