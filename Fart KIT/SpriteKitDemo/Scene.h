//
//  Scene.h
//  SpriteKitDemo
//
//  Created by Gabe Jacobs on 9/25/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <ARKit/ARKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Scene : SKScene <AVAudioPlayerDelegate>

@property (nonatomic) int currentFartIndex;
@property (strong, nonatomic) NSMutableArray *anchors;
@property (nonatomic) BOOL touchedOnce;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioPlayer *player2;
@property (nonatomic) CGPoint startPosition;
@property (nonatomic) BOOL swipedRight;

- (void)initAudioPlayer;

@end
