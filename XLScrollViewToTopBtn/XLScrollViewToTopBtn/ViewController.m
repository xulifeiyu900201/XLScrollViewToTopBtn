//
//  ViewController.m
//  XLScrollViewToTopBtn
//
//  Created by 秦旭力 on 16/4/24.
//  Copyright © 2016年 XL Quin. All rights reserved.
//

#import "ViewController.h"
#import "XLToScrollViewTopBtn.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // 创建按钮
    XLToScrollViewTopBtn *btn = [[XLToScrollViewTopBtn alloc] initWithBtnImageName:@"toTopButton" andRect:CGRectMake(300, 600, 50, 50) andScrollToPoint:CGPointMake(0, 0) andShowBtnFloat:300];
    // 设置要滚动的试图
    [btn scrollView:self.tableView clickButtonActionHandler:^(UIButton * _Nonnull btn) {
        NSLog(@"按钮被点击了");
    }];
    // 添加到控制器视图
    [self.view addSubview:btn];
    
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
    return cell;
}

@end
