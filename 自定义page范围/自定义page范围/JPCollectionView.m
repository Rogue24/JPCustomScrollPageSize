//
//  JPCollectionView.m
//  xxx
//
//  Created by xxx on 2017/5/4.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import "JPCollectionView.h"
#import "JPFlowLayout.h"
#import "JPCell.h"

@interface JPCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UIScrollView *placeholderSV;
@end

@implementation JPCollectionView

static NSString *const JPCellID = @"JPCell";
static NSInteger const MaxItemCount = 10;

+ (JPCollectionView *)collectionViewWithFrame:(CGRect)frame {
    JPFlowLayout *flowLayout = [[JPFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(frame.size.width * (200.0 / 375.0), frame.size.height);
    JPCollectionView *collectionView = [[self alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    return collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor yellowColor];
        
        [self registerClass:[JPCell class] forCellWithReuseIdentifier:JPCellID];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        
        JPFlowLayout *flowLayout = (JPFlowLayout *)layout;
        
        CGFloat width = flowLayout.itemSize.width + flowLayout.minimumLineSpacing;
        UIScrollView *placeholderSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
        placeholderSV.pagingEnabled = YES;
        placeholderSV.delegate = self;
        placeholderSV.showsHorizontalScrollIndicator = NO;
        [placeholderSV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [self addSubview:placeholderSV];
        self.placeholderSV = placeholderSV;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.placeholderSV) {
        self.contentOffset = scrollView.contentOffset;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view.tag == JPInteractionEnabledTag) {
        return view;
    }
    return self.placeholderSV;
}

- (void)tap:(UITapGestureRecognizer *)tapGR {
    CGPoint point = [tapGR locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    if (indexPath) {
        [self collectionView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.placeholderSV.contentSize = CGSizeMake(self.placeholderSV.jp_width * MaxItemCount, 0);
    return MaxItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JPCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JPCellID forIndexPath:indexPath];
    [cell.button setTitle:[NSString stringWithFormat:@"%zd", indexPath.item] forState:UIControlStateNormal];
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.placeholderSV setContentOffset:CGPointMake(indexPath.item * self.placeholderSV.jp_width, 0) animated:YES];
}



@end
