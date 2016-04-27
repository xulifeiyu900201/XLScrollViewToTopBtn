//
//  SelfViewController.m
//  XLScrollViewToTopBtn
//
//  Created by 秦旭力 on 16/4/27.
//  Copyright © 2016年 XL Quin. All rights reserved.
//

#import "SelfViewController.h"

@implementation SelfViewController

+ (UIViewController *)viewController:(UIView *)view
{
    UIResponder *responder = view.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

@end
