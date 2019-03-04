//
//  PlayerViewController.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/24/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;
@import ARKit;

// View Controllers
#import "PlayerViewController.h"
#import "SettingsViewController.h"

// Delegates
#import "PlaneRendererDelegate.h"
#import "SceneGestureRecognizerDelegate.h"

// Utils
#import "SettingsManager.h"
#import "Constants.h"

// Categories
#import "UIViewController+Helpers.h"

@interface PlayerViewController () <ARSessionObserver>

@property (nonatomic, weak) IBOutlet ARSCNView *sceneView;
@property (nonatomic, strong) PlaneRendererDelegate *planeRendererDelegate;
@property (nonatomic, strong) SceneGestureRecognizerDelegate *sceneGestureRecognizerDelegate;

@end

@implementation PlayerViewController

#pragma mark - UIViewController delegate methods

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupScene];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupConfiguration];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!ARConfiguration.isSupported) {
        [self showMessage:@"ARConfiguration is not supported."];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.sceneView.session pause];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Setting up methods

- (void)setupConfiguration {
    if (ARConfiguration.isSupported) {
        ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
        configuration.planeDetection = ARPlaneDetectionHorizontal;
        self.sceneView.automaticallyUpdatesLighting = YES;
        [self.sceneView.session runWithConfiguration:configuration];
    } else {
        NSLog(@"[%s] ARConfiguration is not supported.", __FUNCTION__);
    }
}

- (void)setupScene {
    self.view.backgroundColor = [UIColor blackColor];

    self.planeRendererDelegate = [PlaneRendererDelegate new];
    self.sceneView.delegate = self.planeRendererDelegate;
    self.sceneView.showsStatistics = NO;

    SCNScene *scene = [SCNScene scene];
    self.sceneView.scene = scene;

    self.sceneGestureRecognizerDelegate = [[SceneGestureRecognizerDelegate alloc] initWithSceneView:self.sceneView];
}

#pragma mark - Action handlers

- (IBAction)showSettings:(UIButton *)sender {
    SettingsViewController *settingsViewController = [SettingsViewController new];
    settingsViewController.popoverPresentationController.sourceView = sender;
    settingsViewController.popoverPresentationController.sourceRect = CGRectMake(sender.frame.size.width / 2,
                                                                                 sender.frame.size.height + 5,
                                                                                 0,
                                                                                 0);
    settingsViewController.preferredContentSize = CGSizeMake(self.view.frame.size.width - 100, 250);
    settingsViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

#pragma mark - ARSessionObserver methods

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"[%s] Error occured: %@", __FUNCTION__, error.localizedDescription);
        [self showMessage:error.localizedDescription];
    }
}

@end
