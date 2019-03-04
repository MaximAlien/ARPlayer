//
//  SCNMaterial+ColorsTests.m
//  ARPlayerTests
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import XCTest;

#import "SCNMaterial+Colors.h"

@interface SCNMaterial_ColorsTests : XCTestCase

@end

@implementation SCNMaterial_ColorsTests

- (void)setUp {

}

- (void)tearDown {

}

- (void)test1_SCNMaterial_Color {
    SCNMaterial *material = [SCNMaterial materialWithColor:[UIColor redColor]];
    XCTAssertNotNil(material.diffuse.contents, @"Contents should not be nil.");
    XCTAssertTrue([material.diffuse.contents isKindOfClass:[UIColor class]], @"Contents should have UIColor type.");
    XCTAssertEqual(material.diffuse.contents, [UIColor redColor], @"Contents should have red color set.");
}

@end
