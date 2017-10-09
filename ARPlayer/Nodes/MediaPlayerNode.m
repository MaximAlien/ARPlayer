//
//  MediaPlayerNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

// Nodes
#import "MediaPlayerNode.h"
#import "PlayNode.h"
#import "StopNode.h"
#import "TVNode.h"
#import "NextTrackNode.h"

// Utils
#import "Utils.h"

@interface MediaPlayerNode ()

@property (nonatomic, strong) TVNode *tvNode;
@property (nonatomic, strong) PlayNode *playNode;
@property (nonatomic) NSInteger currentPlaybackIndex;

@end

@implementation MediaPlayerNode

- (instancetype)initWithPlaylist:(NSArray<NSURL *> *)playlist {
    self = [self init];
    
    if (self) {
        self.playlistArray = playlist;
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self constructNodes];
    }
    
    return self;
}

- (void)constructNodes {
    self.currentPlaybackIndex = 0;
    _playerPaused = YES;
    self.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeStatic shape:nil];
    self.name = kMediaPlayerNode;
    
    self.tvNode = [TVNode node];
    [self addChildNode:self.tvNode];
    
    self.playNode = [PlayNode node];
    [self addChildNode:self.playNode];
    [self addChildNode:[StopNode node]];
    
    NextTrackNode *nextTrackNode = [NextTrackNode new];
    nextTrackNode.position = SCNVector3Make(0.12f, 0.0f, 0.08f);
    nextTrackNode.eulerAngles = SCNVector3Make(M_PI_2, 0.0f, 0.0f);
    nextTrackNode.name = kNextTrackNode;
    [self addChildNode:nextTrackNode];
    
    NextTrackNode *previousTrackNode = [NextTrackNode new];
    previousTrackNode.position = SCNVector3Make(-0.12f, 0.0f, 0.12f);
    previousTrackNode.eulerAngles = SCNVector3Make(M_PI_2, M_PI, 0.0f);
    previousTrackNode.name = kPreviousTrackNode;
    [self addChildNode:previousTrackNode];
}

- (void)pause {
    _playerPaused = YES;
    
    [self.playNode updateState:StatePaused];
    [self.tvNode.player pause];
}

- (void)play {
    if (self.playlistArray.count != 0) {
        _playerPaused = NO;
        
        if (self.tvNode.player == NULL) {
            [self switchToTrackWithIndex:self.currentPlaybackIndex];
        } else {
            [self.tvNode.player play];
        }
        
        [self.playNode updateState:StatePlaying];
    } else {
        NSLog(@"[%s] Playlist empty, playback won't be started.", __FUNCTION__);
    }
}

- (void)stop {
    _playerPaused = YES;
    
    [self.playNode updateState:StatePaused];
    [self.tvNode updateVideoNodeWithPlayer:nil];
}

- (void)toNextTrack {
    if (self.currentPlaybackIndex + 1 < self.playlistArray.count) {
        [self switchToTrackWithIndex:++self.currentPlaybackIndex];
    }
}

- (void)toPreviousTrack {
    if (self.currentPlaybackIndex - 1 >= 0) {
        [self switchToTrackWithIndex:--self.currentPlaybackIndex];
    }
}

- (void)switchToTrackWithIndex:(NSUInteger)index {    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:self.playlistArray[index]];
    
    if (self.tvNode.player.currentItem != playerItem) {
        [self.tvNode updateVideoNodeWithPlayer:[AVPlayer playerWithPlayerItem:playerItem]];
    }
    
    [self.playNode updateState:StatePlaying];
}

@end
