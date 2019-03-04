//
//  MediaPlayerNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

@interface MediaPlayerNode : SCNNode

- (instancetype)initWithPlaylist:(NSArray<NSURL *> *)playlist;

@property(nonatomic, strong) NSArray<NSURL *> *playlist;

@property(nonatomic, readonly) BOOL playerPaused;

- (void)pause;

- (void)play;

- (void)stop;

- (void)toNextTrack;

- (void)toPreviousTrack;

@end

NS_ASSUME_NONNULL_END
