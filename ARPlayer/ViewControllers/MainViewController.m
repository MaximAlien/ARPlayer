//
//  MainViewController.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/24/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;
@import ARKit;

// View Controllers
#import "MainViewController.h"
#import "SettingsViewController.h"

// Nodes
#import "PlayerNode.h"
#import "PlaneRendererNode.h"

// Settings
#import "SettingsManager.h"
#import "Utils.h"

@interface MainViewController () <ARSCNViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;
@property (nonatomic, strong) NSMutableDictionary *planes;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.planes = [NSMutableDictionary new];
    
    [self setupScene];
    [self setupGestureRecognizers];
    [self subscribeForNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    self.sceneView.automaticallyUpdatesLighting = YES;
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.sceneView.session pause];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setupScene {
    self.sceneView.delegate = self;
    self.sceneView.showsStatistics = YES;
    
    SCNScene *scene = [SCNScene scene];
    self.sceneView.scene = scene;
}

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
}

- (void)subscribeForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showPlanes:)
                                                 name:kNotificationShowPlanes
                                               object:nil];
}

- (void)handleGesture:(UIGestureRecognizer *)recognizer {
    CGPoint tapPoint = [recognizer locationInView:self.sceneView];
    
    if ([recognizer isKindOfClass:UITapGestureRecognizer.class]) {
        NSArray<SCNHitTestResult *> *result = [self.sceneView hitTest:tapPoint options:nil];
        if (result.count != 0) {
            SCNHitTestResult *hitResult = [result firstObject];
            if ([hitResult.node.name isEqualToString:@"player_view_node"]) {
                PlayerNode *playerNode = (PlayerNode *)hitResult.node;
                if (playerNode.playerPaused) {
                    [playerNode play];
                } else {
                    [playerNode pause];
                }
            } else if ([hitResult.node.name isEqualToString:@"stop_node"]) {
                PlayerNode *playerNode = (PlayerNode *)hitResult.node.parentNode;
                [Utils handleTouch:hitResult.node];
                [playerNode stop];
            } else if ([hitResult.node.name isEqualToString:@"play_node"]) {
                PlayerNode *playerNode = (PlayerNode *)hitResult.node.parentNode;
                [Utils handleTouch:hitResult.node];
                [playerNode play];
            }
        }
    } else if (([recognizer isKindOfClass:UILongPressGestureRecognizer.class])) {
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            NSArray<ARHitTestResult *> *arHitTestResults = [self.sceneView hitTest:tapPoint
                                                                             types:ARHitTestResultTypeExistingPlaneUsingExtent];
            
            if (arHitTestResults.count != 0) {
                ARHitTestResult *hitResult = [arHitTestResults firstObject];
                
                PlayerNode *playerNode = [PlayerNode new];
                playerNode.geometry = [SCNBox boxWithWidth:0.4f
                                                    height:0.02f
                                                    length:0.25f
                                             chamferRadius:0.0f];
                playerNode.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeStatic shape:nil];
                
                simd_float4 column = hitResult.anchor.transform.columns[3];
                playerNode.position = SCNVector3Make(column.x, column.y + 0.01f, column.z);
                [playerNode play];
                [self.sceneView.scene.rootNode addChildNode:playerNode];
            }
        }
    } else if ([recognizer isKindOfClass:UIPinchGestureRecognizer.class]) {
        static SCNNode *node;
        UIPinchGestureRecognizer *pinchGestureRecognizer = (UIPinchGestureRecognizer *)recognizer;
        
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            NSArray<SCNHitTestResult *> *result = [self.sceneView hitTest:tapPoint options:nil];
            if ([result count] == 0) {
                tapPoint = [recognizer locationOfTouch:0 inView:_sceneView];
                result = [self.sceneView hitTest:tapPoint options:nil];
                if ([result count] == 0) {
                    return;
                }
            }
            
            SCNHitTestResult *hitResult = [result firstObject];
            if ([hitResult.node.name isEqualToString:@"player_view_node"]) {
                node = (PlayerNode *)hitResult.node;
            }
        } else if (recognizer.state == UIGestureRecognizerStateChanged) {
            if (node) {
                CGFloat pinchScaleX = pinchGestureRecognizer.scale * node.scale.x;
                CGFloat pinchScaleY = pinchGestureRecognizer.scale * node.scale.y;
                CGFloat pinchScaleZ = pinchGestureRecognizer.scale * node.scale.z;
                
                [node setScale:SCNVector3Make(pinchScaleX, pinchScaleY, pinchScaleZ)];
            }
            pinchGestureRecognizer.scale = 1;
        } else if (recognizer.state == UIGestureRecognizerStateEnded) {
            node = nil;
        }
    } else if ([recognizer isKindOfClass:UIRotationGestureRecognizer.class]) {
        static SCNNode *node;
        UIRotationGestureRecognizer *rotationGestureRecognizer = (UIRotationGestureRecognizer *)recognizer;
        static CGFloat lastRotation = 0.0f;
        
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            NSArray<SCNHitTestResult *> *result = [self.sceneView hitTest:tapPoint options:nil];
            if ([result count] == 0) {
                tapPoint = [recognizer locationOfTouch:0 inView:_sceneView];
                result = [self.sceneView hitTest:tapPoint options:nil];
                if ([result count] == 0) {
                    return;
                }
            }
            
            SCNHitTestResult *hitResult = [result firstObject];
            if ([hitResult.node.name isEqualToString:@"player_view_node"]) {
                node = (PlayerNode *)hitResult.node;
            }
            
            lastRotation = rotationGestureRecognizer.rotation * (- 180 / M_PI);
        } else if (recognizer.state == UIGestureRecognizerStateChanged) {
            float rotation = rotationGestureRecognizer.rotation * (- 180 / M_PI);
            [node runAction:[SCNAction rotateByX:0
                                               y:rotation - lastRotation
                                               z:0
                                        duration:0.0f]];
            lastRotation = rotation;
        }
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

#pragma mark - ARSCNViewDelegate

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }
    
    PlaneRendererNode *plane = [[PlaneRendererNode alloc] initWithAnchor:(ARPlaneAnchor *)anchor
                                                                 visible:[SettingsManager instance].showPlanes];
    plane.name = @"plane_renderer";
    [self.planes setObject:plane forKey:anchor.identifier];
    [node addChildNode:plane];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    PlaneRendererNode *plane = [self.planes objectForKey:anchor.identifier];
    if (plane == nil) {
        return;
    }
    
    [plane update:(ARPlaneAnchor *)anchor];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    [self.planes removeObjectForKey:anchor.identifier];
}

#pragma mark - ARSessionObserver

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"[%s] Error occured: %@", __FUNCTION__, error.localizedDescription);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:error.localizedDescription
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)sessionWasInterrupted:(ARSession *)session {
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    
}

@end
