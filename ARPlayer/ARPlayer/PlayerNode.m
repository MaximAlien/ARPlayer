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
        self.name = @"player_view_node";
        self.player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2014/609xxkxq1v95fju/609/609_sd_whats_new_in_scenekit.mov"]];
    }
    
    return self;
}

- (void)setGeometry:(SCNGeometry *)geometry {
    [super setGeometry:geometry];
    
    self.geometry.firstMaterial.doubleSided = false;
    
    SCNMaterial *mainMaterial = [SCNMaterial new];
    mainMaterial.diffuse.contents = [[UIColor blackColor] colorWithAlphaComponent:1.0f];
    
    SCNMaterial *playerMaterial = [SCNMaterial new];
    playerMaterial.diffuse.contents = self.player;
    self.geometry.materials = @[mainMaterial, mainMaterial, mainMaterial, mainMaterial, playerMaterial, mainMaterial];
    
    [self createPlayNode];
    [self createStopNode];
}

- (void)createPlayNode {
    SCNMaterial *mainMaterial = [SCNMaterial new];
    mainMaterial.diffuse.contents = [[UIColor redColor] colorWithAlphaComponent:1.0f];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(0.04f, 0.02f)];
    [path addLineToPoint:CGPointMake(0.0f, 0.04f)];
    [path closePath];
    
    SCNShape *trianglePrism = [SCNShape shapeWithPath:path extrusionDepth:0.02f];
    trianglePrism.firstMaterial.diffuse.contents = [UIColor redColor];
    SCNNode *playNode = [SCNNode nodeWithGeometry:trianglePrism];
    playNode.transform = SCNMatrix4MakeRotation(M_PI_2, 1.0f, 0.0f, 0.0f);
    playNode.position = SCNVector3Make(-0.05f, 0.0f, 0.2f);
    playNode.name = @"play_node";
    [self addChildNode:playNode];
}

- (void)createStopNode {
    SCNMaterial *mainMaterial = [SCNMaterial new];
    mainMaterial.diffuse.contents = [[UIColor greenColor] colorWithAlphaComponent:1.0f];
    
    SCNBox *stopNodeGeometry = [SCNBox boxWithWidth:0.04f
                                             height:0.02f
                                             length:0.04f
                                      chamferRadius:0.0f];
    SCNNode *stopNode = [SCNNode nodeWithGeometry:stopNodeGeometry];
    stopNode.position = SCNVector3Make(0.05f, 0.0f, 0.22f);
    stopNode.geometry.firstMaterial = mainMaterial;
    stopNode.name = @"stop_node";
    [self addChildNode:stopNode];
}

- (void)pause {
    _playerPaused = YES;
    [self.player pause];
}

- (void)play {
    _playerPaused = NO;
    [self.player play];
}

- (void)stop {
    _playerPaused = YES;
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player pause];
}

@end
