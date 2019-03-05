//
//  TVNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 10/1/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

// Nodes
#import "TVNode.h"
#import "CurrentTimeNode.h"
#include "VideoRendererNode.h"
#import "ControlNode.h"

// Utils
#import "Constants.h"

// Categories
#import "SCNNode+Helpers.h"
#import "SCNMaterial+Contents.h"

@interface TVNode ()

@property (nonatomic, strong) SCNNode *tvNode;
@property (nonatomic, strong) VideoRendererNode *videoRendererNode;
@property (nonatomic, strong) CurrentTimeNode *currentTimeNode;

@end

@implementation TVNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self createTvNode];
        [self createVideoRendererNode];
    }
    
    return self;
}

- (void)createTvNode {
    self.tvNode = [[SCNScene sceneNamed:@"Art.scnassets/tv_scene.scn"].rootNode childNodeWithName:kTVNode
                                                                                      recursively:NO];
    self.tvNode.geometry.firstMaterial.diffuse.contents = [[UIColor blackColor] colorWithAlphaComponent:1.0f];
    self.tvNode.movabilityHint = SCNMovabilityHintFixed;
    self.tvNode.name = kTVNode;
    
    [self addChildNode:self.tvNode];
}

- (void)createVideoRendererNode {
    self.videoRendererNode = [[VideoRendererNode alloc] initWithParentNode:self.tvNode];
    [self.tvNode addChildNode:self.videoRendererNode];
    
    self.currentTimeNode = [CurrentTimeNode node];
    [self.videoRendererNode addChildNode:self.currentTimeNode];
}

- (void)setPlayer:(AVPlayer * )player {
    SCNMaterial *mainMaterial = [SCNMaterial materialWithColor:[UIColor blackColor]];
    
    [_player pause];
    [_player replaceCurrentItemWithPlayerItem:nil];
    [self.currentTimeNode resetTimeForPlayer:_player];
    
    if (player == nil) {
        self.videoRendererNode.geometry.firstMaterial = mainMaterial;
        _player = nil;
    } else {
        _player = player;

        self.videoRendererNode.geometry.materials = @[[self materialWithPlayer:_player], mainMaterial, mainMaterial, mainMaterial, mainMaterial, mainMaterial];
        [self.currentTimeNode subscribeForPlayerTimeUpdates:_player];
        
        [_player play];
    }
}

#pragma mark - Helper methods

- (SCNMaterial *)materialWithPlayer:(AVPlayer *)player {
    SCNMaterial *material = [SCNMaterial new];
    material.diffuse.contents = player;

    return material;
}

@end
