# JPCustomScrollPageSize

自定义page的翻页范围


![image](https://github.com/Rogue24/JPCustomScrollPageSize/raw/master/Cover/UuLZJX3xlJ.gif)


虽说scrollView有pagingEnabled这个属性可以实现翻页的效果，如果是整个翻页的区域为scrollView的size那就好，但想要只翻半个scrollView的宽度那怎么办呢？

实际上，scrollView的pagingEnabled的区域是根据scrollView的size来决定，也就是scrollView有多宽就翻多少啦。

如果是单纯的scrollView那就好办，直接设置scrollView的区域为想要翻页的尺寸，如果比屏幕小就设置scrollView的clipsToBounds为NO就好了，然后修改hittest让多余的空位的点击事件回传给scrollView就好了！

可是如果是collectionView并且设置其为屏幕一半的大小的话，由于collectionView的重用机制的原因，collectionView区域（不是contentSize，是bounds）以外的cell并不会提前显示，然后一直滚的话，超出区域的cell也会被立即重用直接移位到后面了。

所以。。。


## 一个简单粗暴的方法：使用一个占位的scrollView来实现！

1.创建collectionView并实现的基本数据源、代理的方法，这里我的collectionView的数据源和代理都为collectionView自身（self），方便管理。

```ruby
self.delegate = self;
self.dataSource = self;
self.scrollEnabled = NO; // 不需要自身来进行滚动
```

2.在collectionView上添加一个占位的scrollView（专门用来翻页用的）。

```ruby
// 先从collectionViewLayout中获取翻一页的宽度
// 【我这里的一页宽度就是一个cell的宽度加上间距】
JPFlowLayout *flowLayout = (JPFlowLayout *)layout;
CGFloat width = flowLayout.itemSize.width + flowLayout.minimumLineSpacing;

// 创建占位的scrollView，设置成一页的宽度
// 这里只有水平滚动，所以只设置宽度即可，位置则随意
UIScrollView *placeholderSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, 0)]; 
placeholderSV.pagingEnabled = YES;
placeholderSV.delegate = self;
placeholderSV.showsHorizontalScrollIndicator = NO;

// 添加到collectionView上
[self addSubview:placeholderSV];
self.placeholderSV = placeholderSV;
```
	
3.修改hitTest方法，让占位scrollView以外的点击事件都能接收到。

```ruby
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return self.placeholderSV;
}
```

4.实现scrollViewDidScroll方法。

```ruby
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.placeholderSV) {
        // 让占位scrollView来控制collectionView的偏移量
        self.contentOffset = scrollView.contentOffset;
    }
}
```

5.设置占位scrollView的contentSize（总页数的宽度）。

```ruby
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 我选择在collectionView的数据源方法中设置contentSize
    // 保证跟collectionView的contentSize保持一致
    self.placeholderSV.contentSize = CGSizeMake(self.placeholderSV.jp_width * MaxItemCount, 0); // 翻页宽度 * 数据数量 
    return MaxItemCount;
}
```

---

现在能实现基本的翻页效果了，但是，此时所有的点击事件都被占位scrollView拦截了，怎么让cell的点击传给collectionView呢？

#### 在占位scrollView添加手势传递事件
```ruby
  // 1.添加一个tap手势
[placeholderSV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];

// 监听tap手势
- (void)tap:(UITapGestureRecognizer *)tapGR {
    CGPoint point = [tapGR locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    if (indexPath) {
        [self collectionView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 使用占位scrollView滚动目标位置（这里我是滚到屏幕中心）
    [self.placeholderSV setContentOffset:CGPointMake(indexPath.item * self.placeholderSV.jp_width, 0) animated:YES];
}
```

## 结语
此时基本效果能实现了，然而弊端还是有的，因为占位scrollView拦截了collectionView的所有点击事件，而我这里只处理了单击事件，例如collectionView的cell拖动，那么就要把占位scrollView的拦截关掉。
如果有更好的实现方案请告诉我！

	邮箱：zhoujianping24@hotmail.com
	博客：https://www.jianshu.com/u/2edfbadd451c
