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
#import "PreviousTrackNode.h"

// Utils
#import "Constants.h"

@interface MediaPlayerNode ()

@property (nonatomic, strong) TVNode *tvNode;
@property (nonatomic, strong) PlayNode *playNode;
@property (nonatomic, strong) StopNode *stopNode;
@property (nonatomic, strong) NextTrackNode *nextTrackNode;
@property (nonatomic, strong) PreviousTrackNode *previousTrackNode;
@property (nonatomic, strong) NSArray<NSURL *> *playlist;
@property (nonatomic) NSInteger currentPlaybackIndex;

@end

@implementation MediaPlayerNode

#pragma mark - Init methods

- (instancetype)initWithPlaylist:(NSArray<NSURL *> *)playlist {
    self = [self init];
    
    if (self) {
        self.playlist = playlist;
        [self constructNodes];
        [self setupMediaPlayerNode];
    }
    
    return self;
}

- (void)setupMediaPlayerNode {
    self.currentPlaybackIndex = 0;
    self.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeStatic shape:nil];
    self.name = kMediaPlayerNode;
}

- (void)constructNodes {
    self.tvNode = [TVNode node];
    [self addChildNode:self.tvNode];
    
    self.playNode = [PlayNode node];
    [self addChildNode:self.playNode];

    self.stopNode = [StopNode node];
    [self addChildNode:self.stopNode];
    
    self.nextTrackNode = [NextTrackNode new];
    [self addChildNode:self.nextTrackNode];
    
    self.previousTrackNode = [PreviousTrackNode new];
    [self addChildNode:self.previousTrackNode];
}

#pragma mark - Video player control logic

- (void)pause {
    self.playNode.state = Paused;
    [self.tvNode.player pause];
}

- (void)playAnimated:(BOOL)animated {
    if (self.playlist.count != 0) {
        if (self.tvNode.player == NULL) {
            [self switchToTrackWithIndex:self.currentPlaybackIndex];
        } else {
            [self.tvNode.player play];
        }

        self.playNode.state = Playing;
    } else {
        NSLog(@"[%s] Playlist empty, playback won't be started.", __FUNCTION__);
    }
}

- (void)play {
    if (self.playlist.count != 0) {
        if (self.tvNode.player == NULL) {
            [self switchToTrackWithIndex:self.currentPlaybackIndex];
        } else {
            [self.tvNode.player play];
        }
        
        self.playNode.state = Playing;
    } else {
        NSLog(@"[%s] Playlist empty, playback won't be started.", __FUNCTION__);
    }
}

- (void)togglePlay {
    switch (self.playNode.state) {
        case Playing:
            [self pause];
            break;
        case Paused:
            [self play];
            break;
        default:
            break;
    }
}

- (void)stop {
    self.playNode.state = Paused;
    self.tvNode.player = nil;
}

#pragma mark - Video player track switching logic

- (void)toNextTrack {
    if (self.currentPlaybackIndex + 1 < self.playlist.count) {
        [self switchToTrackWithIndex:++self.currentPlaybackIndex];
    }
}

- (void)toPreviousTrack {
    if (self.currentPlaybackIndex - 1 >= 0) {
        [self switchToTrackWithIndex:--self.currentPlaybackIndex];
    }
}

- (void)switchToTrackWithIndex:(NSUInteger)index {    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:self.playlist[index]];
    
    if (self.tvNode.player.currentItem != playerItem) {
        self.tvNode.player = [AVPlayer playerWithPlayerItem:playerItem];
    }
    
    self.playNode.state = Playing;
}

@end
