//
//  CurrentTimeNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/30/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "CurrentTimeNode.h"

@implementation CurrentTimeNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        SCNText *geometry = [self createTimeGeometryWithFrame:CGRectMake(-0.2f, -0.25f, 0.6f, 0.25f)];
        geometry.alignmentMode = kCAAlignmentCenter;
        
        SCNMaterial *mainMaterial = [SCNMaterial new];
        mainMaterial.diffuse.contents = [UIColor blackColor];
        geometry.firstMaterial = mainMaterial;
        
        self.position = SCNVector3Make(0.0f, 0.0f, -0.2f);
        [self setGeometry:geometry];
    }
    
    return self;
}

- (SCNText *)createTimeGeometryWithFrame:(CGRect)frame {
    SCNText *timeGeometry = [SCNText textWithString:@"00:00" extrusionDepth:0.02f];
    timeGeometry.font = [UIFont systemFontOfSize:0.14f];
    timeGeometry.containerFrame = frame;
    
    return timeGeometry;
}

- (void)subscribeForPlayerTimeUpdates:(AVPlayer *)player {
    __weak typeof(self) weakSelf = self;
    [player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0f, NSEC_PER_SEC)
                                         queue:nil
                                    usingBlock:^(CMTime time) {
                                        Float64 seconds = CMTimeGetSeconds(time);
                                        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
                                        NSDateFormatter *dateFormatter = [NSDateFormatter new];
                                        [dateFormatter setDateFormat:(int)(seconds / 3600) > 0 ? @"HH:mm:ss" : @"mm:ss"];
                                        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                                        
                                        SCNText *textGeometry = (SCNText *)weakSelf.geometry;
                                        textGeometry.string = [dateFormatter stringFromDate:date];
                                        weakSelf.geometry = textGeometry;
                                    }];
}

@end
