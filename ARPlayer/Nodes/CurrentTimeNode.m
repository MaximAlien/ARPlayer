//
//  CurrentTimeNode.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/30/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "CurrentTimeNode.h"

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
    SCNText *timeGeometry = [SCNText textWithString:@"00:00" extrusionDepth:0.1f];
    timeGeometry.font = [UIFont systemFontOfSize:0.9f];
    timeGeometry.containerFrame = frame;
    timeGeometry.flatness = 0.005f;
    
    return timeGeometry;
}

- (void)subscribeForPlayerTimeUpdates:(AVPlayer *)player {
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0f, NSEC_PER_SEC)
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

- (void)resetTimeForPlayer:(AVPlayer *)player {
    [player removeTimeObserver:self.timeObserver];
    
    SCNText *textGeometry = (SCNText *)self.geometry;
    textGeometry.string = @"00:00";
    self.geometry = textGeometry;
}

@end
