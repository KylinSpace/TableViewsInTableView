//
//  KylinThreeViewController.h
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/9.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KylinThreeViewControllerDelegate<NSObject>
@optional
- (void)KylinThreeViewTableViewDidScroll:(CGFloat)scrollY;
@end
@interface KylinThreeViewController : UITableViewController
/**delegate*/
@property(nonatomic,weak)id<KylinThreeViewControllerDelegate> delegate;
@end
