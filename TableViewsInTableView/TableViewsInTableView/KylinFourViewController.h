//
//  KylinFourViewController.h
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/9.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KylinFourViewControllerDelegate<NSObject>
@optional
- (void)KylinFourViewTableViewDidScroll:(CGFloat)scrollY;
@end
@interface KylinFourViewController : UITableViewController
/**delegate*/
@property(nonatomic,weak)id<KylinFourViewControllerDelegate> delegate;
@end
