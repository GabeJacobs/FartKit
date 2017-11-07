//
//  ViewController.h
//  SpriteKitDemo
//
//  Created by Gabe Jacobs on 9/25/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <ARKit/ARKit.h>
#import "Plane.h"
#import "Config.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@import ReplayKit;

@interface CameraViewController : UIViewController <RPScreenRecorderDelegate, RPPreviewViewControllerDelegate, GADBannerViewDelegate>

- (void)setupScene;
- (void)setupLights;
- (void)setupPhysics;
- (void)setupRecognizers;
- (void)updateConfig;
- (void)hidePlanes;
- (void)refresh;

@property (nonatomic) int currentFartIndex;

@property (nonatomic, strong) NSMutableArray *texturesRight;
@property (nonatomic, strong) NSMutableArray *texturesLeft;
@property (nonatomic, retain) NSMutableDictionary<NSUUID *, Plane *> *planes;
@property (nonatomic) ARTrackingState currentTrackingState;
@property (nonatomic, retain) ARWorldTrackingConfiguration *arConfig;
@property (nonatomic) BOOL touchedOnce;
@property (nonatomic, strong) SKSpriteNode *videoNodeRight;
@property (nonatomic, strong) SKSpriteNode *videoNodeLeft;
@property (nonatomic, strong) UILabel *directions;
@property (nonatomic, strong) UIButton *record;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) ARSKView *sceneView;
@property (nonatomic) BOOL initialized;
@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *videoInput;
@property (nonatomic, strong) AVAssetWriterInput *micInput;
@property (nonatomic, strong) UIImageView *watermark;
@property (nonatomic,strong) GADBannerView *bannerView;
@property (nonatomic,strong) UIWindow *bannerWindow;

@property (nonatomic, strong) RPScreenRecorder *screenRecorder;


@end
