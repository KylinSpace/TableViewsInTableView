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
@interface KylinMainViewController ()<UIScrollViewDelegate>
/**标题数组*/
@property(nonatomic,strong)NSArray *titleArray;

/**标题view*/
@property(nonatomic,weak)UIScrollView *titleView;

/**内容的view*/
@property(nonatomic,weak)KylinScrollView *contentView;

/**选中的按钮*/
@property(nonatomic,strong)UIButton *currentSelectedBtn;
/**下划线*/
@property(nonatomic,weak)UIView *selectedUnderLine;
@end
//屏幕宽度
#define kScreenW [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define kScreenH [UIScreen mainScreen].bounds.size.height

static CGFloat const NavH = 64;
static CGFloat const HeaderH = 100;
static CGFloat const TitleViewH = 50;
static CGFloat const UnderLineH = 3;
@implementation KylinMainViewController

#pragma mark- 懒加载属性
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"科技",@"热点",@"娱乐",@"体育",@"NEWS"];
    }
    return _titleArray;
}
#pragma mark- viewDidLoad 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 布局子控制排列样式
    [self setupChildViews];
    
    // 添加标题栏内容
    [self setupTitleView];
    
    // 添加标题栏下划线
    [self setupUnderLine];
    
}


// 添加子控件
- (void)setupChildViews{
    
    // 头部视图
    UIView *headerView = [[UIView alloc]init];
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
    contentView.backgroundColor = [UIColor lightGrayColor];
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
        make.height.equalTo(@(kScreenH - HeaderH));
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
    
}
@end
