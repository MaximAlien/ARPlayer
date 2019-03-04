//
//  SCNMaterial+Contents.h
//  ARPlayer
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import Foundation;
@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

@interface SCNMaterial (Contents)

+ (instancetype)materialWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
