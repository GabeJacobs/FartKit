//
//  MainMenuViewController.h
//  
//
//  Created by Gabe Jacobs on 10/27/17.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"

@interface MainMenuNavigationController : UINavigationController

@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UIImageView *titleImage;
@property (nonatomic,strong) UIButton *tutorial;
@property (nonatomic,strong) UIButton *begin;

@end
