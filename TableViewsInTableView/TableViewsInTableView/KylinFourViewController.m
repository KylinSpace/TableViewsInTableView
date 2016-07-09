//
//  KylinFourViewController.m
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/9.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import "KylinFourViewController.h"
static CGFloat const OffsetY = 200;
static NSString *const oneCell = @"oneCell";
@implementation KylinFourViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupConfigures];
}

- (void)setupConfigures{
    // 修改tableView的样式
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.rowHeight = 74;
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
    cell.imageView.image = [UIImage imageNamed:@"kylin_placeHolder"];
    cell.textLabel.text = @"white";
    return cell;
}

#pragma mark- 左滑删除相关代理方法

/**
 *  左滑cell时出现什么按钮
 */
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

        UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"添加" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            tableView.editing = NO;
        }];
        
        UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

            tableView.editing = NO;
        }];
        action0.backgroundColor = [UIColor colorWithRed:74/255.0 green:196/255.0 blue:189/255.0 alpha:1.0];
        return @[action1, action0];

    
}
#pragma mark- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(KylinFourViewTableViewDidScroll:)]) {
        [self.delegate KylinFourViewTableViewDidScroll:scrollView.contentOffset.y];
    }
}

@end
