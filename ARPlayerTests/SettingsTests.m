//
//  SettingsTests.m
//  ARPlayerTests
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import XCTest;

#import "Constants.h"
#import "SettingsManager.h"

@interface SettingsTests : XCTestCase

@end

@implementation SettingsTests

- (void)setUp {
    // clean-up all previously saved NSUserDefaults
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[NSBundle mainBundle].bundleIdentifier];
}

- (void)tearDown {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)test1_SettingsAvailable {
    XCTAssertNotNil([SettingsManager instance], @"Settings instance should not be nil.");
}

- (void)test2_ShowPlanes {
    XCTAssertFalse([SettingsManager instance].showPlanes, @"ShowPlanes should be NO.");
    [SettingsManager instance].showPlanes = YES;
    XCTAssertTrue([SettingsManager instance].showPlanes, @"ShowPlanes should be YES.");
}

- (void)test3_VibrateOnTouch {
    XCTAssertFalse([SettingsManager instance].vibrateOnTouch, @"VibrateOnTouch should be NO.");
    [SettingsManager instance].vibrateOnTouch = YES;
    XCTAssertTrue([SettingsManager instance].vibrateOnTouch, @"VibrateOnTouch should be YES.");
}

- (void)test4_AnimateOnTouch {
    XCTAssertFalse([SettingsManager instance].animateOnTouch, @"AnimateOnTouch should be NO.");
    [SettingsManager instance].animateOnTouch = YES;
    XCTAssertTrue([SettingsManager instance].animateOnTouch, @"AnimateOnTouch should be YES.");
}

- (void)test5_ScaleAllowed {
    XCTAssertFalse([SettingsManager instance].scaleAllowed, @"ScaleAllowed should be NO.");
    [SettingsManager instance].scaleAllowed = YES;
    XCTAssertTrue([SettingsManager instance].scaleAllowed, @"ScaleAllowed should be YES.");
}

- (void)test6_RotationAllowed {
    XCTAssertFalse([SettingsManager instance].rotationAllowed, @"RotationAllowed should be NO.");
    [SettingsManager instance].rotationAllowed = YES;
    XCTAssertTrue([SettingsManager instance].rotationAllowed, @"RotationAllowed should be YES.");
}

- (void)test7_RepositionAllowed {
    XCTAssertFalse([SettingsManager instance].repositionAllowed, @"RepositionAllowed should be NO.");
    [SettingsManager instance].repositionAllowed = YES;
    XCTAssertTrue([SettingsManager instance].repositionAllowed, @"RepositionAllowed should be YES.");
}

- (void)test8_ShowPlanes_Notification {
    // subscribe for show/hide planes notification
    __block BOOL notificationReceived = NO;
    [[NSNotificationCenter defaultCenter] addObserverForName:kNotificationShowPlanes
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      XCTAssertTrue([note.name isEqualToString:kNotificationShowPlanes]);
                                                      notificationReceived = YES;
                                                  }];

    XCTAssertFalse([SettingsManager instance].showPlanes, @"ShowPlanes should be NO.");
    [SettingsManager instance].showPlanes = YES;
    XCTAssertTrue([SettingsManager instance].showPlanes, @"ShowPlanes should be YES.");

    XCTAssertTrue(notificationReceived, @"Notification was expected.");
}

@end
