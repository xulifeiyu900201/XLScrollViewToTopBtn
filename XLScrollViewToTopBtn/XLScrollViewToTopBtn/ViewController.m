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
    self.title = @"滚动到一定程度显示/隐藏";
    [self.view addSubview:self.tableView];
    /*
     **************用法*****************
     
     一、导入XLToScrollViewTopBtn.h
     二、创建按钮
     三、一次性设置设置需要用到的属性
     
     **************用法*****************
     
     */
    
    XLToScrollViewTopBtn *btn = [XLToScrollViewTopBtn createWithBtnType:XLToScrollViewTopBtnTypeNormal scrollView:self.tableView clickButtonActionHandler:^(UIButton * _Nonnull btn) {
        NSLog(@"按钮被点击了");
    }];
    [btn setUpBtnEffect:^(CGSize * _Nonnull btnSize, UIEdgeInsets * _Nonnull relaLoc, NSString *__autoreleasing  _Nullable * _Nullable imageName, CGPoint * _Nonnull scrollToPoint, CGFloat * _Nonnull showBtnFloat, NSTimeInterval * _Nonnull btnDisDur) {
        // 这两个属性必须设置,两句代码解决了所有的适配问题,注意以下警告问题
        //********************************************
        *btnSize = CGSizeMake(50, 50); //设置按钮的宽高
        *relaLoc = UIEdgeInsetsMake(600, 300, 0, 0); //给按钮添加约束
        //********************************************
        
        // 其他属性是可选设置的,根据项目需求不同可选设置,也可以不设置使用默认值
        //********************************************
        *imageName = @"toTopButton";
        //        *scrollToPoint = CGPointMake(0, 0);
        *showBtnFloat = 300;
        *btnDisDur = 3.0;
        //********************************************
    }];
#warning !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!适配问题使用注意说明
    /*
     **************警告*****************
     
     1.btnSize 是设置按钮的宽高
     2.UIEdgeInsetsMake 是给按钮添加约束,括号中四个参数分别表示到父控件top,left,bottom,right的距离
     3.根据需求不同约束只需要设置前两个或者后两个就可以,即(按钮到顶部和左边缘的距离)或者(按钮到下边缘和右边缘的距离)
     4.按钮到下边缘和右边缘的距离为了方便大家的使用作者已将原来的负值转化成了正值,大家可以直接写正数就可以
     5.!!!!!!不要四个参数都去设置,不然会造成约束重复,大家都懂的.这里作者也是加以强调,防止约束重复带来不便(*^__^*) 嘻嘻……
     
     **************警告*****************
     
     */
    
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
    cell.textLabel.text = [NSString stringWithFormat:@"BtnTypeNormal测试数据---%ld",indexPath.row];
    return cell;
}

@end
