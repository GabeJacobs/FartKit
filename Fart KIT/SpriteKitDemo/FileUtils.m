//
//  FileUtils.m
//  SpriteKitDemo
//
//  Created by Gabe Jacobs on 10/30/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import "FileUtils.h"

@implementation FileUtils

+ (void)createReplaysFolder {
	
	NSArray *documentDirectoryPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectoryPath = [documentDirectoryPathArray firstObject];
	NSString *replayDirectoryPath = [documentDirectoryPath stringByAppendingString:@"/Replays"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if(![fileManager fileExistsAtPath:replayDirectoryPath]){
		[fileManager createDirectoryAtPath:replayDirectoryPath withIntermediateDirectories:NO attributes:nil error:nil];
	}
}

//+ (NSString*)filePath:(NSString *fileName) {
//	[FileUtils createReplaysFolder];
//	NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths firstObject];
//	NSString *filePath = [NSString stringWithFormat:@"%@/Replays/%@.mp4", documentsDirectory, fileName];
//	return filePath
//}
@end
