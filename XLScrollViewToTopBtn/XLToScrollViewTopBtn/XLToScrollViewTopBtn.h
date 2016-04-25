//
//  XLToScrollViewTopBtn.h
//  XLScrollViewToTopBtn
//
//  Created by 秦旭力 on 16/4/24.
//  Copyright © 2016年 XL Quin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLToScrollViewTopBtn : UIButton

/**
 *  初始化方法
 *
 *  @param imageName     设置按钮图片的名字
 *  @param rect          按钮位置宽高
 *  @param scrollToPoint 设置滚动视图滚动的偏移量坐标,如果不设置默认为zero(滚动到顶部)
 *  @param showBtnFloat  设置滚动视图偏移量为多少时显示按钮,如果不设置默认为zero点
 */
+ (instancetype)createWithBtnImageName:(NSString *)imageName andRect:(CGRect)rect andScrollToPoint:(CGPoint)scrollToPoint andShowBtnFloat:(CGFloat)showBtnFloat;

/**
 *  设置按钮控制scrollerView视图的滚动方法
 *
 *  @param scrollView   被控制的滚动视图对象
 *  @param touchHandler 点击按钮的block回调
 */
- (void)scrollView:(UIScrollView *__unsafe_unretained)scrollView clickButtonActionHandler:(nullable void(^)(UIButton *btn))touchHandler;

NS_ASSUME_NONNULL_END

@end
