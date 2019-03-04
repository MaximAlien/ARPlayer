//
//  NSDateFormatter+Helpers.m
//  ARPlayer
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import CoreMedia;

#import "NSDateFormatter+Helpers.h"

@implementation NSDateFormatter (Helpers)

+ (NSString *)toString:(CMTime)time {
    Float64 seconds = CMTimeGetSeconds(time);
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:(NSUInteger)(seconds / 3600) > 0 ? @"HH:mm:ss" : @"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    NSString *currentTime = [dateFormatter stringFromDate:date];

    return currentTime;
}

@end
