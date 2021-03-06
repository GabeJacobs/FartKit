//
//  ViewController.m
//  SpriteKitDemo
//
//  Created by Gabe Jacobs on 9/25/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import "CameraViewController.h"
#import "Scene.h"
#import "Plane.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SelectFartViewController.h"

@interface CameraViewController () <ARSKViewDelegate>

@end


@implementation CameraViewController

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(changedSelection:)
												 name:@"changeSelection"
											   object:nil];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSInteger selection = [defaults integerForKey:@"selectedFart"];
	self.currentFartIndex = selection;
	
	self.sceneView = [[ARSKView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:self.sceneView];
	
	self.currentTrackingState = ARTrackingStateNormal;
	self.sceneView.delegate = self;
	
	self.arConfig = [ARWorldTrackingConfiguration new];
	[UIApplication.sharedApplication setIdleTimerDisabled:YES];

	CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGFloat screenWidth = screenRect.size.width;
	CGFloat screenHeight = screenRect.size.height;
	
	self.record = [UIButton buttonWithType:UIButtonTypeCustom];
	self.record.tag = 0;
	self.record.contentMode = UIViewContentModeCenter;
	[self.record setImage:[UIImage imageNamed:@"Record"] forState:UIControlStateNormal];
	self.record.frame = CGRectMake(20, screenHeight - self.record.imageView.image.size.height - 20, self.record.imageView.image.size.width, self.record.imageView.image.size.height);
	[self.record addTarget:self action:@selector(tappedRecord) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.record];
	
	[self setupAnimations];
	
	self.screenRecorder = [RPScreenRecorder sharedRecorder];
	self.screenRecorder.delegate = self;
	
	[self reset];
	[self startJacker];
	
	self.watermark = [[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"Watermark"]];
	self.watermark.frame = CGRectMake(self.view.frame.size.width - (self.watermark.image.size.width * .80) - 15, 20, self.watermark.image.size.width*.80, self.watermark.image.size.height*.80);
	[self.view addSubview:self.watermark];
	
	
//	GADRequest *request = [GADRequest request];
//	request.testDevices = @[@"17904f4502ce5ba33bf6e9fb824b420f"]; // Sample device ID
//	self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
//	self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
//	self.bannerView.rootViewController = self;
//	self.bannerView.alpha = 1.0;
//	self.bannerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.bannerView.frame.size.height);
//	self.bannerWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 0)];
//	self.bannerWindow.rootViewController = self;
//	[self.bannerWindow makeKeyAndVisible];
//	[self.bannerWindow addSubview:self.bannerView];
//	self.bannerView.delegate = self;
//	[self.bannerView loadRequest:[GADRequest request]];
//	self.bannerWindow.hidden = YES;

	self.flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.flashButton.tag = 0;
	self.flashButton.contentMode = UIViewContentModeCenter;
	[self.flashButton setImage:[UIImage imageNamed:@"Flash"] forState:UIControlStateNormal];
	self.flashButton.frame = CGRectMake(15, 15, [UIImage imageNamed:@"Flash"].size.width*.9, [UIImage imageNamed:@"Flash"].size.height*.9);
	[self.flashButton addTarget:self action:@selector(tappedFlash) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.flashButton];
	
	self.moreFartsButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.moreFartsButton.tag = 0;
	self.moreFartsButton.contentMode = UIViewContentModeCenter;
	[self.moreFartsButton setImage:[UIImage imageNamed:@"MoreFarts"] forState:UIControlStateNormal];
	self.moreFartsButton.frame = CGRectMake(screenWidth - self.moreFartsButton.imageView.image.size.width - 20, screenHeight - self.moreFartsButton.imageView.image.size.height - 20, self.moreFartsButton.imageView.image.size.width, self.moreFartsButton.imageView.image.size.height);
	
	[self.moreFartsButton addTarget:self action:@selector(tappedMoreFarts) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.moreFartsButton];
}

- (void)tappedMoreFarts {
	SelectFartViewController *moreFartsVC = [[SelectFartViewController alloc] init];
	[self.navigationController pushViewController:moreFartsVC animated:YES];
}

- (void)tappedFlash {		
		AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
		if([device hasTorch]){
			if(self.flashButton.tag == 0){
				[device lockForConfiguration:nil];
				[device setTorchMode:AVCaptureTorchModeOn];
				self.flashButton.tag = 1;
			} else{
				[device lockForConfiguration:nil];
				[device setTorchMode:AVCaptureTorchModeOff];
				self.flashButton.tag = 0;
			}
			[device unlockForConfiguration];
		} else {
			UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Flashlight is unavailable!"
																		  message:nil
																   preferredStyle:UIAlertControllerStyleAlert];
			
			UIAlertAction*yesButton = [UIAlertAction actionWithTitle:@"Okay"
															   style:UIAlertActionStyleDefault
															 handler:nil];
			
			[alert addAction:yesButton];
			[self presentViewController:alert animated:YES completion:nil];
		}
}
- (void)setupAnimations {
	
	self.texturesLeft = [NSMutableArray array];
	self.texturesRight = [NSMutableArray array];
	
	// 1 normal
	
	NSMutableArray *textureArrayRight = [NSMutableArray array];
	SKTextureAtlas *textureAtlasRight = [SKTextureAtlas atlasNamed:@"Smoke2"];
	int numImagesRight = textureAtlasRight.textureNames.count;
	for (int i=0; i <= (numImagesRight-1); i++) {
		NSString *textureName;
		if(i>=0 && i<10){
			textureName = [NSString stringWithFormat:@"Smoke20%d", i];
		} else if(i>=10 && i<100){
			textureName = [NSString stringWithFormat:@"Smoke2%d", i];
		}
		[textureArrayRight addObject:[SKTexture textureWithImageNamed:textureName]];
	}
	[self.texturesRight addObject:textureArrayRight];
	
	self.videoNodeRight = [[SKSpriteNode alloc] initWithImageNamed:textureAtlasRight.textureNames[0]];
	self.videoNodeRight.size = CGSizeMake(self.videoNodeRight.size.width*1.4, self.videoNodeRight.size.height*1.4);
	
	NSMutableArray *textureArrayLeft = [NSMutableArray array];
	SKTextureAtlas *textureAtlasLeft = [SKTextureAtlas atlasNamed:@"Smoke"];
	int numImagesLeft = textureAtlasLeft.textureNames.count;
	for (int i=0; i <= (numImagesLeft-1); i++) {
		NSString *textureName;
		if(i>=0 && i<10){
			textureName = [NSString stringWithFormat:@"Smoke0%d", i];
		} else if(i>=10 && i<100){
			textureName = [NSString stringWithFormat:@"Smoke%d", i];
		}
		[textureArrayLeft addObject:[SKTexture textureWithImageNamed:textureName]];
	}
	self.videoNodeLeft = [[SKSpriteNode alloc] initWithImageNamed:textureAtlasLeft.textureNames[0]];
	self.videoNodeLeft.size = CGSizeMake(self.videoNodeLeft.size.width*1.4, self.videoNodeLeft.size.height*1.4);
	
	[self.texturesLeft addObject:textureArrayLeft];

	// 2 lazer
	
	textureArrayRight = [NSMutableArray array];
	numImagesRight = 35;
	for (int i=0; i <= (numImagesRight-1); i++) {
		NSString *textureName;
		if(i>=0 && i<10){
			textureName = [NSString stringWithFormat:@"laserR_0000%d", i];
		} else if(i>=10 && i<100){
			textureName = [NSString stringWithFormat:@"laserR_000%d", i];
		}
		[textureArrayRight addObject:[SKTexture textureWithImageNamed:textureName]];
	}
	[self.texturesRight addObject:textureArrayRight];
	
	textureArrayLeft = [NSMutableArray array];
	numImagesLeft = 35;
	for (int i=0; i <= (numImagesLeft-1); i++) {
		NSString *textureName;
		if(i>=0 && i<10){
			textureName = [NSString stringWithFormat:@"laserL_0000%d", i];
		} else if(i>=10 && i<100){
			textureName = [NSString stringWithFormat:@"laserL_000%d", i];
		}
		[textureArrayLeft addObject:[SKTexture textureWithImageNamed:textureName]];
	}

	[self.texturesLeft addObject:textureArrayLeft];
	
	textureArrayRight = [NSMutableArray array];
	numImagesRight = 132;
	for (int i=0; i <= (numImagesRight); i++) {
		NSString *textureName;
		if(i>=0 && i<10){
			textureName = [NSString stringWithFormat:@"bombR00%d", i];
		} else if(i>=10 && i<100){
			textureName = [NSString stringWithFormat:@"bombR0%d", i];
		} else if(i>=100 && i<1000){
			textureName = [NSString stringWithFormat:@"bombR%d", i];
		}
		[textureArrayRight addObject:[SKTexture textureWithImageNamed:textureName]];
	}
	[self.texturesRight addObject:textureArrayRight];
	
	
	textureArrayLeft = [NSMutableArray array];
	numImagesLeft = 132;
	for (int i=0; i <= (numImagesLeft); i++) {
		NSString *textureName;
		if(i>=0 && i<10){
			textureName = [NSString stringWithFormat:@"bombL00%d", i];
		} else if(i>=10 && i<100){
			textureName = [NSString stringWithFormat:@"bombL0%d", i];
		} else if(i>=100 && i<1000){
			textureName = [NSString stringWithFormat:@"bombL%d", i];
		}
		[textureArrayLeft addObject:[SKTexture textureWithImageNamed:textureName]];
	}
	
	[self.texturesLeft addObject:textureArrayLeft];
	
	// 3 squeaker
	
}

- (void)startJacker {
	Scene *scene = (Scene *)[SKScene nodeWithFileNamed:@"Scene"];
	[self.sceneView presentScene:scene];
	[self.sceneView.session runWithConfiguration:self.arConfig];
	[scene initAudioPlayer];

}


- (void)startRecording {
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"instructions"];
	if([self.screenRecorder isAvailable]){
		[self.screenRecorder setMicrophoneEnabled:YES];
		self.record.tag = 1;
		[self.record setImage:[UIImage imageNamed:@"Recording"] forState:UIControlStateNormal];
		self.record.frame = CGRectMake(20, self.record.frame.origin.y, self.record.imageView.image.size.width, self.record.imageView.image.size.height);
		[self.screenRecorder startRecordingWithHandler:^(NSError * _Nullable error) {
			if(error){
				UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Please give permission to record your screen"
																			  message:nil
																	   preferredStyle:UIAlertControllerStyleAlert];
				
				UIAlertAction*yesButton = [UIAlertAction actionWithTitle:@"Okay"
																   style:UIAlertActionStyleDefault
																 handler:nil];
				
				[alert addAction:yesButton];
				[self presentViewController:alert animated:YES completion:nil];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					self.record.tag = 0;
					[self.record setImage:[UIImage imageNamed:@"Record"] forState:UIControlStateNormal];
					self.record.frame = CGRectMake(20, self.record.frame.origin.y, self.record.imageView.image.size.width, self.record.imageView.image.size.height);
				});
				
			} else {
				
			}
		}];
	}
}

- (void)tappedRecord {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	BOOL shownInfo = [defaults boolForKey:@"instructions"];
	if(!shownInfo){
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Microphone access"
																	  message:@"Select \"Record Screen & Microphone\" on the next screen so that we can record the video with sound."
															   preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction*yesButton = [UIAlertAction actionWithTitle:@"Okay"
														   style:UIAlertActionStyleDefault
														 handler:^(UIAlertAction * _Nonnull action) {
															 [self startRecording];
														 }];
		[alert addAction:yesButton];
		[self presentViewController:alert animated:YES completion:nil];
	} else {
		if(self.record.tag == 0){
			[self startRecording];
		} else {
			self.record.tag = 0;
			[self.record setImage:[UIImage imageNamed:@"Record"] forState:UIControlStateNormal];
			self.record.frame = CGRectMake(20, self.record.frame.origin.y, self.record.imageView.image.size.width, self.record.imageView.image.size.height);
			
			[self.screenRecorder stopRecordingWithHandler:^(RPPreviewViewController *previewController,NSError *error){
				[self presentViewController:previewController animated:YES completion:nil];
//				self.bannerWindow.hidden = YES;
				previewController.previewControllerDelegate = self;
				
			}];
		}
	}
}
- (void)hideDirections {
	[UIView animateWithDuration:2.0 animations:^{
		self.directions.alpha = 0.0;
	}];
}

- (void)viewDidAppear:(BOOL)animated{
	[self.sceneView.session runWithConfiguration:self.arConfig];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

	// Run the view's session
//    [self.sceneView.session runWithConfiguration:self.arConfig];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSKViewDelegate

- (SKNode *)view:(ARSKView *)view nodeForAnchor:(ARAnchor *)anchor {
	
    // Create and configure a node for the anchor added to the view's session.
	[self.videoNodeRight removeFromParent];
	[self.videoNodeLeft removeFromParent];

	Scene *currentScene = (Scene *)self.sceneView.scene;
	if(!currentScene.swipedRight){
		SKAction *animation = [SKAction animateWithTextures:self.texturesLeft[self.currentFartIndex] timePerFrame:(1.0/24.0)];
		[self.videoNodeRight runAction:animation completion:^{

		}];
		return self.videoNodeRight;
	}

	SKAction *animation = [SKAction animateWithTextures:self.texturesRight[self.currentFartIndex] timePerFrame:(1.0/24.0)];
	[self.videoNodeLeft runAction:animation completion:^{

	}];
	return self.videoNodeLeft;

}


#pragma mark - ARSCNViewDelegate

- (void)renderer:(id <SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time {

}

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
	
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
	
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {

}
- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}


- (void)showMessage:(NSString *)message {
}

- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera {

}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {

}

- (void)sessionWasInterrupted:(ARSession *)session {


}

- (void)sessionInterruptionEnded:(ARSession *)session {

}



-(void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithPreviewViewController:(RPPreviewViewController *)previewViewController error:(NSError *)error {
	
	if(error){
		dispatch_async(dispatch_get_main_queue(), ^{
			self.record.tag = 0;
			[self.record setImage:[UIImage imageNamed:@"Record"] forState:UIControlStateNormal];
			self.record.frame = CGRectMake(20, self.record.frame.origin.y, self.record.imageView.image.size.width, self.record.imageView.image.size.height);
		});
	}
	
	
}
- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
	[self dismissViewControllerAnimated:previewController completion:^{
//		self.bannerWindow.hidden = NO;
		[self.sceneView.session runWithConfiguration:self.arConfig];
	}];
}


- (void)screenRecorderDidChangeAvailability:(RPScreenRecorder *)screenRecorder {

}

-(BOOL)prefersStatusBarHidden {
	return YES;
}

- (void)reset {
	self.record.tag = 0;
	[self.record setImage:[UIImage imageNamed:@"Record"] forState:UIControlStateNormal];
	self.record.frame = CGRectMake(20, self.record.frame.origin.y, self.record.imageView.image.size.width, self.record.imageView.image.size.height);
	
}


- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
	[UIView beginAnimations:@"Bannerfade" context:nil];
	[UIView setAnimationDuration:.7];
	bannerView.alpha = 1.0;
	[UIView commitAnimations];
}

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error {
	[UIView beginAnimations:@"Bannerfade" context:nil];
	[UIView setAnimationDuration:.7];
	bannerView.alpha = 0.0;
	[UIView commitAnimations];
}

// selection

- (void)changedSelection:(NSNotification *) notification {
	self.currentFartIndex = [[notification object] integerValue];
}
@end
