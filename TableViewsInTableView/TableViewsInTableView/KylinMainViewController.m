//
//  KylinMainViewController.m
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/8.
//  Copyright © 2016年 Kylin. All rights reserved.
//  主按制器

#import "KylinMainViewController.h"
#import "KylinScrollView.h"
#import "Masonry.h"
#import "UIView+Kylin.h"
#import "KylinOneViewController.h"
#import "KylinTwoViewController.h"
#import "KylinThreeViewController.h"
#import "KylinFourViewController.h"

@interface KylinMainViewController ()<UIScrollViewDelegate,KylinOneViewControllerDelegate,KylinTwoViewControllerDelegate,KylinThreeViewControllerDelegate,KylinFourViewControllerDelegate>
/**标题数组*/
@property(nonatomic,strong)NSArray *titleArray;

/**头部视图*/
@property(nonatomic,weak)UIView *headerView;

/**标题view*/
@property(nonatomic,weak)UIScrollView *titleView;

/**内容的view*/
@property(nonatomic,weak)KylinScrollView *contentView;

/**选中的按钮*/
@property(nonatomic,strong)UIButton *currentSelectedBtn;
/**下划线*/
@property(nonatomic,weak)UIView *selectedUnderLine;

/**one*/
@property(nonatomic,weak)KylinOneViewController *oneVc;
/**two*/
@property(nonatomic,weak)KylinTwoViewController *twoVc;
/**three*/
@property(nonatomic,weak)KylinThreeViewController *threeVc;
/**four*/
@property(nonatomic,weak)KylinFourViewController *fourVc;

@end
//屏幕宽度
#define kScreenW [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define kScreenH [UIScreen mainScreen].bounds.size.height

static CGFloat const NavH = 64;
static CGFloat const HeaderH = 150;
static CGFloat const TitleViewH = 50;
static CGFloat const UnderLineH = 3;
static CGFloat const OffsetY = -200;
@implementation KylinMainViewController

#pragma mark- 懒加载属性
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"科技",@"热点",@"娱乐",@"体育"];
    }
    return _titleArray;
}
#pragma mark- viewDidLoad 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"TINT";
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加子控制器
    [self setupChildViewController];
    // 布局子控制排列样式
    [self setupChildViews];
    
    // 添加标题栏内容
    [self setupTitleView];
    
    [self addChildViewInContentView:0];

    // 添加标题栏下划线
    [self setupUnderLine];
    
}


// 添加子控件
- (void)setupChildViews{
    
    // 头部视图
    UIView *headerView = [[UIView alloc]init];
    _headerView = headerView;
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"bueaty2.jpg"];
    headerView.clipsToBounds = YES;
    [headerView addSubview:imageView];
    
    // 标题栏
    UIScrollView *titleView =[[UIScrollView alloc]init];
    _titleView = titleView;
    
    // 内容的view
    KylinScrollView *contentView = [[KylinScrollView alloc]init];
    _contentView = contentView;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(self.titleArray.count * kScreenW , 0);
    
    [self.view addSubview:contentView];
    [self.view addSubview:titleView];
    [self.view addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavH);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(HeaderH));
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];
    
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(TitleViewH));
    }];
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom);
        make.width.equalTo(@(kScreenW));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kScreenH - NavH));
    }];
    
    
}


// 添加标题view的按钮
- (void)setupTitleView{
    NSInteger count = self.titleArray.count;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitle:_titleArray[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:83/255.0 green:211/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnW = kScreenW / _titleArray.count;
        CGFloat btnH = TitleViewH;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH - UnderLineH);
        
        [self.titleView addSubview:btn];
        
        if (i == 0) {
            [self titleBtnClick:btn];
        }
   }
    
}


// 添加下划线
- (void)setupUnderLine{
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton = self.titleView.subviews.firstObject;
    UIView *underline = [[UIView alloc] init];
    CGFloat underlineH = 3;
    CGFloat underlineW =  kScreenW / [self titleArray].count;
    CGFloat underlineX = 0;
    CGFloat underlineY = TitleViewH - UnderLineH;
    underline.frame = CGRectMake(underlineX, underlineY, underlineW, underlineH);
    //设置下划线的颜色,根随按钮选中的颜色一致
    underline.backgroundColor = [selectButton titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:underline];
    self.selectedUnderLine = underline;
    
    [selectButton.titleLabel sizeToFit];
    selectButton.selected = YES;
    self.currentSelectedBtn = selectButton;
    
    self.selectedUnderLine.KWidth = selectButton.titleLabel.KWidth + 10;
    self.selectedUnderLine.KCenterX = selectButton.KCenterX;
    
}

// 添加子控制器
- (void)setupChildViewController{
    
    KylinOneViewController *oneVc = [[KylinOneViewController alloc]init];
    _oneVc = oneVc;
    oneVc.delegate = self;
    [self addChildViewController:oneVc];
    
    KylinTwoViewController *twoVc = [[KylinTwoViewController alloc]init];
    _twoVc = twoVc;
    twoVc.delegate = self;
    [self addChildViewController:twoVc];
    
    KylinThreeViewController *threeVc = [[KylinThreeViewController alloc]init];
    _threeVc = threeVc;
    threeVc.delegate = self;
    [self addChildViewController:threeVc];
    
    KylinFourViewController *fourVc = [[KylinFourViewController alloc]init];
    _fourVc = fourVc;
    fourVc.delegate = self;
    [self addChildViewController:fourVc];
}

// 添加相应的控制器的view到内容视图中
- (void)addChildViewInContentView:(NSInteger)index{
    
    UIViewController *childView = self.childViewControllers[index];
    [self.contentView addSubview:childView.view];
    childView.view.frame = CGRectMake(index * kScreenW, OffsetY, kScreenW, kScreenH + 85);
    
    // 取出要跳转的view
    KylinTwoViewController *twovc = (KylinTwoViewController *)childView;
    
    // 跳转时滚动到当前view 的offsetY位置
    [self KylinScrollToChangeHeaderViewHeight:twovc.tableView.contentOffset.y];
//    NSLog(@"第二个控制制 OFFSETY ----//%f",twovc.tableView.contentOffset.y);
}
#pragma mark- 点击事件
- (void)titleBtnClick:(UIButton *)button{
    
    self.currentSelectedBtn.selected = NO;
    button.selected = YES;
    self.currentSelectedBtn = button;
    
    NSInteger index = button.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedUnderLine.KWidth = button.titleLabel.KWidth + 10;
        self.selectedUnderLine.KCenterX = button.KCenterX;
    }completion:nil];
    
    self.contentView.contentOffset = CGPointMake(index * kScreenW, 0);
    
    [self addChildViewInContentView:index];
    
    _oneVc.tableView.scrollEnabled = YES;
    _twoVc.tableView.scrollEnabled = YES;
    _threeVc.tableView.scrollEnabled = YES;
    _fourVc.tableView.scrollEnabled = YES;

}

#pragma mark- TableViewScrollDelegate
/**
 *  通过代理接收每个子控制器的滚动Y值
 *
 *  @param scrollY 滚动了多少Y值
 */
- (void)KylinOneViewTableViewDidScroll:(CGFloat)scrollY{
    [self KylinScrollToChangeHeaderViewHeight:scrollY];
}

- (void)KylinTwoViewTableViewDidScroll:(CGFloat)scrollY{
    [self KylinScrollToChangeHeaderViewHeight:scrollY];

}
- (void)KylinThreeViewTableViewDidScroll:(CGFloat)scrollY{
    [self KylinScrollToChangeHeaderViewHeight:scrollY];

}
- (void)KylinFourViewTableViewDidScroll:(CGFloat)scrollY{
    [self KylinScrollToChangeHeaderViewHeight:scrollY];
 
}

// 动态计算滚动的Y值
- (void)KylinScrollToChangeHeaderViewHeight:(CGFloat)scrollY{
//    NSLog(@"%f",scrollY);
    
    CGFloat offsetY = scrollY - OffsetY;
    CGFloat height = HeaderH - offsetY;
    
    if (height > HeaderH) {
        height = HeaderH;
    }
    
    if (height < 0) {
        height = 0;
    }
    
   [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.view).offset(NavH);
       make.left.right.equalTo(self.view);
       make.height.equalTo(@(height));
   }];
    
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(TitleViewH));
    }];

}
#pragma mark- ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentView) {
        _oneVc.tableView.scrollEnabled = NO;
        _twoVc.tableView.scrollEnabled = NO;
        _threeVc.tableView.scrollEnabled = NO;
        _fourVc.tableView.scrollEnabled = NO;
        
    }

}
// 滚动切换控制器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.contentView) {
        _oneVc.tableView.scrollEnabled = YES;
        _twoVc.tableView.scrollEnabled = YES;
        _threeVc.tableView.scrollEnabled = YES;
        _fourVc.tableView.scrollEnabled = YES;

    }
    NSInteger index = scrollView.contentOffset.x / kScreenW;
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.titleView.subviews.count; i ++) {
        UIView *button = self.titleView.subviews[i];
        
        if (button.class == [UIButton buttonWithType:UIButtonTypeCustom].class) {
            [buttonArray addObject:button];
        }
    }
    
    UIButton *button = buttonArray[index];
    
    [self titleBtnClick:button];
    
}
@end
