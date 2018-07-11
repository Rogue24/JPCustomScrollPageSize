//
//  JPCell.m
//  xxx
//
//  Created by xxx on 2017/5/4.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import "JPCell.h"

@implementation JPCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        UIButton *button = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.tag = JPInteractionEnabledTag;
            btn.backgroundColor = [UIColor greenColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:30];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        [self.contentView addSubview:button];
        self.button = button;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width * 0.5;
    CGFloat h = self.bounds.size.height * 0.5;
    CGFloat x = w * 0.5;
    CGFloat y = h * 0.5;
    self.button.frame = CGRectMake(x, y, w, h);
}

- (void)btnDidClick {
    NSLog(@"%@", [NSString stringWithFormat:@"我是第%@个", [self.button titleForState:UIControlStateNormal]]);
}

@end
