//
//  NodeScaleHandler.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import ARKit;

#import "NodeScaleHandler.h"

// Utils
#import "SettingsManager.h"
#import "Constants.h"

@implementation NodeScaleHandler

- (void)handleGesture:(UIGestureRecognizer *)gesture inSceneView:(ARSCNView *)sceneView {
    NSAssert([gesture isKindOfClass:[UIPinchGestureRecognizer class]], @"Different class type is expected.");

    if (![SettingsManager instance].scaleAllowed) {
        return;
    }

    static SCNNode *node;
    UIPinchGestureRecognizer *pinchGesture = (UIPinchGestureRecognizer *)gesture;
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        node = [NodeScaleHandler findNodeInSceneView:sceneView
                                          forGesture:pinchGesture];
    } else if (pinchGesture.state == UIGestureRecognizerStateChanged) {
        CGFloat pinchScaleX = pinchGesture.scale * node.scale.x;
        CGFloat pinchScaleY = pinchGesture.scale * node.scale.y;
        CGFloat pinchScaleZ = pinchGesture.scale * node.scale.z;
        node.scale = SCNVector3Make(pinchScaleX, pinchScaleY, pinchScaleZ);
        pinchGesture.scale = 1.0f;
    }
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
