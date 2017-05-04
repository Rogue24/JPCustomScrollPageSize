//
//  JPFlowLayout.m
//  xxx
//
//  Created by ios app on 16/2/17.
//  Copyright © 2016年 cb2015. All rights reserved.
//

#import "JPFlowLayout.h"

@implementation JPFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 修改内边距（让第一个和最后一个cell能居中）
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //先用super调用此方法，获取super已经计算好的所有布局属性（原本的样式）
    rect.origin.x -= self.collectionView.jp_width * 2;
    rect.origin.x = rect.origin.x < 0 ? 0 : rect.origin.x;
    rect.size.width += self.collectionView.jp_width * 2;
    
    NSArray *array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    //计算此刻 collectionView窗口的中心点 在 collectionView的contentSize上 相对距离的x点
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //在super计算好的布局属性的基础上，进行修改
    for (UICollectionViewLayoutAttributes *attri in array) {
        
        //cell的中心点x此刻与collectionView窗口的中心点的间距
        CGFloat delta = ABS(attri.center.x - centerX);
        
        //根据间距值计算cell的缩放比例
        CGFloat scale = 1 - 0.2 * (delta / self.collectionView.jp_width);
        attri.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES; 
}

@end
