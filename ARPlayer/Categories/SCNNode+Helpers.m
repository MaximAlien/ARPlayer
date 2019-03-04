//
//  SCNNode+Helpers.m
//  ARPlayer
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "SCNNode+Helpers.h"

@implementation SCNNode (Helpers)

- (SCNVector3)boundingBox {
    SCNVector3 min = SCNVector3Zero;
    SCNVector3 max = SCNVector3Zero;
    [self getBoundingBoxMin:&min max:&max];

    CGFloat width = max.x - min.x;
    CGFloat height = max.y - min.y;
    CGFloat length = max.z - min.z;

    return SCNVector3Make(width, height, length);
}

@end
