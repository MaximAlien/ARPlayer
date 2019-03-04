//
//  SwitchTrackNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "SwitchTrackNode.h"

// Protocols
#import "PlayerNodeProtocol.h"

@interface SwitchTrackNode () <PlayerNodeProtocol>

@end

@implementation SwitchTrackNode

- (instancetype)init {
    self = [super init];

    if (self) {
        [self setGeometry:[self shape]];
    }

    return self;
}

- (SCNGeometry *)shape {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(0.04f, 0.018f)];

    [path addLineToPoint:CGPointMake(0.04f, 0.0f)];
    [path addLineToPoint:CGPointMake(0.05f, 0.0f)];
    [path addLineToPoint:CGPointMake(0.05f, 0.04f)];
    [path addLineToPoint:CGPointMake(0.04f, 0.04f)];
    [path addLineToPoint:CGPointMake(0.04f, 0.022f)];

    [path addLineToPoint:CGPointMake(0.0f, 0.04f)];
    [path closePath];

    SCNShape *shape = [SCNShape shapeWithPath:path extrusionDepth:0.02f];
    shape.firstMaterial.diffuse.contents = [UIColor blackColor];

    return shape;
}

@end
