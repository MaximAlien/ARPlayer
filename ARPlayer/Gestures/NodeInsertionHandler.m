//
//  NodeInsertionHandler.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import ARKit;

#import "NodeInsertionHandler.h"

// Nodes
#import "MediaPlayerNode.h"

// Utils
#import "PlaylistService.h"
#import "Constants.h"

// Categories
#import "UIViewController+Helpers.h"

@implementation NodeInsertionHandler

- (void)handleGesture:(UIGestureRecognizer *)gesture inSceneView:(ARSCNView *)sceneView {
    NSAssert([gesture isKindOfClass:[UILongPressGestureRecognizer class]], @"Different class type is expected.");

    if (gesture.state == UIGestureRecognizerStateBegan) {
        SCNNode *node = [sceneView.scene.rootNode childNodeWithName:kMediaPlayerNode
                                                        recursively:YES];
        if (node != nil) {
            [[UIApplication sharedApplication].keyWindow.rootViewController showMessage:@"It's possible to create only one instance of ARPlayer."];
            return;
        }

        CGPoint tapPoint = [gesture locationInView:sceneView];
        NSArray<ARHitTestResult *> *arHitTestResults = [sceneView hitTest:tapPoint
                                                                    types:ARHitTestResultTypeExistingPlaneUsingExtent];

        if (arHitTestResults.count != 0) {
            ARHitTestResult *hitResult = [arHitTestResults firstObject];
            simd_float4 column = hitResult.anchor.transform.columns[3];

            MediaPlayerNode *mediaPlayerNode = [[MediaPlayerNode alloc] initWithPlaylist:[PlaylistService playlist]];
            mediaPlayerNode.position = SCNVector3Make(column.x, column.y, column.z);
            [mediaPlayerNode play];
            [sceneView.scene.rootNode addChildNode:mediaPlayerNode];
        }
    }
}

@end
