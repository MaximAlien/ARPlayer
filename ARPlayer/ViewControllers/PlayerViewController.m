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

// Nodes
#import "PlaneRendererNode.h"

// Utils
#import "SettingsManager.h"
#import "Utils.h"
#import "GestureHandler.h"
#import "Constants.h"
#import "UIViewController+Helpers.h"

@interface PlayerViewController () <ARSCNViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet ARSCNView *sceneView;
@property (nonatomic, strong) NSMutableDictionary *planes;

@end

@implementation PlayerViewController

#pragma mark - UIViewController delegate methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScene];
    [self setupGestureRecognizers];
    [self subscribeForNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (ARConfiguration.isSupported) {
        ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
        configuration.planeDetection = ARPlaneDetectionHorizontal;
        self.sceneView.automaticallyUpdatesLighting = YES;
        [self.sceneView.session runWithConfiguration:configuration];
    } else {
        NSLog(@"[%s] ARConfiguration is not supported.", __FUNCTION__);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!ARConfiguration.isSupported) {
        [self showMessage:@"ARConfiguration is not supported"];
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

- (void)setupScene {
    self.view.backgroundColor = [UIColor blackColor];
    self.planes = [NSMutableDictionary new];
    
    self.sceneView.delegate = self;
    self.sceneView.showsStatistics = NO;
    
    SCNScene *scene = [SCNScene scene];
    self.sceneView.scene = scene;
}

- (void)setupGestureRecognizers {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleGesture:)];
    tapGestureRecognizer.delegate = self;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.sceneView addGestureRecognizer:tapGestureRecognizer];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                             action:@selector(handleGesture:)];
    longPressGestureRecognizer.delegate = self;
    longPressGestureRecognizer.minimumPressDuration = 1.0f;
    [self.sceneView addGestureRecognizer:longPressGestureRecognizer];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(handleGesture:)];
    pinchGestureRecognizer.delegate = self;
    [self.sceneView addGestureRecognizer:pinchGestureRecognizer];
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                          action:@selector(handleGesture:)];
    rotationGestureRecognizer.delegate = self;
    [self.sceneView addGestureRecognizer:rotationGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleGesture:)];
    panGestureRecognizer.delegate = self;
    [self.sceneView addGestureRecognizer:panGestureRecognizer];
}

- (void)subscribeForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPlanes:)
                                                 name:kNotificationShowPlanes
                                               object:nil];
}

#pragma mark - Action handlers

- (IBAction)showSettings:(UIButton *)sender {
    SettingsViewController *settingsViewController = [SettingsViewController new];
    settingsViewController.popoverPresentationController.sourceView = sender;
    settingsViewController.popoverPresentationController.sourceRect = CGRectMake(sender.frame.size.width / 2,
                                                                                 sender.frame.size.height + 5,
                                                                                 0,
                                                                                 0);
    settingsViewController.preferredContentSize = CGSizeMake(self.view.frame.size.width - 100,
                                                             self.view.frame.size.height - 200);
    settingsViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ||
        [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
        return YES;
    }
    
    return NO;
}

- (void)handleGesture:(UIGestureRecognizer *)recognizer {
    if ([recognizer isKindOfClass:UITapGestureRecognizer.class]) {
        [GestureHandler handlePlayback:(UITapGestureRecognizer *)recognizer
                           inSceneView:self.sceneView];
    } else if (([recognizer isKindOfClass:UILongPressGestureRecognizer.class])) {
        [GestureHandler handleInsertion:(UILongPressGestureRecognizer *)recognizer
                            inSceneView:self.sceneView];
    } else if ([recognizer isKindOfClass:UIPinchGestureRecognizer.class]) {
        [GestureHandler handleScale:(UIPinchGestureRecognizer *)recognizer
                        inSceneView:self.sceneView];
    } else if ([recognizer isKindOfClass:UIRotationGestureRecognizer.class]) {
        [GestureHandler handleRotation:(UIRotationGestureRecognizer *)recognizer
                           inSceneView:self.sceneView];
    } else if ([recognizer isKindOfClass:UIPanGestureRecognizer.class]) {
        [GestureHandler handlePosition:(UIPanGestureRecognizer *)recognizer
                           inSceneView:self.sceneView];
    }
}

- (void)showPlanes:(NSNotification *)notification {
    for (PlaneRendererNode *plane in [self.planes allValues]) {
        if ([SettingsManager instance].showPlanes) {
            [plane show];
        } else {
            [plane hide];
        }
    }
}

#pragma mark - ARSCNViewDelegate methods

- (void)renderer:(id <SCNSceneRenderer>)renderer
      didAddNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }
    
    PlaneRendererNode *plane = [[PlaneRendererNode alloc] initWithAnchor:(ARPlaneAnchor *)anchor
                                                                 visible:[SettingsManager instance].showPlanes];
    [self.planes setObject:plane forKey:anchor.identifier];
    [node addChildNode:plane];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer
   didUpdateNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {
    PlaneRendererNode *plane = [self.planes objectForKey:anchor.identifier];
    if (plane == nil) {
        return;
    }
    
    [plane update:(ARPlaneAnchor *)anchor];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer
   didRemoveNode:(SCNNode *)node
       forAnchor:(ARAnchor *)anchor {
    [self.planes removeObjectForKey:anchor.identifier];
}

#pragma mark - ARSessionObserver methods

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"[%s] Error occured: %@", __FUNCTION__, error.localizedDescription);
        [self showMessage:error.localizedDescription];
    }
}

@end
