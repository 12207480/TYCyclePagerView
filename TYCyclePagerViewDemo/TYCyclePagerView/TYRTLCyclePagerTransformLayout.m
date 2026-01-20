//
//  TYRTLCyclePagerTransformLayout.m
//  TYCyclePagerViewDemo
//
//  Created by aa on 2024/9/11.
//  Copyright © 2024 tany. All rights reserved.
//

#import "TYRTLCyclePagerTransformLayout.h"

@implementation TYRTLCyclePagerTransformLayout

- (BOOL)flipsHorizontallyInOppositeLayoutDirection {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (!window) {
        return UIUserInterfaceLayoutDirectionLeftToRight;
    }
    
    UIUserInterfaceLayoutDirection layoutDirection = [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:window.semanticContentAttribute];
    return layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

@end
