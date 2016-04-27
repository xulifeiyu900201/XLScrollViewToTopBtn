//  代码地址: https://github.com/xulifeiyu900201/XLScrollViewToTopBtn
//  个人邮箱: xuli_feiyu900201@sina.com
//  XLToScrollViewTopBtn.h
//  XLScrollViewToTopBtn
//
//  Created by 秦旭力 on 16/4/24.
//  Copyright © 2016年 XL Quin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XLToScrollViewTopBtnType) {
    XLToScrollViewTopBtnTypeNormal = 0, // 按钮随视图滚动偏移一定程度出现或者消失
    XLToScrollViewTopBtnTypeDownRoll, // 视图只有向下滚动时出现
    XLToScrollViewTopBtnTypeDecelerat // 按钮随视图开始滚动时出现,滚动之后一段时间消失 (此类型暂未开启)
};

@interface XLToScrollViewTopBtn : UIButton

/**
 *  初始化方法
 *
 *  @param topBtnType   设置创建按钮的类型
 *  @param scrollView   要控制的ScrollView对象
 *  @param touchHandler 按钮点击回调的block
 */
+ (instancetype)createWithBtnType:(XLToScrollViewTopBtnType)topBtnType scrollView:(UIScrollView *__unsafe_unretained)scrollView clickButtonActionHandler:(nullable void(^)(UIButton *btn))touchHandler;

/**
 *  一次性设置按钮所有需要用到的属性
 *  @param btnSize 设置按钮的宽高
 *  @param relaLoc 设置按钮的相对位置
 *  @param imageName 设置按钮的图片名称
 *  @param scrollToPoint 设置按钮的滚动位置,如果不设置默认返回顶部
 *  @param showBtnFloat 类型为XLToScrollViewTopBtnTypeNormal时设置显示按钮的位置
 *  @param btnDisDur 设置按钮的时间间隔 (此类型暂未开启)
 */
- (void)setUpBtnEffect:(void(^)(CGSize *btnSize,UIEdgeInsets *relaLoc, NSString * _Nullable * _Nullable imageName,CGPoint *scrollToPoint,CGFloat *showBtnFloat,NSTimeInterval *btnDisDur))topBtnEffectBlock;

NS_ASSUME_NONNULL_END

@end
