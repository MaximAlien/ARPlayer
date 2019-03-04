//
//  NodePlaybackHandler.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import ARKit;

#import "NodePlaybackHandler.h"

// Nodes
#import "MediaPlayerNode.h"
#import "SwitchTrackNode.h"
#import "ControlNode.h"

// Utils
#import "Constants.h"

@implementation NodePlaybackHandler

- (void)handleGesture:(UIGestureRecognizer *)gesture inSceneView:(ARSCNView *)sceneView {
    NSAssert([gesture isKindOfClass:[UITapGestureRecognizer class]], @"Different class type is expected.");

    CGPoint tapPoint = [gesture locationInView:sceneView];
    NSArray<SCNHitTestResult *> *result = [sceneView hitTest:tapPoint options:nil];
    if (result.count == 0) {
        return;
    }

    SCNHitTestResult *hitResult = [result firstObject];
    MediaPlayerNode *mediaPlayerNode = (MediaPlayerNode *)[sceneView.scene.rootNode childNodeWithName:kMediaPlayerNode
                                                                                          recursively:NO];

    if ([hitResult.node isKindOfClass:[ControlNode class]]) {
        ControlNode *node = (ControlNode *)hitResult.node;
        [node animate];
    }

    if ([hitResult.node.name isEqualToString:kVideoRendererNode]) {
        [mediaPlayerNode togglePlay];
    } else if ([hitResult.node.name isEqualToString:kStopNode]) {
        [mediaPlayerNode stop];
    } else if ([hitResult.node.name isEqualToString:kPlayNode]) {
        [mediaPlayerNode togglePlay];
    } else if ([hitResult.node.name isEqualToString:kNextTrackNode]) {
        [mediaPlayerNode toNextTrack];
    } else if ([hitResult.node.name isEqualToString:kPreviousTrackNode]) {
        [mediaPlayerNode toPreviousTrack];
    }
}

@end
