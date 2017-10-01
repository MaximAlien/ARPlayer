//
//  GestureHandler.m
//  ARPlayer
//
//  Created by Maxim Makhun on 10/1/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;

#import "GestureHandler.h"
#import "MediaPlayerNode.h"
#import "Utils.h"

@implementation GestureHandler

+ (void)handlePlayback:(UITapGestureRecognizer *)recognizer
           inSceneView:(ARSCNView *)sceneView {
    CGPoint tapPoint = [recognizer locationInView:sceneView];
    NSArray<SCNHitTestResult *> *result = [sceneView hitTest:tapPoint options:nil];
    if (result.count != 0) {
        SCNHitTestResult *hitResult = [result firstObject];
        MediaPlayerNode *mediaPlayerNode = (MediaPlayerNode *)[sceneView.scene.rootNode childNodeWithName:@"media_player_node" recursively:NO];
        
        if ([hitResult.node.name isEqualToString:@"video_renderer_node"]) {
            if (mediaPlayerNode.playerPaused) {
                [mediaPlayerNode play];
            } else {
                [mediaPlayerNode pause];
            }
        } else if ([hitResult.node.name isEqualToString:@"stop_node"]) {
            [Utils handleTouch:hitResult.node];
            [mediaPlayerNode stop];
        } else if ([hitResult.node.name isEqualToString:@"play_node"]) {
            [Utils handleTouch:hitResult.node];
            if (mediaPlayerNode.playerPaused) {
                [mediaPlayerNode play];
            } else {
                [mediaPlayerNode pause];
            }
        }
    }
}

+ (void)handleInsertion:(UILongPressGestureRecognizer *)recognizer
            inSceneView:(ARSCNView *)sceneView {
    CGPoint tapPoint = [recognizer locationInView:sceneView];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSArray<ARHitTestResult *> *arHitTestResults = [sceneView hitTest:tapPoint
                                                                    types:ARHitTestResultTypeExistingPlaneUsingExtent];
        
        if (arHitTestResults.count != 0) {
            ARHitTestResult *hitResult = [arHitTestResults firstObject];
            simd_float4 column = hitResult.anchor.transform.columns[3];
            
            MediaPlayerNode *mediaPlayerNode = [MediaPlayerNode new];
            mediaPlayerNode.position = SCNVector3Make(column.x, column.y, column.z);
            [mediaPlayerNode play];
            [sceneView.scene.rootNode addChildNode:mediaPlayerNode];
        }
    }
}

+ (void)handleScale:(UIPinchGestureRecognizer *)recognizer
        inSceneView:(ARSCNView *)sceneView {
    CGPoint tapPoint = [recognizer locationInView:sceneView];
    static SCNNode *node;
    UIPinchGestureRecognizer *pinchGestureRecognizer = (UIPinchGestureRecognizer *)recognizer;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSArray<SCNHitTestResult *> *result = [sceneView hitTest:tapPoint options:nil];
        if ([result count] == 0) {
            tapPoint = [recognizer locationOfTouch:0 inView:sceneView];
            result = [sceneView hitTest:tapPoint options:nil];
            if ([result count] == 0) {
                return;
            }
        }
        
        SCNHitTestResult *hitResult = [result firstObject];
        if ([hitResult.node.name isEqualToString:@"tv_node"]) {
            node = hitResult.node;
        } else if ([hitResult.node.name isEqualToString:@"video_renderer_node"]) {
            node = hitResult.node.parentNode;
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (node) {
            CGFloat pinchScaleX = pinchGestureRecognizer.scale * node.scale.x;
            CGFloat pinchScaleY = pinchGestureRecognizer.scale * node.scale.y;
            CGFloat pinchScaleZ = pinchGestureRecognizer.scale * node.scale.z;
            
            [node setScale:SCNVector3Make(pinchScaleX, pinchScaleY, pinchScaleZ)];
        }
        pinchGestureRecognizer.scale = 1;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        node = nil;
    }
}

+ (void)handleRotation:(UIRotationGestureRecognizer *)recognizer
           inSceneView:(ARSCNView *)sceneView {
    CGPoint tapPoint = [recognizer locationInView:sceneView];
    static SCNNode *node;
    static CGFloat lastRotation = 0.0f;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSArray<SCNHitTestResult *> *result = [sceneView hitTest:tapPoint options:nil];
        if ([result count] == 0) {
            tapPoint = [recognizer locationOfTouch:0 inView:sceneView];
            result = [sceneView hitTest:tapPoint options:nil];
            if ([result count] == 0) {
                return;
            }
        }
        
        SCNHitTestResult *hitResult = [result firstObject];
        if ([hitResult.node.name isEqualToString:@"tv_node"]) {
            node = hitResult.node;
        } else if ([hitResult.node.name isEqualToString:@"video_renderer_node"]) {
            node = hitResult.node.parentNode;
        }
        
        lastRotation = recognizer.rotation * (- 180 / M_PI);
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        float rotation = recognizer.rotation * (- 180 / M_PI);
        [node runAction:[SCNAction rotateByX:0
                                           y:rotation - lastRotation
                                           z:0
                                    duration:0.0f]];
        lastRotation = rotation;
    }
}

@end
