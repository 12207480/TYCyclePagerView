//
//  TYPageControl.m
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/20.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TYPageControl.h"

@interface TYPageControl ()
// UI
@property (nonatomic, strong) NSArray<UIImageView *> *indicatorViews;

// Data
@property (nonatomic, assign) BOOL forceUpdate;

@end

@implementation TYPageControl

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configurePropertys];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configurePropertys];
    }
    return self;
}

- (void)configurePropertys {
    self.userInteractionEnabled = NO;
    _forceUpdate = NO;
    _animateDuring = 0.3;
    _pageIndicatorSpaing = 10;
    _indicatorImageContentMode = UIViewContentModeCenter;
    _pageIndicatorSize = CGSizeMake(6,6);
    _currentPageIndicatorSize = _pageIndicatorSize;
    _pageIndicatorTintColor = [UIColor colorWithRed:128/255. green:128/255. blue:128/255. alpha:1];
    _currentPageIndicatorTintColor = [UIColor whiteColor];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        _forceUpdate = YES;
        [self updateIndicatorViews];
        _forceUpdate = NO;
    }
}

#pragma mark - getter setter

- (CGSize)contentSize {
    CGFloat width = (_indicatorViews.count - 1) * (_pageIndicatorSize.width + _pageIndicatorSpaing) + _pageIndicatorSize.width + _contentInset.left +_contentInset.right;
    CGFloat height = _currentPageIndicatorSize.height + _contentInset.top + _contentInset.bottom;
    return CGSizeMake(width, height);
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    if (numberOfPages == _numberOfPages) {
        return;
    }
    _numberOfPages = numberOfPages;
    if (_currentPage >= numberOfPages) {
        _currentPage = 0;
    }
    [self updateIndicatorViews];
    if (_indicatorViews.count > 0) {
        [self setNeedsLayout];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage || _indicatorViews.count <= currentPage) {
        return;
    }
    _currentPage = currentPage;
    if (!CGSizeEqualToSize(_currentPageIndicatorSize, _pageIndicatorSize)) {
        [self setNeedsLayout];
    }
    [self updateIndicatorViewsBehavior];
    if (self.userInteractionEnabled) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage animate:(BOOL)animate {
    if (animate) {
        [UIView animateWithDuration:_animateDuring animations:^{
            [self setCurrentPage:currentPage];
        }];
    }else {
        [self setCurrentPage:currentPage];
    }
}

- (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage {
    _pageIndicatorImage = pageIndicatorImage;
    [self updateIndicatorViewsBehavior];
}

- (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage {
    _currentPageIndicatorImage = currentPageIndicatorImage;
    [self updateIndicatorViewsBehavior];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self updateIndicatorViewsBehavior];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self updateIndicatorViewsBehavior];
}

- (void)setPageIndicatorSize:(CGSize)pageIndicatorSize {
    if (CGSizeEqualToSize(_pageIndicatorSize, pageIndicatorSize)) {
        return;
    }
    _pageIndicatorSize = pageIndicatorSize;
    if (CGSizeEqualToSize(_currentPageIndicatorSize, CGSizeZero) || (_currentPageIndicatorSize.width < pageIndicatorSize.width && _currentPageIndicatorSize.height < pageIndicatorSize.height)) {
        _currentPageIndicatorSize = pageIndicatorSize;
    }
    if (_indicatorViews.count > 0) {
        [self setNeedsLayout];
    }
}

- (void)setPageIndicatorSpaing:(CGFloat)pageIndicatorSpaing {
    _pageIndicatorSpaing = pageIndicatorSpaing;
    if (_indicatorViews.count > 0) {
        [self setNeedsLayout];
    }
}

- (void)setCurrentPageIndicatorSize:(CGSize)currentPageIndicatorSize {
    if (CGSizeEqualToSize(_currentPageIndicatorSize, currentPageIndicatorSize)) {
        return;
    }
    _currentPageIndicatorSize = currentPageIndicatorSize;
    if (_indicatorViews.count > 0) {
        [self setNeedsLayout];
    }
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    [super setContentHorizontalAlignment:contentHorizontalAlignment];
    if (_indicatorViews.count > 0) {
        [self setNeedsLayout];
    }
}

- (void)setContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment {
    [super setContentVerticalAlignment:contentVerticalAlignment];
    if (_indicatorViews.count > 0) {
        [self setNeedsLayout];
    }
}

#pragma mark - update indicator

- (void)updateIndicatorViews {
    if (!self.superview && !_forceUpdate) {
        return;
    }
    if (_indicatorViews.count == _numberOfPages) {
        [self updateIndicatorViewsBehavior];
        return;
    }
    NSMutableArray *indicatorViews = _indicatorViews ? [_indicatorViews mutableCopy] :[NSMutableArray array];
    if (indicatorViews.count < _numberOfPages) {
        for (NSInteger idx = indicatorViews.count; idx < _numberOfPages; ++idx) {
            UIImageView *indicatorView = [[UIImageView alloc]init];
            indicatorView.contentMode = _indicatorImageContentMode;
            [self addSubview:indicatorView];
            [indicatorViews addObject:indicatorView];
        }
    }else if (indicatorViews.count > _numberOfPages) {
        for (NSInteger idx = indicatorViews.count - 1; idx >= _numberOfPages; --idx) {
            UIImageView *indicatorView = indicatorViews[idx];
            [indicatorView removeFromSuperview];
            [indicatorViews removeObjectAtIndex:idx];
        }
    }
    _indicatorViews = [indicatorViews copy];
    [self updateIndicatorViewsBehavior];
}

- (void)updateIndicatorViewsBehavior {
    if (_indicatorViews.count == 0 || (!self.superview && !_forceUpdate)) {
        return;
    }
    if (_hidesForSinglePage && _indicatorViews.count == 1) {
        UIImageView *indicatorView = _indicatorViews.lastObject;
        indicatorView.hidden = YES;
    }
    NSInteger index = 0;
    for (UIImageView *indicatorView in _indicatorViews) {
        if (_pageIndicatorImage) {
            indicatorView.contentMode = _indicatorImageContentMode;
            indicatorView.image = _currentPage == index ? _currentPageIndicatorImage : _pageIndicatorImage;
        }else {
            indicatorView.image = nil;
            indicatorView.backgroundColor = _currentPage == index ? _currentPageIndicatorTintColor : _pageIndicatorTintColor;
        }
        indicatorView.hidden = NO;
        ++index;
    }
}

#pragma mark - layout

- (void)layoutIndicatorViews {
    if (_indicatorViews.count == 0) {
        return;
    }
    CGFloat orignX = 0;
    CGFloat centerY = 0;
    CGFloat pageIndicatorSpaing = _pageIndicatorSpaing;
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentCenter:
            // ignore contentInset
            orignX = (CGRectGetWidth(self.frame) - (_indicatorViews.count - 1) * (_pageIndicatorSize.width + _pageIndicatorSpaing) - _pageIndicatorSize.width)/2;
            break;
        case UIControlContentHorizontalAlignmentLeft:
            orignX = _contentInset.left;
            break;
        case UIControlContentHorizontalAlignmentRight:
            orignX = CGRectGetWidth(self.frame) - ((_indicatorViews.count - 1) * (_pageIndicatorSize.width + _pageIndicatorSpaing) - _pageIndicatorSize.width) - _contentInset.right;
            break;
        case UIControlContentHorizontalAlignmentFill:
            orignX = _contentInset.left;
            if (_indicatorViews.count > 1) {
                pageIndicatorSpaing = (CGRectGetWidth(self.frame) - _contentInset.left - _contentInset.right - _pageIndicatorSize.width - (_indicatorViews.count - 1) * _pageIndicatorSize.width)/(_indicatorViews.count - 1);
            }
            break;
        default:
            break;
    }
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentCenter:
            centerY = CGRectGetHeight(self.frame)/2;
            break;
        case UIControlContentVerticalAlignmentTop:
            centerY = _contentInset.top + _currentPageIndicatorSize.height/2;
            break;
        case UIControlContentVerticalAlignmentBottom:
            centerY = CGRectGetHeight(self.frame) - _currentPageIndicatorSize.height/2 - _contentInset.bottom;
            break;
        case UIControlContentVerticalAlignmentFill:
            centerY = (CGRectGetHeight(self.frame) - _contentInset.top - _contentInset.bottom)/2 + _contentInset.top;
            break;
        default:
            break;
    }
    NSInteger index = 0;
    for (UIImageView *indicatorView in _indicatorViews) {
        if (_pageIndicatorImage) {
            indicatorView.layer.cornerRadius = 0;
        }else {
            indicatorView.layer.cornerRadius = _currentPage == index ? _currentPageIndicatorSize.width/2 : _pageIndicatorSize.width/2;
        }
        CGSize size = index == _currentPage ? _currentPageIndicatorSize : _pageIndicatorSize;
        indicatorView.frame = CGRectMake(orignX - (size.width - _pageIndicatorSize.width)/2, centerY - size.height/2, size.width, size.height);
        orignX += _pageIndicatorSize.width + pageIndicatorSpaing;
        ++index;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIndicatorViews];
}

@end
