//
//  NextTrackNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 10/4/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "NextTrackNode.h"
#import "SwitchTrackNode.h"

// Utils
#import "Constants.h"

@implementation NextTrackNode

- (instancetype)init {
    self = [super init];

    if (self) {
        [self setupNode];
    }

    return self;
}

- (void)setupNode {
    self.position = SCNVector3Make(0.12f, 0.0f, 0.08f);
    self.eulerAngles = SCNVector3Make(M_PI_2, 0.0f, 0.0f);
    self.name = kNextTrackNode;
}

@end
