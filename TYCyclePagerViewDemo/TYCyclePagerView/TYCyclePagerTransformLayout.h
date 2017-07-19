//
//  TYCyclePagerViewLayout.h
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/19.
//  Copyright © 2017年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TYCyclePagerTransformLayoutType) {
    TYCyclePagerTransformLayoutNormal,
    TYCyclePagerTransformLayoutLinear,
    TYCyclePagerTransformLayoutCoverflow,
};

@class TYCyclePagerTransformLayout;
@protocol TYCyclePagerTransformLayoutDelegate <NSObject>

// initialize layout attributes
- (void)pagerViewTransformLayout:(TYCyclePagerTransformLayout *)pagerViewTransformLayout initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

// apply layout attributes
- (void)pagerViewTransformLayout:(TYCyclePagerTransformLayout *)pagerViewTransformLayout applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;

@end


@interface TYCyclePagerViewLayout : NSObject

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) TYCyclePagerTransformLayoutType layoutType;

@property (nonatomic, assign) CGFloat minimumScale; // sacle default 0.8
@property (nonatomic, assign) CGFloat minimumAlpha; // alpha default 1.0
@property (nonatomic, assign) CGFloat maximumAngle; // angle is % default 0.2

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

@property (nonatomic, weak, nullable) id<TYCyclePagerTransformLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
