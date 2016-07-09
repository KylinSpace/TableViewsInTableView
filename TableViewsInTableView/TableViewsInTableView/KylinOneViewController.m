//
//  KylinOneViewController.m
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/9.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import "KylinOneViewController.h"
static CGFloat const OffsetY = 200;
static NSString *const oneCell = @"oneCell";
@implementation KylinOneViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupConfigures];
}

- (void)setupConfigures{
    // 修改tableView的样式
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:oneCell];
    tableView.rowHeight = 100;
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(OffsetY - 25, 0, -35, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
    }
    cell.imageView.image = [UIImage imageNamed:@"kylinLogo"];
    cell.textLabel.text = @"kylin";
    return cell;
}

#pragma mark- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(KylinOneViewTableViewDidScroll:)]) {
        [self.delegate KylinOneViewTableViewDidScroll:scrollView.contentOffset.y];
    }
}
@end
