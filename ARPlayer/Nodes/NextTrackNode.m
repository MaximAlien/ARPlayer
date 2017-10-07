//
//  NextTrackNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 10/4/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "NextTrackNode.h"

@implementation NextTrackNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setGeometry:[self nextTrackShape]];
    }
    
    return self;
}

- (SCNShape *)nextTrackShape {
    UIBezierPath *nextTrackPath = [UIBezierPath bezierPath];
    [nextTrackPath moveToPoint:CGPointZero];
    [nextTrackPath addLineToPoint:CGPointMake(0.04f, 0.018f)];
    
    [nextTrackPath addLineToPoint:CGPointMake(0.04f, 0.0f)];
    [nextTrackPath addLineToPoint:CGPointMake(0.05f, 0.0f)];
    [nextTrackPath addLineToPoint:CGPointMake(0.05f, 0.04f)];
    [nextTrackPath addLineToPoint:CGPointMake(0.04f, 0.04f)];
    [nextTrackPath addLineToPoint:CGPointMake(0.04f, 0.022f)];
    
    [nextTrackPath addLineToPoint:CGPointMake(0.0f, 0.04f)];
    [nextTrackPath closePath];
    
    SCNShape *shape = [SCNShape shapeWithPath:nextTrackPath extrusionDepth:0.02f];
    shape.firstMaterial.diffuse.contents = [UIColor blackColor];
    
    return shape;
}

@end
