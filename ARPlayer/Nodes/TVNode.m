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
#import "Utils.h"

static void * CurrentItemObservationContext = &CurrentItemObservationContext;

@interface TVNode ()

@property (nonatomic, strong) SCNNode *tvNode;
@property (nonatomic, strong) SCNNode *videoRendererNode;

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

- (SCNMaterial *)mainMaterial {
    SCNMaterial *mainMaterial = [SCNMaterial new];
    mainMaterial.diffuse.contents = [[UIColor blackColor] colorWithAlphaComponent:1.0f];
    
    return mainMaterial;
}

- (void)createVideoRendererNode {
    self.videoRendererNode = [SCNNode new];
    
    SCNVector3 vector = [Utils getBoundingBox:self.tvNode];
    self.videoRendererNode.geometry = [SCNBox boxWithWidth:vector.x - 0.04f
                                                    height:vector.z - 0.06f
                                                    length:0.005f
                                             chamferRadius:0.0f];
    self.videoRendererNode.position = SCNVector3Make(0.0f, -0.008f, 0.01f);
    self.videoRendererNode.eulerAngles = SCNVector3Make(M_PI_2, 0.0f, 0.0f);
    self.videoRendererNode.name = kVideoRendererNode;
    
    self.videoRendererNode.geometry.firstMaterial = [self mainMaterial];
    
    [self.tvNode addChildNode:self.videoRendererNode];
    
    _currentTimeNode = [CurrentTimeNode node];
    _currentTimeNode.position = SCNVector3Make(-0.025f, -0.1f, 0.003f);
    [self.videoRendererNode addChildNode:_currentTimeNode];
}

- (void)updateVideoNodeWithPlayer:(AVPlayer *)player {
    SCNMaterial *mainMaterial = [self mainMaterial];
    
    [_player pause];
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_currentTimeNode resetTimeForPlayer:_player];
    
    if (player == nil) {
        self.videoRendererNode.geometry.firstMaterial = [self mainMaterial];
        _player = nil;
    } else {
        SCNMaterial *playerMaterial = [SCNMaterial new];
        _player = player;
        playerMaterial.diffuse.contents = player;
        self.videoRendererNode.geometry.materials = @[playerMaterial, mainMaterial, mainMaterial, mainMaterial, mainMaterial, mainMaterial];
        [_currentTimeNode subscribeForPlayerTimeUpdates:_player];
        
        [_player play];
    }
}

@end
