# JPCustomScrollPageSize

自定义page的翻页范围


![image](https://github.com/Rogue24/JPCustomScrollPageSize/raw/master/Cover/UuLZJX3xlJ.gif)


虽说`scrollView`有`pagingEnabled`这个属性可以实现翻页的效果，如果是整个翻页的区域为`scrollView的size`那就好，但想要只翻`半个scrollView`的宽度那怎么办呢？

实际上，`scrollView`的`pagingEnabled`的区域是根据`scrollView的size`来决定，也就是`scrollView`有多宽就翻多少啦。

如果是单纯的`scrollView`那就好办，直接设置`scrollView`的区域为想要翻页的尺寸，如果比屏幕小就设置`scrollView`的`clipsToBounds`为`NO`就好了，然后修改`hittest`让多余的空位的点击事件回传给`scrollView`就好了！

可是如果是`collectionView`并且设置其为屏幕一半的大小的话，由于`collectionView`的重用机制的原因，`collectionView`区域（不是`contentSize`，是`bounds`）以外的`cell`并不会提前显示，然后一直滚的话，超出区域的`cell`也会被立即重用直接移位到后面了。

所以。。。


## 一个简单粗暴的方法：使用一个占位的scrollView来实现！

1. 创建`collectionView`并实现的基本数据源、代理的方法。

这里我的`collectionView`的数据源和代理都为`collectionView自身（self）`，方便管理。

```obj
self.delegate = self;
self.dataSource = self;
self.scrollEnabled = NO; // 不需要自身来进行滚动
```

2. 在`collectionView`上添加一个`占位的scrollView`（专门用来翻页用的）。

```obj
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
	
3. 将`占位scrollView`的滚动手势【转移】到`collectionView`上。

```obj
[self addGestureRecognizer:placeholderSV.panGestureRecognizer];
```

PS：这样会覆盖原有的滚动手势，但不会影响到`collectionView`原来的其他手势事件（`collectionView`无法滚动了，手指拖动的是`占位scrollView`）。

4. 实现`scrollViewDidScroll`方法。

```obj
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.placeholderSV) {
        // 让占位scrollView来控制collectionView的偏移量
        self.contentOffset = scrollView.contentOffset;
    }
}
```

5. 设置`占位scrollView`的`contentSize`（总页数的宽度）。

```obj
// 翻页宽度 * 数据数量 
self.placeholderSV.contentSize = CGSizeMake(self.placeholderSV.frame.size.width * MaxItemCount, 0);

// 我选择在collectionView的数据源方法中设置contentSize，保证任何时候都跟collectionView的contentSize保持一致
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.placeholderSV.contentSize = CGSizeMake(self.placeholderSV.frame.size.width * MaxItemCount, 0); 
    return MaxItemCount;
}
```

---

## 结语

此时基本效果能实现了，然而弊端还是有的，因为`占位scrollView`覆盖了`collectionView`的滚动手势，所有`collectionView`滚动相关的操作都得交由`占位scrollView`去处理，例如通过自定义动画修改偏移量可能就有额外的处理。

如果有更好的实现方案请告诉我！

	扣扣：184669029
	博客：https://www.jianshu.com/u/2edfbadd451c
