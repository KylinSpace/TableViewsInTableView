//
//  KylinTwoViewController.m
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/9.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import "KylinTwoViewController.h"

static CGFloat const OffsetY = 200;
static NSString *const oneCell = @"oneCell";

@implementation KylinTwoViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupConfigures];
}


- (void)setupConfigures{
    // 修改tableView的样式
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.rowHeight = 100;
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
    cell.imageView.image = [UIImage imageNamed:@"kylin_Apple"];
    cell.textLabel.text = @"Apple";
    return cell;
}

#pragma mark- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(KylinTwoViewTableViewDidScroll:)]) {
        [self.delegate KylinTwoViewTableViewDidScroll:scrollView.contentOffset.y];
    }
}

@end
