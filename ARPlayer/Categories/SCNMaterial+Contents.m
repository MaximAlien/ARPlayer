//
//  SCNMaterial+Contents.m
//  ARPlayer
//
//  Created by Maxim Makhun on 03/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "SCNMaterial+Contents.h"

@implementation SCNMaterial (Contents)

+ (SCNMaterial *)materialWithColor:(UIColor *)color {
    SCNMaterial *material = [SCNMaterial new];
    material.diffuse.contents = color;

    return material;
}

@end
