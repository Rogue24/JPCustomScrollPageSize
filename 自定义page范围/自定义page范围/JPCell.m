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
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.layer.backgroundColor = UIColor.greenColor.CGColor;
        titleLabel.font = [UIFont systemFontOfSize:30];
        titleLabel.textColor = [UIColor blueColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width * 0.5;
    CGFloat h = self.bounds.size.height * 0.5;
    CGFloat x = w * 0.5;
    CGFloat y = h * 0.5;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
}

@end
