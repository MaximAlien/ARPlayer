//
//  GestureHandler.m
//  ARPlayer
//
//  Created by Maxim Makhun on 10/1/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

#import "GestureHandler.h"

// Nodes
#import "MediaPlayerNode.h"

// Utils
#import "Utils.h"
#import "Constants.h"
#import "SettingsManager.h"

@implementation GestureHandler

+ (void)handlePlayback:(UITapGestureRecognizer *)recognizer
           inSceneView:(ARSCNView *)sceneView {
    CGPoint tapPoint = [recognizer locationInView:sceneView];
    NSArray<SCNHitTestResult *> *result = [sceneView hitTest:tapPoint options:nil];
    if (result.count != 0) {
        SCNHitTestResult *hitResult = [result firstObject];
        MediaPlayerNode *mediaPlayerNode = (MediaPlayerNode *)[sceneView.scene.rootNode childNodeWithName:kMediaPlayerNode
                                                                                              recursively:NO];
        
        if ([hitResult.node.name isEqualToString:kVideoRendererNode]) {
            [GestureHandler performPlayback:mediaPlayerNode];
        } else if ([hitResult.node.name isEqualToString:kStopNode]) {
            [Utils handleTouch:hitResult.node];
            [mediaPlayerNode stop];
        } else if ([hitResult.node.name isEqualToString:kPlayNode]) {
            [Utils handleTouch:hitResult.node];
            [GestureHandler performPlayback:mediaPlayerNode];
        } else if ([hitResult.node.name isEqualToString:kNextTrackNode]) {
            [Utils handleTouch:hitResult.node];
            [mediaPlayerNode toNextTrack];
        } else if ([hitResult.node.name isEqualToString:kPreviousTrackNode]) {
            [Utils handleTouch:hitResult.node];
            [mediaPlayerNode toPreviousTrack];
        }
    }
}

+ (void)performPlayback:(MediaPlayerNode *)node {
    if (node.playerPaused) {
        [node play];
    } else {
        [node pause];
    }
}

+ (void)handleInsertion:(UILongPressGestureRecognizer *)recognizer
            inSceneView:(ARSCNView *)sceneView {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint tapPoint = [recognizer locationInView:sceneView];
        NSArray<ARHitTestResult *> *arHitTestResults = [sceneView hitTest:tapPoint
                                                                    types:ARHitTestResultTypeExistingPlaneUsingExtent];
        
        if (arHitTestResults.count != 0) {
            ARHitTestResult *hitResult = [arHitTestResults firstObject];
            simd_float4 column = hitResult.anchor.transform.columns[3];
            
            MediaPlayerNode *mediaPlayerNode = [[MediaPlayerNode alloc] initWithPlaylist:[Utils playlist]];
            mediaPlayerNode.position = SCNVector3Make(column.x, column.y, column.z);
            [mediaPlayerNode play];
            [sceneView.scene.rootNode addChildNode:mediaPlayerNode];
        }
    }
}

+ (SCNNode *)findNodeInSceneView:(ARSCNView *)sceneView
                   forRecognizer:(UIGestureRecognizer *)recognizer {
    SCNHitTestResult *hitResult = [[sceneView hitTest:[recognizer locationInView:sceneView]
                                              options:nil] firstObject];
    if ([hitResult.node.name isEqualToString:kTVNode] ||
        ([hitResult.node.name isEqualToString:kVideoRendererNode])) {
        return [sceneView.scene.rootNode childNodeWithName:kMediaPlayerNode
                                               recursively:NO];
    }
    
    return nil;
}

+ (void)handleScale:(UIPinchGestureRecognizer *)recognizer
        inSceneView:(ARSCNView *)sceneView {
    if ([SettingsManager instance].scaleAllowed) {
        static SCNNode *node;
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            node = [GestureHandler findNodeInSceneView:sceneView
                                         forRecognizer:recognizer];
        } else if (recognizer.state == UIGestureRecognizerStateChanged) {
            CGFloat pinchScaleX = recognizer.scale * node.scale.x;
            CGFloat pinchScaleY = recognizer.scale * node.scale.y;
            CGFloat pinchScaleZ = recognizer.scale * node.scale.z;
            node.scale = SCNVector3Make(pinchScaleX, pinchScaleY, pinchScaleZ);
            recognizer.scale = 1.0f;
        }
    }
}

+ (void)handleRotation:(UIRotationGestureRecognizer *)recognizer
           inSceneView:(ARSCNView *)sceneView {
    if ([SettingsManager instance].rotationAllowed) {
        static SCNNode *node;
        static CGFloat lastRotation = 0.0f;
        CGFloat currentRotation = recognizer.rotation * (- 180 / M_PI);
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            node = [GestureHandler findNodeInSceneView:sceneView
                                         forRecognizer:recognizer];
        } else if (recognizer.state == UIGestureRecognizerStateChanged) {
            [node runAction:[SCNAction rotateByX:0
                                               y:currentRotation - lastRotation
                                               z:0
                                        duration:0.0f]];
        }
        lastRotation = currentRotation;
    }
}

+ (void)handlePosition:(UIPanGestureRecognizer *)recognizer
           inSceneView:(ARSCNView *)sceneView {
    if ([SettingsManager instance].repositionAllowed) {
        CGPoint tapPoint = [recognizer locationInView:sceneView];
        if (recognizer.state == UIGestureRecognizerStateChanged) {
            NSArray<ARHitTestResult *> *arHitTestResults = [sceneView hitTest:tapPoint
                                                                        types:ARHitTestResultTypeExistingPlaneUsingExtent];
            if (arHitTestResults.count != 0) {
                ARHitTestResult *hitResult = [arHitTestResults firstObject];
                MediaPlayerNode *mediaPlayerNode = (MediaPlayerNode *)[sceneView.scene.rootNode childNodeWithName:kMediaPlayerNode
                                                                                                      recursively:NO];
                [mediaPlayerNode setSimdTransform:hitResult.worldTransform];
            }
        }
    }
}

@end
