//
//  CurrentTimeNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/30/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "CurrentTimeNode.h"

// Categories
#import "NSDateFormatter+Helpers.h"

static NSUInteger const kTimeInterval = 1.0f;
static NSString * const kTimeFormat = @"00:00";

@interface CurrentTimeNode()

@property (nonatomic, strong) id timeObserver;

@end

@implementation CurrentTimeNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        SCNText *geometry = [self createTimeGeometryWithFrame:CGRectMake(0.0f, 0.0f, 1.8f, 1.5f)];
        geometry.alignmentMode = kCAAlignmentCenter;
        
        SCNMaterial *mainMaterial = [SCNMaterial new];
        mainMaterial.diffuse.contents = [UIColor whiteColor];
        geometry.firstMaterial = mainMaterial;
        self.scale = SCNVector3Make(0.02f, 0.02f, 0.02f);
        [self setGeometry:geometry];
    }
    
    return self;
}

- (SCNText *)createTimeGeometryWithFrame:(CGRect)frame {
    SCNText *geometry = [SCNText textWithString:kTimeFormat extrusionDepth:0.1f];
    geometry.font = [UIFont systemFontOfSize:0.9f];
    geometry.containerFrame = frame;
    geometry.flatness = 0.005f;
    
    return geometry;
}

- (void)subscribeForPlayerTimeUpdates:(AVPlayer *)player {
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(kTimeInterval, NSEC_PER_SEC)
                                                             queue:nil
                                                        usingBlock:^(CMTime time) {
                                                            __strong typeof(weakSelf) strongSelf = weakSelf;
                                                            SCNText *textGeometry = (SCNText *)strongSelf.geometry;
                                                            textGeometry.string = [NSDateFormatter toString:time];
                                                            strongSelf.geometry = textGeometry;
                                                        }];
}

- (void)resetTimeForPlayer:(AVPlayer *)player {
    [player removeTimeObserver:self.timeObserver];
    
    SCNText *textGeometry = (SCNText *)self.geometry;
    textGeometry.string = kTimeFormat;
    self.geometry = textGeometry;
}

@end
