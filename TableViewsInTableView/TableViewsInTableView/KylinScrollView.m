//
//  KylinScrollView.m
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/8.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import "KylinScrollView.h"

@implementation KylinScrollView

// 该方法实现，如果一个手势没有被识别，那么多个手势可以被识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (gestureRecognizer.state != 0) {
        return YES;
    }else{
        return NO;
    }
}
@end
