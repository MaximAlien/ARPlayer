//
//  PlayNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/30/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "PlayNode.h"

// Utils
#import "Utils.h"

@implementation PlayNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.eulerAngles = SCNVector3Make(M_PI_2, 0.0f, 0.0f);
        self.position = SCNVector3Make(-0.07f, 0.0f, 0.08f);
        self.name = kPlayNode;
    }
    
    return self;
}

- (SCNShape *)playShape {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(0.04f, 0.02f)];
    [path addLineToPoint:CGPointMake(0.0f, 0.04f)];
    [path closePath];
    
    SCNShape *shape = [SCNShape shapeWithPath:path extrusionDepth:0.02f];
    shape.firstMaterial.diffuse.contents = [UIColor blackColor];
    
    return shape;
}

- (SCNShape *)pauseShape {
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath moveToPoint:CGPointZero];
    [leftPath addLineToPoint:CGPointMake(0.02f, 0.0f)];
    [leftPath addLineToPoint:CGPointMake(0.02f, 0.04f)];
    [leftPath addLineToPoint:CGPointMake(0.0f, 0.04f)];
    [leftPath closePath];
    [leftPath fill];
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath moveToPoint:CGPointMake(0.03f, 0.0f)];
    [rightPath addLineToPoint:CGPointMake(0.05f, 0.0f)];
    [rightPath addLineToPoint:CGPointMake(0.05f, 0.04f)];
    [rightPath addLineToPoint:CGPointMake(0.03f, 0.04f)];
    [rightPath closePath];
    [rightPath fill];
    
    [leftPath appendPath:rightPath];
    
    SCNShape *shape = [SCNShape shapeWithPath:leftPath extrusionDepth:0.02f];
    shape.firstMaterial.diffuse.contents = [UIColor blackColor];
    
    return shape;
}

- (void)updateState:(PlayerState)state {
    switch (state) {
        case StatePlaying:
            [self setGeometry:[self pauseShape]];
            break;
        case StatePaused:
            [self setGeometry:[self playShape]];
            break;
    }
}

@end
