//
//  SelfViewController.h
//  XLScrollViewToTopBtn
//
//  Created by 秦旭力 on 16/4/27.
//  Copyright © 2016年 XL Quin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SelfViewController : NSObject
/**
 *  找到view所在的vc
 *
 *  @param view 需要查找的view
 *
 *  @return view所在的vc
 */
+ (UIViewController *)viewController:(UIView *)view;
@end
