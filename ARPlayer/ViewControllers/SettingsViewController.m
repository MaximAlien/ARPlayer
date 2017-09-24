//
//  SettingsViewController.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/24/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

#import "SettingsViewController.h"

#import "SettingsManager.h"

@interface SettingsViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *showPlanesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *vibrateOnTouchSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *animateOnTouchSwitch;


@end

@implementation SettingsViewController

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self.showPlanesSwitch setOn:[SettingsManager instance].showPlanes];
        [self.vibrateOnTouchSwitch setOn:[SettingsManager instance].vibrateOnTouch];
        [self.animateOnTouchSwitch setOn:[SettingsManager instance].animateOnTouch];
    }
    
    return self;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (IBAction)showPlanes:(UISwitch *)sender {
    [SettingsManager instance].showPlanes = sender.isOn;
}

- (IBAction)vibrateOnTouch:(UISwitch *)sender {
    [SettingsManager instance].vibrateOnTouch = sender.isOn;
}

- (IBAction)animateOnTouch:(UISwitch *)sender {
    [SettingsManager instance].animateOnTouch = sender.isOn;
}

@end
