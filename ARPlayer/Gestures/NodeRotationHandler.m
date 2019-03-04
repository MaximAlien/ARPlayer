//
//  NodeRotationHandler.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import ARKit;

#import "NodeRotationHandler.h"

// Utils
#import "SettingsManager.h"
#import "Constants.h"

@implementation NodeRotationHandler

- (void)handleGesture:(UIGestureRecognizer *)gesture inSceneView:(ARSCNView *)sceneView {
    NSAssert([gesture isKindOfClass:[UIRotationGestureRecognizer class]], @"Different class type is expected.");
    
    if (![SettingsManager instance].rotationAllowed) {
        return;
    }

    static SCNNode *node;
    static CGFloat lastRotation = 0.0f;
    CGFloat currentRotation = ((UIRotationGestureRecognizer *)gesture).rotation * (- 180 / M_PI);
    if (gesture.state == UIGestureRecognizerStateBegan) {
        node = [NodeRotationHandler findNodeInSceneView:sceneView
                                             forGesture:gesture];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [node runAction:[SCNAction rotateByX:0
                                           y:currentRotation - lastRotation
                                           z:0
                                    duration:0.0f]];
    }
    lastRotation = currentRotation;
}

+ (SCNNode *)findNodeInSceneView:(ARSCNView *)sceneView
                      forGesture:(UIGestureRecognizer *)gesture {
    SCNHitTestResult *hitResult = [[sceneView hitTest:[gesture locationInView:sceneView]
                                              options:nil] firstObject];
    if ([hitResult.node.name isEqualToString:kTVNode] ||
        [hitResult.node.name isEqualToString:kVideoRendererNode]) {
        return [sceneView.scene.rootNode childNodeWithName:kMediaPlayerNode
                                               recursively:NO];
    }

    return nil;
}

@end
