//
//  PlaylistService.h
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface PlaylistService : NSObject

+ (NSArray<NSURL *> *)playlist;

@end

NS_ASSUME_NONNULL_END
