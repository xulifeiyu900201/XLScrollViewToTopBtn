//
//  TwoViewController.m
//  XLScrollViewToTopBtn
//
//  Created by 秦旭力 on 16/4/27.
//  Copyright © 2016年 XL Quin. All rights reserved.
//

#import "TwoViewController.h"
#import "XLToScrollViewTopBtn.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"只要向下滚动视图就显示/其他隐藏";
    // Do any additional setup after loading the view.
    XLToScrollViewTopBtn *btn = [XLToScrollViewTopBtn createWithBtnType:XLToScrollViewTopBtnTypeDownRoll scrollView:self.tableView clickButtonActionHandler:^(UIButton * _Nonnull btn) {
        NSLog(@"按钮被点击了");
    }];
    [btn setUpBtnEffect:^(CGSize * _Nonnull btnSize, UIEdgeInsets * _Nonnull relaLoc, NSString *__autoreleasing  _Nullable * _Nullable imageName, CGPoint * _Nonnull scrollToPoint, CGFloat * _Nonnull showBtnFloat, NSTimeInterval * _Nonnull btnDisDur) {
        *btnSize = CGSizeMake(45, 45);
        *relaLoc = UIEdgeInsetsMake(0, 0, 20, 20);
        *imageName = @"toTopButton";
        
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"BtnTypeDownRoll测试数据---%ld",indexPath.row];
    return cell;
}

@end
