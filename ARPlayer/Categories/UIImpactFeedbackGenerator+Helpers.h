//
//  UIImpactFeedbackGenerator+Helpers.h
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIImpactFeedbackGenerator (Helpers)

+ (void)lightImpactOccurred;

+ (void)mediumImpactOccurred;

+ (void)heavyImpactOccurred;

@end

NS_ASSUME_NONNULL_END
