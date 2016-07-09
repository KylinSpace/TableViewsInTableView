//
//  KylinTwoViewController.h
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/9.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KylinTwoViewControllerDelegate<NSObject>
@optional
- (void)KylinTwoViewTableViewDidScroll:(CGFloat)scrollY;
@end
@interface KylinTwoViewController : UITableViewController
/**代理*/
@property(nonatomic,weak)id<KylinTwoViewControllerDelegate> delegate;
@end
