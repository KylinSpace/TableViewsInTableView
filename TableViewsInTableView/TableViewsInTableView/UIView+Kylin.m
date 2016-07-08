//
//  UIView+Kylin.m
//  TableViewsInTableView
//
//  Created by Kylin on 16/7/8.
//  Copyright © 2016年 Kylin. All rights reserved.
//

#import "UIView+Kylin.h"

@implementation UIView (Kylin)

- (void)setKWidth:(CGFloat)KWidth
{
    CGRect frame = self.frame;
    frame.size.width = KWidth;
    self.frame = frame;
}


- (void)setKHeight:(CGFloat)KHeight
{
    CGRect frame = self.frame;
    frame.size.height = KHeight;
    self.frame = frame;
}

- (void)setKx:(CGFloat)Kx
{
    CGRect frame = self.frame;
    frame.origin.x = Kx;
    self.frame = frame;
}

- (void)setKy:(CGFloat)Ky
{
    CGRect frame = self.frame;
    frame.origin.y = Ky;
    self.frame = frame;
}

- (CGFloat)KWidth
{
    return self.frame.size.width;
}

- (CGFloat)KHeight
{
    return self.frame.size.height;
}

- (CGFloat)Kx
{
    return self.frame.origin.x;
}

- (CGFloat)Ky
{
    return self.frame.origin.y;
}

-(void)setKCenterX:(CGFloat)KCenterX{
    CGPoint center = self.center;
    center.x = KCenterX;
    self.center = center;
}

- (CGFloat)KCenterX
{
    return self.center.x;
}

- (void)setKCenterY:(CGFloat)KCenterY
{
    CGPoint center = self.center;
    center.y = KCenterY;
    self.center = center;
}

- (CGFloat)KCenterY
{
    return self.center.y;
}
@end
