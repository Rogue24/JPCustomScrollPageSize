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
//        placeholderSV.contentSize = CGSizeMake(width * MaxItemCount, 0);
        [self addSubview:placeholderSV];
        self.placeholderSV = placeholderSV;
        
        [self addGestureRecognizer:placeholderSV.panGestureRecognizer];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.placeholderSV) {
        self.contentOffset = scrollView.contentOffset;
    }
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.placeholderSV.contentSize = CGSizeMake(self.placeholderSV.jp_width * MaxItemCount, 0);
    return MaxItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JPCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JPCellID forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.placeholderSV setContentOffset:CGPointMake(indexPath.item * self.placeholderSV.jp_width, 0) animated:YES];
}

@end
