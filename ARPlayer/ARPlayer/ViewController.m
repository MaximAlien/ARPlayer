//
//  ViewController.m
//  ARPlayer
//
//  Created by Maxim Makhun on 9/21/17.
//  Copyright © 2017 Maxim Makhun. All rights reserved.
//

@import SceneKit;
@import ARKit;

#import "ViewController.h"
#import "PlayerNode.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sceneView.delegate = self;
    self.sceneView.showsStatistics = YES;
    
    SCNScene *scene = [SCNScene scene];
    self.sceneView.scene = scene;
    
    matrix_float4x4 translation = matrix_identity_float4x4;
    translation.columns[3].z = -2;
    
    ARAnchor *anchor = [[ARAnchor alloc] initWithTransform:translation];
    [self.sceneView.session addAnchor:anchor];
    
    [self setupGestureRecognizers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.sceneView.session pause];
}

- (void)setupGestureRecognizers {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.sceneView addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
    CGPoint tapPoint = [recognizer locationInView:self.sceneView];
    NSArray<SCNHitTestResult *> *result = [self.sceneView hitTest:tapPoint options:nil];
    
    if (result.count == 0) {
        return;
    }
    
    SCNHitTestResult *hitResult = [result firstObject];
    if ([hitResult.node.name isEqualToString:@"player"]) {
        PlayerNode *playerNode = (PlayerNode *)hitResult.node;
        if (playerNode.playerPaused) {
            [playerNode play];
        } else {
            [playerNode pause];
        }
    }
}

#pragma mark - ARSCNViewDelegate

- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    PlayerNode *playerNode = [PlayerNode new];
    playerNode.geometry = [SCNPlane planeWithWidth:1.0f height:1.0f];
    [playerNode play];
    
    return playerNode;
}

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

