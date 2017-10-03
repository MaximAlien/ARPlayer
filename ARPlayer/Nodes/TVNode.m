//
//  TVNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 10/1/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "TVNode.h"
#import "Utils.h"
#import "CurrentTimeNode.h"

@interface TVNode ()

@property (nonatomic, strong) SCNNode *tvNode;

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
    self.tvNode = [[SCNScene sceneNamed:@"Art.scnassets/tv_scene.scn"].rootNode childNodeWithName:@"tv_node" recursively:NO];
    self.tvNode.geometry.firstMaterial.diffuse.contents = [[UIColor greenColor] colorWithAlphaComponent:1.0f];
    self.tvNode.movabilityHint = SCNMovabilityHintFixed;
    self.tvNode.name = @"tv_node";
    
    [self addChildNode:self.tvNode];
}

- (void)createVideoRendererNode {
    SCNNode *videoRendererNode = [SCNNode new];
    
    SCNVector3 vector = [Utils getBoundingBox:self.tvNode];
    videoRendererNode.geometry = [SCNBox boxWithWidth:vector.x - 0.04f
                                               height:vector.z - 0.06f
                                               length:0.005f
                                        chamferRadius:0.0f];
    videoRendererNode.position = SCNVector3Make(0.0f, -0.008f, 0.01f);
    videoRendererNode.eulerAngles = SCNVector3Make(M_PI_2, 0.0f, 0.0f);
    videoRendererNode.name = @"video_renderer_node";
    _player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2014/609xxkxq1v95fju/609/609_sd_whats_new_in_scenekit.mov"]];
    
    SCNMaterial *mainMaterial = [SCNMaterial new];
    mainMaterial.diffuse.contents = [[UIColor blackColor] colorWithAlphaComponent:1.0f];
    
    SCNMaterial *playerMaterial = [SCNMaterial new];
    playerMaterial.diffuse.contents = _player;
    videoRendererNode.geometry.materials = @[playerMaterial, mainMaterial, mainMaterial, mainMaterial, mainMaterial, mainMaterial];
    
    [self.tvNode addChildNode:videoRendererNode];
    
    CurrentTimeNode *currentTimeNode = [CurrentTimeNode node];
    currentTimeNode.position = SCNVector3Make(-0.025f, -0.1f, 0.003f);
    [currentTimeNode subscribeForPlayerTimeUpdates:_player];
    [videoRendererNode addChildNode:currentTimeNode];
}

@end
