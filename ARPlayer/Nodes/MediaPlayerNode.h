//
//  MediaPlayerNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

/*!
 @class MediaPlayerNode
 @abstract MediaPlayerNode main video playback node.
 @discussion It is holder class for all other media playback related nodes. For example:
 Play, pause, switch tracks, playback time etc
 */
@interface MediaPlayerNode : SCNNode

/*!
 @method initWithPlaylist:
 @abstract Creates and initializes media player node instance with the specified playlist.
 @param playlist Array of NSURLs.
 */
- (instancetype)initWithPlaylist:(NSArray<NSURL *> *)playlist;

/*!
 @method pause
 @abstract Pauses playback of media player.
 */
- (void)pause;

/*!
 @method play
 @abstract Starts media playback.
 */
- (void)play;

/*!
 @method togglePlay
 @abstract Either starts or pauses playback.
 */
- (void)togglePlay;

/*!
 @method stop
 @abstract Stop media playback.
 */
- (void)stop;

/*!
 @method toNextTrack
 @abstract Switch to next track (if present).
 */
- (void)toNextTrack;

/*!
 @method toPreviousTrack
 @abstract Switch to previous track (if present).
 */
- (void)toPreviousTrack;

@end

NS_ASSUME_NONNULL_END
