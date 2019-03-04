//
//  NodePositionHandler.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import ARKit;

#import "NodePositionHandler.h"

// Nodes
#import "MediaPlayerNode.h"

// Utils
#import "SettingsManager.h"
#import "Constants.h"

@implementation NodePositionHandler

- (void)handleGesture:(UIGestureRecognizer *)gesture inSceneView:(ARSCNView *)sceneView {
    NSAssert([gesture isKindOfClass:[UIPanGestureRecognizer class]], @"Different class type is expected.");
    
    if (![SettingsManager instance].repositionAllowed) {
        return;
    }

    CGPoint tapPoint = [gesture locationInView:sceneView];
    if (gesture.state == UIGestureRecognizerStateChanged) {
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

@end
