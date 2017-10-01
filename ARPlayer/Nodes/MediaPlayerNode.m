//
//  MediaPlayerNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "MediaPlayerNode.h"
#import "PlayNode.h"
#import "StopNode.h"
#import "CurrentTimeNode.h"
#import "TVNode.h"

@interface MediaPlayerNode ()

@property (nonatomic, strong) TVNode *tvNode;
@property (nonatomic, strong) PlayNode *playNode;

@end

@implementation MediaPlayerNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _playerPaused = YES;
        self.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeStatic shape:nil];
        self.name = @"media_player_node";
        
        self.tvNode = [TVNode node];
        [self addChildNode:self.tvNode];
        
        self.playNode = [PlayNode node];
        [self addChildNode:self.playNode];
        [self addChildNode:[StopNode node]];
        
        CurrentTimeNode *currentTimeNode = [CurrentTimeNode node];
        [currentTimeNode subscribeForPlayerTimeUpdates:self.tvNode.player];
        [self addChildNode:currentTimeNode];
    }
    
    return self;
}

- (void)pause {
    _playerPaused = YES;
    
    [self.playNode updateState:StatePaused];
    [self.tvNode.player pause];
}

- (void)play {
    _playerPaused = NO;
    
    [self.playNode updateState:StatePlaying];
    [self.tvNode.player play];
}

- (void)stop {
    _playerPaused = YES;
    
    [self.playNode updateState:StatePaused];
    [self.tvNode.player seekToTime:CMTimeMake(0, 1)];
    [self.tvNode.player pause];
}

@end
