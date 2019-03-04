//
//  UIImpactFeedbackGenerator+Helpers.m
//  ARPlayer
//
//  Created by Maxim Makhun on 04/03/2019.
//  Copyright © 2019 Maxim Makhun. All rights reserved.
//

#import "UIImpactFeedbackGenerator+Helpers.h"

@implementation UIImpactFeedbackGenerator (Helpers)

+ (UIImpactFeedbackGenerator *)impactFeedbackGeneratorWithStyle:(UIImpactFeedbackStyle)style {
    return [[UIImpactFeedbackGenerator alloc] initWithStyle:style];
}

+ (void)lightImpactOccurred {
    [[UIImpactFeedbackGenerator impactFeedbackGeneratorWithStyle:UIImpactFeedbackStyleLight] impactOccurred];
}

+ (void)mediumImpactOccurred {
    [[UIImpactFeedbackGenerator impactFeedbackGeneratorWithStyle:UIImpactFeedbackStyleMedium] impactOccurred];
}

+ (void)heavyImpactOccurred {
    [[UIImpactFeedbackGenerator impactFeedbackGeneratorWithStyle:UIImpactFeedbackStyleHeavy] impactOccurred];
}

@end
