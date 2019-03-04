//
//  PlaneRendererNode.m
//  ARKitExample
//
//  Created by Maxim Makhun on 9/7/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "PlaneRendererNode.h"

// Categories
#import "SCNMaterial+Contents.h"

// Utils
#import "Constants.h"

@interface PlaneRendererNode ()

@property (nonatomic,strong) SCNBox *planeGeometry;

@end

@implementation PlaneRendererNode

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor visible:(BOOL)visible {
    self = [super init];
    
    if (self) {
        self.name = kPlaneRendererNode;
        
        float width = anchor.extent.x;
        float height = 0.01f;
        float length = anchor.extent.z;
        self.planeGeometry = [SCNBox boxWithWidth:width
                                           height:height
                                           length:length
                                    chamferRadius:0];

        if (visible) {
            self.planeGeometry.materials = [self colorMaterials];
        } else {
            self.planeGeometry.materials = [self transparentMaterials];
        }
        
        SCNNode *planeNode = [SCNNode nodeWithGeometry:self.planeGeometry];
        planeNode.position = SCNVector3Make(0, -height, 0);
        planeNode.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeKinematic
                                                       shape:[SCNPhysicsShape shapeWithGeometry:self.planeGeometry options:nil]];
        
        [self addChildNode:planeNode];
    }

    return self;
}

- (void)update:(ARPlaneAnchor *)anchor {
    self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);

    self.planeGeometry.width = anchor.extent.x;
    self.planeGeometry.length = anchor.extent.z;
}

- (void)hide {
    self.planeGeometry.materials = [self transparentMaterials];
}

- (void)show {
    self.planeGeometry.materials = [self colorMaterials];
}

#pragma mark - Helper methods

- (NSArray<SCNMaterial *> *)colorMaterials {
    const NSUInteger capacity = 6;
    NSMutableArray<SCNMaterial *> *transparentMaterials = [[NSMutableArray alloc] initWithCapacity:capacity];
    for (NSUInteger i = 0; i < capacity; ++i) {
        if (i == 4) {
            [transparentMaterials addObject:[SCNMaterial materialWithColor:[[UIColor greenColor] colorWithAlphaComponent:0.3f]]];
        } else {
            [transparentMaterials addObject:[SCNMaterial materialWithColor:[UIColor colorWithWhite:1.0f alpha:0.0f]]];
        }
    }

    return transparentMaterials;
}

- (NSArray<SCNMaterial *> *)transparentMaterials {
    const NSUInteger capacity = 6;
    NSMutableArray<SCNMaterial *> *transparentMaterials = [[NSMutableArray alloc] initWithCapacity:capacity];
    for (NSUInteger i = 0; i < capacity; ++i) {
        [transparentMaterials addObject:[SCNMaterial materialWithColor:[UIColor colorWithWhite:1.0f alpha:0.0f]]];
    }

    return transparentMaterials;
}

@end
