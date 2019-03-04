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

+ (instancetype)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    });
    
    return dateFormatter;
}

+ (NSString *)currentTimeStringForTime:(CMTime)time {
    Float64 seconds = CMTimeGetSeconds(time);
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatter];
    
    NSString *dateFormat = @"mm:ss";
    NSUInteger hours = seconds / 3600;
    if (hours > 0) {
        dateFormat = @"HH:mm:ss";
    }
    
    [dateFormatter setDateFormat:dateFormat];
    NSString *currentTime = [dateFormatter stringFromDate:date];
    
    return currentTime;
}

@end
