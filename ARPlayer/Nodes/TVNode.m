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

// Utils
#import "Constants.h"

// Categories
#import "SCNNode+Helpers.h"
#import "SCNMaterial+Contents.h"

@interface TVNode ()

@property (nonatomic, strong) SCNNode *tvNode;
@property (nonatomic, strong) SCNNode *videoRendererNode;
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
    self.videoRendererNode = [SCNNode new];
    
    SCNVector3 vector = [self.tvNode boundingBox];
    self.videoRendererNode.geometry = [SCNBox boxWithWidth:vector.x - 0.04f
                                                    height:vector.z - 0.06f
                                                    length:0.005f
                                             chamferRadius:0.0f];
    self.videoRendererNode.position = SCNVector3Make(0.0f, -0.008f, 0.01f);
    self.videoRendererNode.eulerAngles = SCNVector3Make(M_PI_2, 0.0f, 0.0f);
    self.videoRendererNode.name = kVideoRendererNode;
    
    self.videoRendererNode.geometry.firstMaterial = [SCNMaterial materialWithColor:[UIColor blackColor]];
    
    [self.tvNode addChildNode:self.videoRendererNode];
    
    self.currentTimeNode = [CurrentTimeNode node];
    self.currentTimeNode.position = SCNVector3Make(-0.025f, -0.1f, 0.003f);
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
