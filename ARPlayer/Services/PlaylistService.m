//
//  PlaylistService.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "PlaylistService.h"

@implementation PlaylistService

+ (NSArray<NSURL *> *)playlist {
    return [NSArray arrayWithObjects:
            [NSURL URLWithString:@"https://devstreaming-cdn.apple.com/videos/tutorials/20181030/209vnatfwjud/Brining_your_apps_to_iPadPro/Brining_your_apps_to_iPadPro_sd.mp4"],
            [NSURL URLWithString:@"https://devstreaming-cdn.apple.com/videos/wwdc/2018/412zw88j5aa4mr9/412/412_sd_advanced_debugging_with_xcode_and_lldb.mp4"],
            [NSURL URLWithString:@"http://devstreaming.apple.com/videos/wwdc/2014/609xxkxq1v95fju/609/609_sd_whats_new_in_scenekit.mov"],
            [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample_video_iTunes" ofType:@"mov"]], nil];
}

@end
