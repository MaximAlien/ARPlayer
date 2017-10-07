//
//  MediaPlayerNode.h
//  ARPlayer
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

@interface MediaPlayerNode : SCNNode

- (instancetype)initWithPlaylist:(NSArray<NSURL *> *)playlist;

@property(nonatomic, strong) NSArray<NSURL *> *playlistArray;

@property(nonatomic, readonly) BOOL playerPaused;

- (void)pause;

- (void)play;

- (void)stop;

- (void)toNextTrack;

- (void)toPreviousTrack;

@end
