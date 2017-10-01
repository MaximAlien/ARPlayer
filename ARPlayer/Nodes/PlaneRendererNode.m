//
//  PlaneRendererNode.m
//  ARKitExample
//
//  Created by Maxim Makhun on 9/7/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "PlaneRendererNode.h"

@interface PlaneRendererNode ()

@property (nonatomic,strong) ARPlaneAnchor *anchor;
@property (nonatomic,strong) SCNBox *planeGeometry;

@end

@implementation PlaneRendererNode

- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor visible:(BOOL)visible {
    self = [super init];
    
    if (self) {
        self.name = @"plane_renderer";
        
        self.anchor = anchor;
        float width = anchor.extent.x;
        float length = anchor.extent.z;
        
        float planeHeight = 0.01f;
        self.planeGeometry = [SCNBox boxWithWidth:width
                                           height:planeHeight
                                           length:length
                                    chamferRadius:0];
        
        SCNMaterial *material = [SCNMaterial new];
        material.diffuse.contents = [[UIColor greenColor] colorWithAlphaComponent:0.3f];
        
        SCNMaterial *transparentMaterial = [SCNMaterial new];
        transparentMaterial.diffuse.contents = [UIColor colorWithWhite:1.0f alpha:0.0f];
        
        if (visible) {
            self.planeGeometry.materials = @[transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, material, transparentMaterial];
        } else {
            self.planeGeometry.materials = @[transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial];
        }
        
        SCNNode *planeNode = [SCNNode nodeWithGeometry:self.planeGeometry];
        planeNode.position = SCNVector3Make(0, -planeHeight, 0);
        planeNode.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeKinematic
                                                       shape:[SCNPhysicsShape shapeWithGeometry:self.planeGeometry options:nil]];
        
        [self addChildNode:planeNode];
    }

    return self;
}

- (void)update:(ARPlaneAnchor *)anchor {
    self.planeGeometry.width = anchor.extent.x;
    self.planeGeometry.length = anchor.extent.z;
    
    self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
    
    SCNNode *node = [self.childNodes firstObject];
    node.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeKinematic
                                              shape:[SCNPhysicsShape shapeWithGeometry:self.planeGeometry options:nil]];
}

- (void)hide {
    SCNMaterial *transparentMaterial = [SCNMaterial new];
    transparentMaterial.diffuse.contents = [UIColor colorWithWhite:1.0f alpha:0.0f];
    self.planeGeometry.materials = @[transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial];
}

- (void)show {
    SCNMaterial *material = [SCNMaterial new];
    material.diffuse.contents = [[UIColor greenColor] colorWithAlphaComponent:0.3f];
    
    SCNMaterial *transparentMaterial = [SCNMaterial new];
    transparentMaterial.diffuse.contents = [UIColor colorWithWhite:1.0f alpha:0.0f];
    self.planeGeometry.materials = @[transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, material, transparentMaterial];
}

@end
