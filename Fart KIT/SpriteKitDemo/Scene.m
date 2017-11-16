//
//  Scene.m
//  SpriteKitDemo
//
//  Created by Gabe Jacobs on 9/25/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import "Scene.h"

@implementation Scene

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
	
	self.anchors = [NSMutableArray array];
}

- (void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	//[self playFart];
	
	UITouch *touch = [touches anyObject];
	self.startPosition = [touch locationInView:self.view];

    if (![self.view isKindOfClass:[ARSKView class]]) {
        return;
    }
	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint endPosition = [touch locationInView:self.view];
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGFloat screenWidth = screenRect.size.width;
	CGFloat screenHeight = screenRect.size.height;
	CGFloat ratioY = endPosition.y/screenHeight;
	CGFloat relativeY = ratioY*6;
	CGFloat ratioX = endPosition.x/screenWidth;
	CGFloat relativeX = ratioX*3;

    relativeY = relativeY - 3;
	relativeX = relativeX - 2;

	if(abs(endPosition.x - self.startPosition.x) < 10){
		return;
	}
	if (self.startPosition.x < endPosition.x) {
		
		self.swipedRight = YES;
		[self playFart];
	
		ARSKView *sceneView = (ARSKView *)self.view;
		ARFrame *currentFrame = [sceneView.session currentFrame];
	
		if (currentFrame) {
			// Create a transform with a translation of 0.2 meters in front of the camera
			matrix_float4x4 translation = matrix_identity_float4x4;
			translation.columns[3].y = relativeX;
			translation.columns[3].z = -6;
			translation.columns[3].x = relativeY;

			matrix_float4x4 transform = matrix_multiply(currentFrame.camera.transform, translation);

			// Add a new anchor to the session
			ARAnchor *anchor = [[ARAnchor alloc] initWithTransform:transform];
			[sceneView.session addAnchor:anchor];
		}
		
		
		
	} else {
		[self playFart];
		self.swipedRight = NO;

		CGPoint endPosition = [touch locationInView:self.view];
		CGRect screenRect = [[UIScreen mainScreen] bounds];
		CGFloat screenWidth = screenRect.size.width;
		CGFloat screenHeight = screenRect.size.height;
		CGFloat ratioY = endPosition.y/screenHeight;
		CGFloat relativeY = ratioY*6;
		CGFloat ratioX = endPosition.x/screenWidth;
		CGFloat relativeX = ratioX*3;
		
		relativeY = relativeY - 3;
		relativeX = relativeX - 1;
		ARSKView *sceneView = (ARSKView *)self.view;
		ARFrame *currentFrame = [sceneView.session currentFrame];
		
		if (currentFrame) {
			// Create a transform with a translation of 0.2 meters in front of the camera
			matrix_float4x4 translation = matrix_identity_float4x4;
			translation.columns[3].y = relativeX;
			translation.columns[3].z = -6;
			translation.columns[3].x = relativeY;
			matrix_float4x4 transform = matrix_multiply(currentFrame.camera.transform, translation);
			
			// Add a new anchor to the session
			ARAnchor *anchor = [[ARAnchor alloc] initWithTransform:transform];
			[sceneView.session addAnchor:anchor];
		}
		

	}
}

- (void)initAudioPlayer{
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
	[[AVAudioSession sharedInstance] setActive:NO error:nil];
	
	NSURL *audioPath = [[NSBundle mainBundle] URLForResource:@"Fart" withExtension:@"mp3"];
	self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:nil];
	self.player.delegate = self;
	
	self.player2 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:nil];
	self.player2.delegate = self;
	
	[self.player prepareToPlay];
	[self.player2 prepareToPlay];
}


- (void)playFart {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSInteger selection = [defaults integerForKey:@"selectedFart"];
	switch (selection) {
		case 0: {
			NSURL *audioPath = [[NSBundle mainBundle] URLForResource:@"Fart" withExtension:@"mp3"];
			self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:nil];
			self.player.delegate = self;
			
			self.player2 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:nil];
			self.player2.delegate = self;
			
			[self.player prepareToPlay];
			[self.player2 prepareToPlay];
		}
			break;
			
		case 1: {
			NSURL *audioPath = [[NSBundle mainBundle] URLForResource:@"Fart2" withExtension:@"mp3"];
			self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:nil];
			self.player.delegate = self;
			
			self.player2 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:nil];
			self.player2.delegate = self;
			
			[self.player prepareToPlay];
			[self.player2 prepareToPlay];
		}
			break;
		default:
			break;
	}
	
	if([self.player isPlaying]){
		[self.player2 play];
	} else{
		[self.player play];
	}
}

@end
