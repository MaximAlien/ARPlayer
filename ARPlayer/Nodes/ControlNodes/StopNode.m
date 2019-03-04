//
//  StopNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/30/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "StopNode.h"

// Utils
#import "Constants.h"

// Categories
#import "SCNMaterial+Contents.h"

@implementation StopNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupNode];
    }
    
    return self;
}

- (void)setupNode {
    SCNBox *geometry = [SCNBox boxWithWidth:0.04f
                                     height:0.02f
                                     length:0.04f
                              chamferRadius:0.0f];
    self.geometry = geometry;
    self.position = SCNVector3Make(0.05f, 0.0f, 0.1f);
    self.geometry.firstMaterial = [SCNMaterial materialWithColor:[UIColor blackColor]];
    self.name = kStopNode;
}

@end
