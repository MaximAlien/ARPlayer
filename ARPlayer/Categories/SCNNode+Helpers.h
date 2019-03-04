//
//  SCNNode+Helpers.h
//  ARPlayer
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import Foundation;
@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

@interface SCNNode (Helpers)

- (SCNVector3)boundingBox;

@end

NS_ASSUME_NONNULL_END
