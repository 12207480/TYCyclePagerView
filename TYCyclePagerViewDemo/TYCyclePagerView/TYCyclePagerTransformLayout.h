//
//  TYCyclePagerViewLayout.h
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/19.
//  Copyright © 2017年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TYCyclePagerTransformLayoutType) {
    TYCyclePagerTransformLayoutNormal,
    TYCyclePagerTransformLayoutLinear,
    TYCyclePagerTransformLayoutCoverflow,
};


@class TYCyclePagerTransformLayout;
@protocol TYCyclePagerTransformLayoutDelegate <NSObject>

- (void)pagerViewTransformLayout:(TYCyclePagerTransformLayout *)pagerViewTransformLayout initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

- (void)pagerViewTransformLayout:(TYCyclePagerTransformLayout *)pagerViewTransformLayout applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;

@end


@interface TYCyclePagerViewLayout : NSObject

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) TYCyclePagerTransformLayoutType layoutType;

@property (nonatomic, assign) CGFloat minimumScale;
@property (nonatomic, assign) CGFloat minimumAlpha;
@property (nonatomic, assign) CGFloat maximumAngle; // 百分比 0.

@property (nonatomic, assign) BOOL isInfiniteLoop;  // infinte scroll
@property (nonatomic, assign) CGFloat rateOfChange; // scale and angle change rate
@property (nonatomic, assign) BOOL adjustSpacingWhenScroling;

/**
 pageView cell item vertical centering
 */
@property (nonatomic, assign) BOOL itemVerticalCenter;

/**
 first and last item horizontalc enter, when isInfiniteLoop is NO
 */
@property (nonatomic, assign) BOOL itemHorizontalCenter;

// sectionInset
@property (nonatomic, assign, readonly) UIEdgeInsets onlyOneSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets firstSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets lastSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets middleSectionInset;

@end


@interface TYCyclePagerTransformLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) TYCyclePagerViewLayout *layout;

@property (nonatomic, weak) id<TYCyclePagerTransformLayoutDelegate> delegate;

@end
