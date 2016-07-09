//
//  KylinOneViewController.h
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/9.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KylinOneViewControllerDelegate<NSObject>
@optional
- (void)KylinOneViewTableViewDidScroll:(CGFloat)scrollY;
@end

@interface KylinOneViewController : UITableViewController
/**代理*/
@property(nonatomic,weak)id<KylinOneViewControllerDelegate> delegate;
@end
