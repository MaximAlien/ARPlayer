//
//  VideoRendererNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 05/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "VideoRendererNode.h"

// Utils
#import "Constants.h"

// Categories
#import "SCNNode+Helpers.h"
#import "SCNMaterial+Contents.h"

@implementation VideoRendererNode

- (instancetype)initWithParentNode:(SCNNode *)node {
    self = [super init];

    if (self) {
        SCNVector3 vector = [node boundingBox];
        self.geometry = [SCNBox boxWithWidth:vector.x - 0.04f
                                      height:vector.z - 0.06f
                                      length:0.005f
                               chamferRadius:0.0f];

        [self setupNode];
    }

    return self;
}

- (void)setupNode {
    self.position = SCNVector3Make(0.0f, -0.008f, 0.01f);
    self.eulerAngles = SCNVector3Make(M_PI_2, 0.0f, 0.0f);
    self.name = kVideoRendererNode;

    self.geometry.firstMaterial = [SCNMaterial materialWithColor:[UIColor blackColor]];
}

- (void)animate {
    // VideoRendererNode doesn't have animation ability.
}

@end
