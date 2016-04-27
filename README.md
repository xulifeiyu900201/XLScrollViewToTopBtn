XLScrollViewToTopBtn 
====================================
  ⭐️⭐️⭐"️iOS点击回到滚动视图顶部按钮"⭐️⭐️⭐
  作者邮箱:xuli_feiyu900201@sina.com(欢迎广大码友来稿喷)
====================================

###更新记录
* 2016年4月25日 删除了一些不必要的属性,修改了初始化为静态方法,更加方便创建; 修改了添加的方法,添加按钮只需要两部操作即可
* 2016年4月27日  1、重构了创建按钮的构造方法。2、增加了按钮的类型。3、增加了一次性设置按钮属性的方法。4、增加了对屏幕做适配的属性，两句代码适配所有屏幕。5、增加了查找视图所在控制器的工具类。6、第三种按钮类型暂时没有完善。7、解决了UITableViewController添加按钮失败的BUG

###按钮的使用(只需两步设置即可使用)
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
![image](http://images.cnblogs.com/cnblogs_com/xuli-feiyu900201/821110/o_Untitled.gif)
![image](http://images.cnblogs.com/cnblogs_com/xuli-feiyu900201/821110/o_Untitled2.gif)
![image](http://images.cnblogs.com/cnblogs_com/xuli-feiyu900201/821110/o_Snip20160427_2.png)

###版本升级只需要两次简单的设置就可以完美添加按钮并且设置约束,请看注意事项
    /*
    **************警告*****************

    1.btnSize 是设置按钮的宽高
    2.UIEdgeInsetsMake 是给按钮添加约束,括号中四个参数分别表示到父控件top,left,bottom,right的距离
    3.根据需求不同约束只需要设置前两个或者后两个就可以,即(按钮到顶部和左边缘的距离)或者(按钮到下边缘和右边缘的距离)
    4.按钮到下边缘和右边缘的距离为了方便大家的使用作者已将原来的负值转化成了正值,大家可以直接写正数就可以
    5.!!!!!!不要四个参数都去设置,不然会造成约束重复,大家都懂的.这里作者也是加以强调,防止约束重复带来不便(*^__^*) 嘻嘻……

    **************警告*****************

    */

###支持哪些滚动视图的使用
* UIScrollView、UITableView、UICollectionView、UIWebView

###提醒
* 本功能纯ARC，兼容的系统>=iOS6.0、iPhone\iPad横竖屏

###期待
 * 如果在使用过程中遇到BUG，希望你能Issues我，谢谢(或者尝试下载最新的示例代码看看BUG修复没有)
 * 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
 * 如果你想为作者输出代码，请拼命Pull Requests我,不甚感激
 
