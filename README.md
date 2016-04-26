XLScrollViewToTopBtn 
====================================
  ⭐️⭐️⭐"️iOS点击回到滚动视图顶部按钮"⭐️⭐️⭐
====================================
更新记录
------------------------------------
  2016年4月25日 删除了一些不必要的属性,修改了初始化为静态方法,更加方便创建; 修改了添加的方法,添加按钮只需要两部操作即可
------------------------------------
###按钮的使用(只需两步设置即可使用)
    // 第一步:创建按钮
    XLToScrollViewTopBtn *btn = [XLToScrollViewTopBtn createWithBtnImageName:@"toTopButton" andRect:CGRectMake(300, 600, 50, 50) andScrollToPoint:CGPointMake(0, 0) andShowBtnFloat:300];
    // 第二部:设置要滚动的试图
    [btn scrollView:self.tableView clickButtonActionHandler:^(UIButton * _Nonnull btn) {
        NSLog(@"按钮被点击了");
    }];
###支持哪些滚动视图的使用
*UIScrollView、UITableView、UICollectionView、UIWebView
###提醒
本功能纯ARC，兼容的系统>=iOS6.0、iPhone\iPad横竖屏
###期待
 *如果在使用过程中遇到BUG，希望你能Issues我，谢谢(或者尝试下载最新的示例代码看看BUG修复没有)
 *如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
 *如果你想为作者输出代码，请拼命Pull Requests我,不甚感激
 
