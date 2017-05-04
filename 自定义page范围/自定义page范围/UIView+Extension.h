//
//  UIView+Extension.h
//  xxx
//
//  Created by apple on 16/7/4.
//  Copyright (c) 2015年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat jp_x;
@property (nonatomic, assign) CGFloat jp_y;
@property (nonatomic, assign) CGFloat jp_centerX;
@property (nonatomic, assign) CGFloat jp_centerY;
@property (nonatomic, assign) CGFloat jp_width;
@property (nonatomic, assign) CGFloat jp_height;
@property (nonatomic, assign) CGSize jp_size;
@property (nonatomic, assign) CGPoint jp_origin;
@property (nonatomic, assign, readonly) CGFloat jp_maxX;
@property (nonatomic, assign, readonly) CGFloat jp_maxY;
@end
