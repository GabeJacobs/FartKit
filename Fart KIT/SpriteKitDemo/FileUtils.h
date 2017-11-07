//
//  FileUtils.h
//  SpriteKitDemo
//
//  Created by Gabe Jacobs on 10/30/17.
//  Copyright © 2017 Gabe Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

+ (void)createReplaysFolder;
+ (NSString *)filePath;
+ (NSArray *)fetchAllReplays;
@end
