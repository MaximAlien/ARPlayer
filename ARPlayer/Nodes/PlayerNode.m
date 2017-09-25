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
@property(nonatomic, strong) SCNText *currentTimeGeometry;
@property(nonatomic, strong) SCNText *remainingTimeGeometry;

@end

@implementation PlayerNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _playerPaused = YES;
        self.name = @"player_view_node";
        self.player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2014/609xxkxq1v95fju/609/609_sd_whats_new_in_scenekit.mov"]];
        
        __weak typeof(self) weakSelf = self;
        [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0f, NSEC_PER_SEC)
                                                  queue:nil
                                             usingBlock:^(CMTime time) {
                                                 Float64 seconds = CMTimeGetSeconds(time);
                                                 NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
                                                 NSDateFormatter *dateFormatter = [NSDateFormatter new];
                                                 [dateFormatter setDateFormat:(int)(seconds / 3600) > 0 ? @"HH:mm:ss" : @"mm:ss"];
                                                 [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                                                 
                                                 NSString *currentTimeString = [dateFormatter stringFromDate:date];
                                                 weakSelf.currentTimeGeometry.string = currentTimeString;
                                             }];
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
    
    [self createCurrentTimeNode];
}

- (void)createPlayNode {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(0.04f, 0.02f)];
    [path addLineToPoint:CGPointMake(0.0f, 0.04f)];
    [path closePath];
    
    SCNShape *trianglePrism = [SCNShape shapeWithPath:path extrusionDepth:0.02f];
    trianglePrism.firstMaterial.diffuse.contents = [UIColor blackColor];
    SCNNode *playNode = [SCNNode nodeWithGeometry:trianglePrism];
    playNode.transform = SCNMatrix4MakeRotation(M_PI_2, 1.0f, 0.0f, 0.0f);
    playNode.position = SCNVector3Make(-0.05f, 0.0f, 0.16f);
    playNode.name = @"play_node";
    [self addChildNode:playNode];
}

- (void)createStopNode {
    SCNMaterial *mainMaterial = [SCNMaterial new];
    mainMaterial.diffuse.contents = [UIColor blackColor];
    
    SCNBox *stopNodeGeometry = [SCNBox boxWithWidth:0.04f
                                             height:0.02f
                                             length:0.04f
                                      chamferRadius:0.0f];
    SCNNode *stopNode = [SCNNode nodeWithGeometry:stopNodeGeometry];
    stopNode.position = SCNVector3Make(0.05f, 0.0f, 0.18f);
    stopNode.geometry.firstMaterial = mainMaterial;
    stopNode.name = @"stop_node";
    [self addChildNode:stopNode];
}

- (SCNText *)createTimeGeometryWithFrame:(CGRect)frame {
    SCNText *timeGeometry = [SCNText textWithString:@"00:00" extrusionDepth:0.02f];
    timeGeometry.font = [UIFont systemFontOfSize:0.14f];
    timeGeometry.containerFrame = frame;
    
    return timeGeometry;
}

- (void)createCurrentTimeNode {
    self.currentTimeGeometry = [self createTimeGeometryWithFrame:CGRectMake(-0.2f, -0.25f, 0.6f, 0.25f)];
    self.currentTimeGeometry.alignmentMode = kCAAlignmentCenter;
    
    SCNMaterial *mainMaterial = [SCNMaterial new];
    mainMaterial.diffuse.contents = [UIColor blackColor];
    self.currentTimeGeometry.firstMaterial = mainMaterial;

    SCNNode *currentTimeNode = [SCNNode node];
    currentTimeNode.position = SCNVector3Make(0.0f, 0.0f, -0.2f);
    [currentTimeNode setGeometry:self.currentTimeGeometry];
    [self addChildNode:currentTimeNode];
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
