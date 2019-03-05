//
//  PlaneRendererDelegate.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import ARKit;

#import "PlaneRendererDelegate.h"

// Nodes
#import "PlaneRendererNode.h"

// Utils
#import "Constants.h"
#import "SettingsManager.h"

@interface PlaneRendererDelegate ()

@property (nonatomic, strong) NSMutableDictionary *planes;

@end

@implementation PlaneRendererDelegate

- (instancetype)init {
    self = [super init];

    if (self) {
        self.planes = [NSMutableDictionary new];
        [self subscribeForNotifications];
    }

    return self;
}

#pragma mark - ARSCNViewDelegate methods

- (void)renderer:(id <SCNSceneRenderer>)renderer
      didAddNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }

    PlaneRendererNode *plane = [[PlaneRendererNode alloc] initWithAnchor:(ARPlaneAnchor *)anchor
                                                                 visible:[SettingsManager instance].showPlanes];
    [self.planes setObject:plane forKey:anchor.identifier];
    [node addChildNode:plane];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer
   didUpdateNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {
    PlaneRendererNode *plane = [self.planes objectForKey:anchor.identifier];
    if (plane == nil) {
        return;
    }

    [plane update:(ARPlaneAnchor *)anchor];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer
   didRemoveNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {
    [self.planes removeObjectForKey:anchor.identifier];
}

#pragma mark - Helper methods

- (void)subscribeForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPlanes:)
                                                 name:kNotificationShowPlanes
                                               object:nil];
}

- (void)showPlanes:(NSNotification *)notification {
    for (PlaneRendererNode *plane in [self.planes allValues]) {
        if ([SettingsManager instance].showPlanes) {
            [plane show];
        } else {
            [plane hide];
        }
    }
}

@end
