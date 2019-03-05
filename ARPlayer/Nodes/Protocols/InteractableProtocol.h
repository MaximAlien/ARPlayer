//
//  InteractableProtocol.h
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import Foundation;
@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

@protocol InteractableProtocol <NSObject>

- (void)animate;

- (void)vibrate;

@end

NS_ASSUME_NONNULL_END
