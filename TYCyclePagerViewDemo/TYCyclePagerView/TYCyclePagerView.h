//
//  TYCyclePagerView.h
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCyclePagerTransformLayout.h"

NS_ASSUME_NONNULL_BEGIN

// pagerView scrolling direction
typedef NS_ENUM(NSUInteger, TYPagerScrollDirection) {
    TYPagerScrollDirectionLeft,
    TYPagerScrollDirectionRight,
};

@class TYCyclePagerView;
@protocol TYCyclePagerViewDataSource <NSObject>

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView;

- (__kindof UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index;

/**
 return pagerView layout,and cache layout
 */
- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView;

@end

@protocol TYCyclePagerViewDelegate <NSObject>

@optional

/**
 pagerView did scroll to new index page
 */
- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

/**
 pagerView did selected item cell
 */
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index;

// custom layout
- (void)pagerView:(TYCyclePagerView *)pageView initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

- (void)pagerView:(TYCyclePagerView *)pageView applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;


// scrollViewDelegate

- (void)pagerViewDidScroll:(TYCyclePagerView *)pageView;

- (void)pagerViewWillBeginDragging:(TYCyclePagerView *)pageView;

- (void)pagerViewDidEndDragging:(TYCyclePagerView *)pageView willDecelerate:(BOOL)decelerate;

- (void)pagerViewWillBeginDecelerating:(TYCyclePagerView *)pageView;

- (void)pagerViewDidEndDecelerating:(TYCyclePagerView *)pageView;

- (void)pagerViewWillBeginScrollingAnimation:(TYCyclePagerView *)pageView;

- (void)pagerViewDidEndScrollingAnimation:(TYCyclePagerView *)pageView;

@end


@interface TYCyclePagerView : UIView

// will be automatically resized to track the size of the pagerView
@property (nonatomic, strong, nullable) UIView *backgroundView; 

@property (nonatomic, weak, nullable) id<TYCyclePagerViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id<TYCyclePagerViewDelegate> delegate;

// pager view, don't set dataSource and delegate
@property (nonatomic, weak, readonly) UICollectionView *collectionView;
// pager view layout
@property (nonatomic, strong, readonly) TYCyclePagerViewLayout *layout;

/**
 is infinite cycle pageview
 */
@property (nonatomic, assign) BOOL isInfiniteLoop;

/**
 pagerView automatic scroll time interval, default 0,disable automatic
 */
@property (nonatomic, assign) CGFloat autoScrollInterval;

/**
 current page index
 */
@property (nonatomic, assign, readonly) NSInteger curIndex;

// scrollView property
@property (nonatomic, assign, readonly) CGPoint contentOffset;
@property (nonatomic, assign, readonly) BOOL tracking;
@property (nonatomic, assign, readonly) BOOL dragging;
@property (nonatomic, assign, readonly) BOOL decelerating;


/**
 reload data, !!important!!: will clear layout and call delegate layoutForPagerView
 */
- (void)reloadData;

/**
 update data is reload data, but not clear layuot
 */
- (void)updateData;

/**
 if you only want update layout
 */
- (void)setNeedUpdateLayout;

/**
 will set layout nil and call delegate->layoutForPagerView
 */
- (void)setNeedClearLayout;

/**
 current index cell in pagerView
 */
- (__kindof UICollectionViewCell * _Nullable)curIndexCell;

/**
 visible cells in pageView
 */
- (NSArray<__kindof UICollectionViewCell *> *_Nullable)visibleCells;


/**
 visible pageView indexs, maybe repeat index
 */
- (NSArray *)visibleIndexs;

/**
 scroll to item at index
 */
- (void)scrollToItemAtIndex:(NSInteger)index animate:(BOOL)animate;

/**
 scroll to next or pre item
 */
- (void)scrollToNearlyIndexAtDirection:(TYPagerScrollDirection)direction animate:(BOOL)animate;

/**
 register pager view cell with class
 */
- (void)registerClass:(Class)Class forCellWithReuseIdentifier:(NSString *)identifier;

/**
 register pager view cell with nib
 */
- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;

/**
 dequeue reusable cell for pagerView
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
