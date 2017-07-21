# TYCyclePagerView
a simple and usefull cycle pager view ,and auto scroll banner view for iOS,support Objective-C and swift.

## Requirements
* Xcode 7 or higher
* iOS 7.0 or higher
* ARC

### ScreenShot

![image](https://github.com/12207480/TYCyclePagerView/blob/master/ScreenShot/TYCyclePagerView.gif)

## API

*  DataSorce and Delegate 
```objc

@protocol TYCyclePagerViewDataSource <NSObject>

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView;

- (__kindof UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index;

/**
 return pagerView layout,and cache layout
 */
- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView;

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

// More API see project
```

* Properties

```objc

@interface TYCyclePagerView : UIView

// will be automatically resized to track the size of the pagerView
@property (nonatomic, strong, nullable) UIView *backgroundView; 

@property (nonatomic, weak, nullable) id<TYCyclePagerViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id<TYCyclePagerViewDelegate> delegate;

// pager view layout is important
@property (nonatomic, strong, readonly) TYCyclePagerViewLayout *layout;

/**
 is infinite cycle pageview
 */
@property (nonatomic, assign) BOOL isInfiniteLoop;

/**
 pagerView automatic scroll time interval, default 0,disable automatic
 */
@property (nonatomic, assign) CGFloat autoScrollInterval;

```

## Usage

```objc


```

### Contact
如果你发现bug，please pull reqeust me <br>
如果你有更好的改进，please pull reqeust me <br>
