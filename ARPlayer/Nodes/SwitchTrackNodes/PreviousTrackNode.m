//
//  PreviousTrackNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "PreviousTrackNode.h"

// Utils
#import "Constants.h"

@implementation PreviousTrackNode

- (instancetype)init {
    self = [super init];

    if (self) {
        self.position = SCNVector3Make(-0.12f, 0.0f, 0.12f);
        self.eulerAngles = SCNVector3Make(M_PI_2, M_PI, 0.0f);
        self.name = kPreviousTrackNode;
    }

    return self;
}

@end
