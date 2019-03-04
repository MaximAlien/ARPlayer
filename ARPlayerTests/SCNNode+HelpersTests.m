//
//  SCNNode+HelpersTests.m
//  ARPlayerTests
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

@import XCTest;
@import SceneKit;

#import "SCNNode+Helpers.h"

@interface SCNNode_HelpersTests : XCTestCase

@end

@implementation SCNNode_HelpersTests

- (void)setUp {

}

- (void)tearDown {

}

- (void)test1_BoundingBox_Box {
    CGFloat width = 1.9f;
    CGFloat height = 1.2f;
    CGFloat length = 1.1f;

    SCNGeometry *geometry = [SCNBox boxWithWidth:width
                                          height:height
                                          length:length
                                   chamferRadius:0];
    SCNNode *node = [SCNNode nodeWithGeometry:geometry];
    XCTAssertEqual([node boundingBox].x, width, @"Widths are not equal.");
    XCTAssertEqual([node boundingBox].y, height, @"Heights are not equal.");
    XCTAssertEqual([node boundingBox].z, length, @"Lengths are not equal.");
}

- (void)test1_BoundingBox_Pyramid {
    CGFloat width = 1.9f;
    CGFloat height = 1.2f;
    CGFloat length = 1.1f;

    SCNGeometry *geometry = [SCNPyramid pyramidWithWidth:width
                                                  height:height
                                                  length:length];
    SCNNode *node = [SCNNode nodeWithGeometry:geometry];
    XCTAssertEqual([node boundingBox].x, width, @"Widths are not equal.");
    XCTAssertEqual([node boundingBox].y, height, @"Heights are not equal.");
    XCTAssertEqual([node boundingBox].z, length, @"Lengths are not equal.");
}

- (void)test1_BoundingBox_Sphere {
    CGFloat radius = 2.0f;

    SCNGeometry *geometry = [SCNSphere sphereWithRadius:radius];
    SCNNode *node = [SCNNode nodeWithGeometry:geometry];
    XCTAssertEqual([node boundingBox].x, radius * 2, @"Widths are not equal.");
    XCTAssertEqual([node boundingBox].y, radius * 2, @"Heights are not equal.");
    XCTAssertEqual([node boundingBox].z, radius * 2, @"Lengths are not equal.");
}

@end
