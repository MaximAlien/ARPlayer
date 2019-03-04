//
//  SceneGestureRecognizerDelegate.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import UIKit;
@import ARKit;

#import "SceneGestureRecognizerDelegate.h"

// Nodes
#import "MediaPlayerNode.h"
#import "NodePlaybackHandler.h"
#import "NodeInsertionHandler.h"
#import "NodePositionHandler.h"
#import "NodeRotationHandler.h"
#import "NodeScaleHandler.h"

// Services
#import "PlaylistService.h"

// Utils
#import "Constants.h"
#import "SettingsManager.h"

// Protocols
#import "GestureHandleProtocol.h"

@interface SceneGestureRecognizerDelegate () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) ARSCNView *sceneView;

@end

@implementation SceneGestureRecognizerDelegate

- (instancetype)initWithSceneView:(ARSCNView *)sceneView {
    self = [super init];

    if (self) {
        self.sceneView = sceneView;
        [self setupGestureRecognizers];
    }

    return self;
}

- (void)setupGestureRecognizers {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleGesture:)];
    tapGestureRecognizer.delegate = self;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.sceneView addGestureRecognizer:tapGestureRecognizer];

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                             action:@selector(handleGesture:)];
    longPressGestureRecognizer.delegate = self;
    longPressGestureRecognizer.minimumPressDuration = 1.0f;
    [self.sceneView addGestureRecognizer:longPressGestureRecognizer];

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(handleGesture:)];
    pinchGestureRecognizer.delegate = self;
    [self.sceneView addGestureRecognizer:pinchGestureRecognizer];

    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(handleGesture:)];
    rotationGestureRecognizer.delegate = self;
    [self.sceneView addGestureRecognizer:rotationGestureRecognizer];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleGesture:)];
    panGestureRecognizer.delegate = self;
    [self.sceneView addGestureRecognizer:panGestureRecognizer];
}

#pragma mark - UISceneGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ||
        [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
        return YES;
    }

    return NO;
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    id<GestureHandleProtocol> handler = nil;
    if ([gestureRecognizer isKindOfClass:UITapGestureRecognizer.class]) {
        handler = [NodePlaybackHandler new];
    } else if (([gestureRecognizer isKindOfClass:UILongPressGestureRecognizer.class])) {
        handler = [NodeInsertionHandler new];
    } else if ([gestureRecognizer isKindOfClass:UIPinchGestureRecognizer.class]) {
        handler = [NodeScaleHandler new];
    } else if ([gestureRecognizer isKindOfClass:UIRotationGestureRecognizer.class]) {
        handler = [NodeRotationHandler new];
    } else if ([gestureRecognizer isKindOfClass:UIPanGestureRecognizer.class]) {
        handler = [NodePositionHandler new];
    }

    NSAssert(handler != nil, @"Handler should not be nil");
    [handler handleGesture:gestureRecognizer inSceneView:self.sceneView];
}

@end
