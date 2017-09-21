//
//  PlayerNode.m
//  ARKitSceneTest
//
//  Created by Maxim Makhun on 9/20/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import AVFoundation;

#import "PlayerNode.h"

@interface PlayerNode ()

@property(nonatomic, strong) AVPlayer *player;

@end

@implementation PlayerNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _playerPaused = YES;
        self.name = @"player";
        self.player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2014/609xxkxq1v95fju/609/609_sd_whats_new_in_scenekit.mov"]];
    }
    
    return self;
}

- (void)setGeometry:(SCNGeometry *)geometry {
    [super setGeometry:geometry];
    
    self.geometry.firstMaterial.diffuse.contents = self.player;
    self.geometry.firstMaterial.doubleSided = true;
}

- (void)pause {
    _playerPaused = YES;
    [self.player pause];
}

- (void)play {
    _playerPaused = NO;
    [self.player play];
}

@end
