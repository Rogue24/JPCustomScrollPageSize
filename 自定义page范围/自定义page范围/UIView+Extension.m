//
//  UIView+Extension.m
//  Weibo
//
//  Created by apple on 16/7/4.
//  Copyright (c) 2015年 xxx. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setJp_x:(CGFloat)jp_x {
    CGRect frame = self.frame;
    frame.origin.x = jp_x;
    self.frame = frame;
}

- (CGFloat)jp_x {
    return self.frame.origin.x;
}

- (void)setJp_y:(CGFloat)jp_y {
    CGRect frame = self.frame;
    frame.origin.y = jp_y;
    self.frame = frame;
}

- (CGFloat)jp_y {
    return self.frame.origin.y;
}

- (void)setJp_centerX:(CGFloat)jp_centerX {
    CGPoint center = self.center;
    center.x = jp_centerX;
    self.center = center;
}

- (CGFloat)jp_centerX {
    return self.center.x;
}

- (void)setJp_centerY:(CGFloat)jp_centerY {
    CGPoint center = self.center;
    center.y = jp_centerY;
    self.center = center;
}

- (CGFloat)jp_centerY {
    return self.center.y;
}

- (void)setJp_width:(CGFloat)jp_width {
    CGRect frame = self.frame;
    frame.size.width = jp_width;
    self.frame = frame;
}

- (CGFloat)jp_width {
    return self.frame.size.width;
}

- (void)setJp_height:(CGFloat)jp_height {
    CGRect frame = self.frame;
    frame.size.height = jp_height;
    self.frame = frame;
}

- (CGFloat)jp_height {
    return self.frame.size.height;
}

- (void)setJp_size:(CGSize)jp_size {
    CGRect frame = self.frame;
    frame.size = jp_size;
    self.frame = frame;
}

- (CGSize)jp_size {
    return self.frame.size;
}

- (void)setJp_origin:(CGPoint)jp_origin {
    CGRect frame = self.frame;
    frame.origin = jp_origin;
    self.frame = frame;
}

- (CGPoint)jp_origin {
    return self.frame.origin;
}

- (CGFloat)jp_maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)jp_maxY {
    return CGRectGetMaxY(self.frame);
}

@end
