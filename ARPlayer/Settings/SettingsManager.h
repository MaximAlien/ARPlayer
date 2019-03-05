//
//  SettingsManager.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/23/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import Foundation;

/*!
 @class SettingsManager
 @abstract Manager which is responsible for saving app-related settings. There can only be one
 instance of such manager during lifetime of an app.
 */
@interface SettingsManager : NSObject

/*!
 @method instance
 @abstract SettingsManager works as Singleton. This is one and only access point to its instance.
 */
+ (instancetype)instance;

/*!
 @property showPlanes
 @abstract Setting which controls whether its possible to show/hide horizontal planes on a surface.
 Notification is sent whenever value of this property changes.
 */
@property (nonatomic) BOOL showPlanes;

/*!
 @property vibrateOnTouch
 @abstract Setting which controls whether its possible to get haptic feedback for specific media
 player control while interacting with it.
 */
@property (nonatomic) BOOL vibrateOnTouch;

/*!
 @property animateOnTouch
 @abstract Setting which controls whether its possible animate specific media player control
 while interacting with it.
 */
@property (nonatomic) BOOL animateOnTouch;

/*!
 @property scaleAllowed
 @abstract Setting which controls whether its possible to scale media player.
 */
@property (nonatomic) BOOL scaleAllowed;

/*!
 @property rotationAllowed
 @abstract Setting which controls whether its possible to rotate media player.
 */
@property (nonatomic) BOOL rotationAllowed;

/*!
 @property repositionAllowed
 @abstract Setting which controls whether media player reposition is allowed on a plane.
 */
@property (nonatomic) BOOL repositionAllowed;

@end
