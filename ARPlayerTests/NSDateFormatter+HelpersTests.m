//
//  NSDateFormatter+HelpersTests.m
//  ARPlayerTests
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import XCTest;
@import CoreMedia;

#import "NSDateFormatter+Helpers.h"

@interface NSDateFormatter_HelpersTests : XCTestCase

@end

@implementation NSDateFormatter_HelpersTests

- (void)setUp {

}

- (void)tearDown {

}

- (void)test1_ZeroSeconds {
    CMTime time = CMTimeMakeWithSeconds(0, NSEC_PER_SEC);
    NSString *result = [NSDateFormatter currentTimeStringForTime:time];
    XCTAssertTrue([result isEqualToString:@"00:00"]);
}

- (void)test2_SeveralSeconds {
    CMTime time = CMTimeMakeWithSeconds(7, NSEC_PER_SEC);
    NSString *result = [NSDateFormatter currentTimeStringForTime:time];
    XCTAssertTrue([result isEqualToString:@"00:07"]);
}

- (void)test3_SecondsAndMinutes {
    CMTime time = CMTimeMakeWithSeconds(66, NSEC_PER_SEC);
    NSString *result = [NSDateFormatter currentTimeStringForTime:time];
    XCTAssertTrue([result isEqualToString:@"01:06"]);
}

- (void)test4_SecondsAndMinutesAndHours {
    CMTime time = CMTimeMakeWithSeconds(1287, NSEC_PER_SEC);
    NSString *result = [NSDateFormatter currentTimeStringForTime:time];
    XCTAssertTrue([result isEqualToString:@"21:27"]);
}

@end
