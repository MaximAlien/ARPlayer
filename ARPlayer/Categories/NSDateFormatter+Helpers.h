//
//  NSDateFormatter+Helpers.h
//  ARPlayer
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (Helpers)

+ (NSString *)currentTimeStringForTime:(CMTime)time;

@end

NS_ASSUME_NONNULL_END
